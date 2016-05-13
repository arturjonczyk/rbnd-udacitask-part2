require 'date'
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

    def format_date(d1, d2=nil)
        dates = d1.strftime("%D") if d1
        dates << " -- " + d2.strftime("%D") if d2
        dates = "N/A" if !dates
        return dates
    end
end
