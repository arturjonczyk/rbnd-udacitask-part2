class UdaciList
	attr_reader :title, :items

	def initialize(options = {})
		@title = options[:title] || 'Untitled List'
		@items = []
	end

	def add(type, description, options = {})
		type = type.downcase
		case type
		when 'todo'
			@items.push TodoItem.new(type, description, options)
		when 'event'
			@items.push EventItem.new(type, description, options)
		when 'link'
			@items.push LinkItem.new(type, description, options)
		else
			raise UdaciListErrors::InvalidItemType, 'The type of provided task is invalid.'
		end
	end

	def delete(*args)
		for index in args
		if good_index?(index)
			@items.delete_at(index - 1)
			@items.insert(index - 1, nil)
		else
			raise UdaciListErrors::IndexExceedsListSize, 'Invalid index number exceeds the size of the list.'
		end
	end
	@items.delete_if(&:nil?)
end

def all
	rows = []
	@items.each_with_index do |item, position|
		rows << [(position + 1).to_s, item.details]
	end
	table = Terminal::Table.new(title: @title.colorize(:magenta), rows: rows)
	table.align_column(0, :center)
	puts table
end

def filter(type)
	results = @items.select { |task| task.type == type }
	p !results.empty? ? results : "There aren't any items of '#{type}' type."
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
end
