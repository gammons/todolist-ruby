module Todo
  class GroupedFormatter
    def initialize(todos)
      @todos = todos
    end

    def print!
      @todos.each do |grouping|
        $stdout << "\n"
        $stdout << "\t#{grouping.keys.first}:\n".light_green.bold
        Formatter.new(grouping[grouping.keys.first]).print!
      end
    end
  end
end

