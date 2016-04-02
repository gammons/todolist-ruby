module Todo
  class Formatter
    PADDING = 3

    def initialize(todos)
      @todos = todos
    end

    def print!
      longest_projects = find_longest_projects + PADDING
      longest_contexts = find_longest_contexts + PADDING
      longest_subject = find_longest_subject + PADDING
      longest_due = find_longest_due + PADDING

      $stdout << "\n"
      @todos.each_with_index do |todo, i|
        printf "\t%-3s %-5s %-#{longest_projects}s %-#{longest_contexts}s %-#{longest_due}s %s\n",
          todo.id,
          format_completed(todo),
          format_projects(todo),
          format_contexts(todo),
          format_due(todo),
          format_subject(todo)
      end
      $stdout << "\n"
    end

    private

    def find_longest_projects
      @todos.map {|t| format_projects(t).length }.max || 0
    end

    def find_longest_contexts
      @todos.map {|t| format_contexts(t).length }.max || 0
    end

    def find_longest_subject
      @todos.map {|t| format_subject(t).length }.max || 0
    end

    def find_longest_due
      @todos.map {|t| format_due(t).length }.max || 0
    end

    def format_completed(todo)
      todo.completed ? "[x]" : "[ ]"
    end

    def format_projects(todo)
      return "" if todo.projects.empty?
      "[" + todo.projects.join(", ") + "]"
    end

    def format_contexts(todo)
      return "" if todo.contexts.empty?
      "(" + todo.contexts.join(", ") + ")"
    end

    def format_due(todo)
      case todo.due
      when Date.today.to_s
        "today".colorize(:blue)
      when (Date.today + 1).to_s
        "tomorrow".colorize(:blue)
      else
        todo.due.to_s.colorize(:blue)
      end
    end

    def format_subject(todo)
      todo.subject.split(' ').map {|word|
        case
        when word =~ /\@\w+/
          word.colorize(:magenta)
        when word =~ /\+\w+/
          word.colorize(:red)
        else
          word.colorize(:yellow)
        end
      }.join(' ')
      #todo.subject.colorize(:yellow)
    end
  end
end
