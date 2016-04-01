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
      @todos
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
        d = Chronic.parse(date_str).to_date
        [d,d]
      end
    end
  end
end
