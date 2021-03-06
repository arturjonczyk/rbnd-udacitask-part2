class TodoItem
	include Listable
	attr_reader :description, :due, :priority, :type

	def initialize(type, description, options={})
		@type = type
		@description = description
		@due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
		@priority = options[:priority]
	end

	def details
		"due: " +
		format_date(@due) +
		format_priority(@priority)
	end

	def change(priority)
		@priority = priority
	end
end
