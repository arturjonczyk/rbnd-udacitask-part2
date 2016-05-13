class UdaciList
    attr_reader :title, :items

    def initialize(options={})
        @title = options[:title] || "Untitled List"
        @items = []
    end
    def add(type, description, options={})
        type = type.downcase
        case type
        when 'todo'
            @items.push TodoItem.new(description, options)
        when 'event'
            @items.push EventItem.new(description, options)
        when 'link'
            @items.push LinkItem.new(description, options)
        else
            raise UdaciListErrors::InvalidItemType, "The type of provided task is invalid."
        end
    end
    def delete(index)
        if @items.size >= index
            @items.delete_at(index - 1)
        else
            raise UdaciListErrors::IndexExceedsListSize, "Invalid index number exceeds the size of the list."
        end
    end
    def all
        puts "-" * @title.length
        puts @title
        puts "-" * @title.length
        @items.each_with_index do |item, position|
            puts "#{position + 1}) #{item.details}"
        end
    end
end
