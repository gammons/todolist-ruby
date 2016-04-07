module Todo
  class Formatter

    def initialize(todos, widths = nil)
      widths ||= FormatWidths.new(todos)
      @widths = widths
      @widths.calculate_widths
      @todos = todos
    end

    def print!
      @todos.each_with_index do |todo, i|
        TodoFormatter.new(todo, @widths).print!
      end
      $stdout << "\n"
    end
  end
end
