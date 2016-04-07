module Todo
  class FormatWidths
    attr_accessor :project_width, :context_width, :subject_width, :due_width

    def initialize(todos)
      @todos = todos
    end

    def calculate_widths
      @project_width = @todos.map {|t| TodoFormatter.new(t).format_projects.length }.max || 0
      @context_width = @todos.map {|t| TodoFormatter.new(t).format_contexts.length }.max || 0
      @due_width = @todos.map {|t| TodoFormatter.new(t).format_due.length }.max || 0
    end
  end
end


