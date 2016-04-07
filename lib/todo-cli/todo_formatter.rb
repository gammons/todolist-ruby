module Todo
  class TodoFormatter
    PADDING = 3

    def initialize(todo, widths = nil)
      @todo, @widths = todo, widths
    end

    def print!
      printf "\t%-3s %-5s %-#{@widths.project_width + PADDING}s %-#{@widths.context_width + PADDING}s %-#{@widths.due_width + PADDING}s %s\n",
      @todo.id,
        format_completed,
        format_projects,
        format_contexts,
        format_due,
        format_subject
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
          @todo.due.to_s.red.bold
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
  end
end
