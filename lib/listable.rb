module Listable
    def format_description(description)
        "#{description}".ljust(30)
    end

    def format_priority(priority)
        value = " ⇧" if priority == "high"
        value = " ⇨" if priority == "medium"
        value = " ⇩" if priority == "low"
        value = "" if !priority
        return value
    end
end
