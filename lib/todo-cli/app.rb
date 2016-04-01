module Todo
  class App
    PADDING = 3

    def initialize
      @store = Store.new
      @store.load
    end

    def create_todo(args)
      todo = Parser.new.parse(args)
      if todo.valid?
        @store.add(todo)
        @store.save
        $stdout << "Todo added.\n"
      else
        $stdout << "Todo not saved, it needs a description..\n"
      end
    end

    def complete_todo(index)
      todo = @store.todos.find {|t| t.id.to_i == index.to_i }
      if todo
        todo.mark_complete
        @store.save
        $stdout << "Todo completed.\n"
      else
        $stdout << "Todo not found.\n"
      end
    end

    def uncomplete_todo(index)
      todo = @store.todos.find {|t| t.id.to_i == index.to_i }
      if todo
        todo.mark_incomplete
        @store.save
        $stdout << "Todo uncompleted.\n"
      else
        $stdout << "Todo not found.\n"
      end
    end

    def delete_todo(index)
      @store.todos.reject! { |t| t.id == index.to_i }
      @store.save
      $stdout << "Todo deleted.\n"
    end

    def list_todos(args)
      filtered = Filter.new(@store.todos, args).filter

      longest_projects = find_longest_projects + PADDING
      longest_contexts = find_longest_contexts + PADDING
      longest_subject = find_longest_subject + PADDING

      filtered.each_with_index do |todo, i|
        printf "%-3s %-5s %-#{longest_projects}s %-#{longest_contexts}s %-10s %s\n",
          todo.id,
          format_completed(todo),
          format_projects(todo),
          format_contexts(todo),
          format_due(todo),
          format_subject(todo)
      end
    end

    private

    def find_longest_projects
      @store.todos.map {|t| format_projects(t).length }.max
    end

    def find_longest_contexts
      @store.todos.map {|t| format_contexts(t).length }.max
    end

    def find_longest_subject
      @store.todos.map {|t| format_subject(t).length }.max
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
      todo.due.to_s.colorize(:blue)
    end

    def format_subject(todo)
      todo.subject.colorize(:yellow)
    end
  end
end
