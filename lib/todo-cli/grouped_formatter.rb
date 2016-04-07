module Todo
  class GroupedFormatter
    def initialize(todos)
      @todos = todos
    end

    def print!
      widths = FormatWidths.new(@todos.map {|g| g[g.keys.first] }.flatten)
      widths.calculate_widths

      @todos.each do |grouping|
        $stdout << "\n"
        $stdout << "\t#{grouping.keys.first}:\n".cyan.bold
        Formatter.new(grouping[grouping.keys.first], widths).print!
      end
    end
  end
end

