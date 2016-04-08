module Todo
  class TodoFormatter
    PADDING = 3

    def initialize(todo, widths = nil)
      @todo, @widths = todo, widths
    end

    def print!
      $stdout << "\t#{print_id}" + (" " * PADDING)
      $stdout << format_completed + (" " * PADDING)
      $stdout << print_projects + (" " * PADDING)
      $stdout << print_contexts + (" " * PADDING)
      $stdout << print_due + (" " * PADDING)
      $stdout << format_subject + " \n"
    end


    def format_completed
      @todo.completed ? "[x]" : "[ ]"
    end

    def format_projects
      return "" if @todo.projects.empty?
      "[" + @todo.projects.join(", ") + "]"
    end

    def format_contexts
      return "" if @todo.contexts.empty?
      "(" + @todo.contexts.join(", ") + ")"
    end

    def format_due
      case @todo.due
      when Date.today.to_s
        "today".blue
      when (Date.today + 1).to_s
        "tomorrow".blue
      else
        if @todo.due && Date.parse(@todo.due) < Date.today
          @todo.due.to_s.red
        else
          @todo.due.to_s.blue
        end
      end
    end

    def format_subject
      @todo.subject.split(' ').map {|word|
        case
        when word =~ /\@\w+/
          word.magenta
        when word =~ /\+\w+/
          word.red
        else
          word.yellow
        end
      }.join(' ')
    end

    private

    def print_id
      spaces = 3 - @todo.id.to_s.length
      @todo.id.to_s + (" " * spaces)
    end

    def print_projects
      spaces = @widths.project_width - format_projects.length
      format_projects + (" " * spaces)
    end

    def print_contexts
      spaces = @widths.context_width - format_contexts.length
      format_contexts + (" " * spaces)
    end

    def print_due
      spaces = @widths.due_width - format_due.length
      format_due + (" " * spaces)
    end
  end
end
