require 'date'
require 'colorize'
module Listable
    def format_description(description)
        "#{description}".ljust(30)
    end

    def format_priority(priority)
        case priority
        when "high"
            " ⇧".colorize(:red)
        when "medium"
            " ⇨".colorize(:yellow)
        when "low"
            " ⇩".colorize(:green)
        when nil
            ""
        else
            raise UdaciListErrors::InvalidPriorityValue, "The priority of provided task is invalid."
        end
    end

    def format_date(d1, d2=nil)
        dates = d1.strftime("%D") if d1
        dates << " -- " + d2.strftime("%D") if d2
        dates = "N/A" if !dates
        return dates
    end
end
