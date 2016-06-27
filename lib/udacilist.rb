class UdaciList
	attr_reader :title, :items

	@@types = {todo: 'TodoItem', event: 'EventItem', link: 'LinkItem'}

	def initialize(options = {})
		@title = options[:title] || 'Untitled List'
		@items = []
	end

	def add(type, description, options = {})
		type = type.downcase
		if @@types.key?(type.to_sym)
			@items.push get_type(type.to_sym).new(type, description, options)
		else
			raise UdaciListErrors::InvalidItemType, 'The type of provided task is invalid.'
		end
	end

	def delete(*args)
		args.each_with_index do |index|
			if good_index?(index)
				@items.delete_at(index - 1)
				@items.insert(index - 1, nil)
			else
				raise UdaciListErrors::IndexExceedsListSize, 'Invalid index number exceeds the size of the list.'
			end
		end
		@items.delete_if(&:nil?)
	end

	def print_table(elements)
		rows = []
		elements.each_with_index do |item, position|
			rows << [(position + 1).to_s, item.type.capitalize + ':', item.description, item.details]
		end
		table = Terminal::Table.new(title: @title.colorize(:magenta), headings: ['Num', 'Type', 'Name', 'Details'], rows: rows)
		table.align_column(0, :center)
		puts table
	end

	def all
		print_table(@items)
	end

	def filter(type)
		results = @items.select { |task| task.type == type }
		p !results.empty? ? print_table(results) : "There aren't any items of '#{type}' type."
	end

	def change_priority(index, priority)
		if good_index?(index)
			if @items[index - 1].type == 'todo'
				@items[index - 1].change(priority)
			else
				raise UdaciListErrors::InvalidItemType, 'The type of provided task is invalid.'
			end
		else
			raise UdaciListErrors::IndexExceedsListSize, 'Invalid index number exceeds the size of the list.'
		end
	end

	private

	def good_index?(index)
		@items.size >= index
	end

	def get_type(type)
		return Object.const_get(@@types[type])
	end
end
