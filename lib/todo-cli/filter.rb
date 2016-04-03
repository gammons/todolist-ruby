module Todo
  class Filter
    def initialize(todos = [], input = nil)
      @todos = todos.clone
      @input = input
    end

    def filter
      return @todos if @input.nil?
      filter_projects
      filter_contexts
      filter_date
      group
    end

    def group
      g = nil
      @input.scan(/by \w+/) {|m| g = m.gsub(/by /,'') }
      case g
      when "p","project" then group_by_project
      when "c","context" then group_by_context
      else
        @todos
      end
    end

    def grouped?
      @input.scan(/by \w+/).size > 0
    end

    def filter_projects
      projects = Parser.new.projects(@input)
      return @todos if projects.empty?
      @todos = @todos.select {|t| t.projects.any? {|proj| projects.include?(proj) } }
    end

    def filter_contexts
      contexts = Parser.new.contexts(@input)
      return @todos if contexts.empty?
      @todos = @todos.select {|t| t.contexts.any? {|proj| contexts.include?(proj) } }
    end

    def filter_date
      from, to = parse_date_range
      return @todos if from == nil && to == nil
      @todos = @todos.select {|t| t.due && (Date.parse(t.due) >= from) && (Date.parse(t.due) <= to) }
    end

    def parse_date_range
      date_str = @input.split("due ").last
      case date_str
      when "this week"
        now = Date.today
        sunday = now - now.wday
        saturday = now + (6 - now.wday)
        [sunday, saturday]
      when "next week"
        now = Date.today
        sunday = now - now.wday
        saturday = now + (6 - now.wday)
        [sunday + 7, saturday + 7]
      when "tom","tomorrow"
        [Date.today + 1, Date.today + 1]
      when "tod","today"
        [Date.today, Date.today]
      else
        d = Chronic.parse(date_str)
        return if d.nil?
        [d.to_date,d.to_date]
      end
    end

    private

    def group_by_project
      all_projects = @todos.map {|t| t.projects }.flatten.uniq
      grouped = all_projects.map  do |proj|
        {proj => @todos.select {|t| t.projects.include?(proj) } }
      end
      if @todos.any? {|t| t.projects.size == 0 }
        grouped << {"No Project" => @todos.select {|t| t.projects.size == 0 } }
      end
      grouped
    end

    def group_by_context
      all_contexts = @todos.map {|t| t.contexts }.flatten.uniq
      grouped = all_contexts.map  do |cont|
        {cont => @todos.select {|t| t.contexts.include?(cont) } }
      end
      if @todos.any? {|t| t.contexts.size == 0 }
        grouped << {"No Context" => @todos.select {|t| t.contexts.size == 0 } }
      end
      grouped
    end
  end
end
