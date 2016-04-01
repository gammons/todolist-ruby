module Todo
  class App
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
      $stdout << "#\t[ ]\tProjects\tContexts:\tDue:\tSubject\n"
      filtered.each_with_index do |todo, i|
        output = "#{todo.id}:\t"
        output += list_completed(todo) + "\t"
        output += list_projects(todo) + "\t"
        output += list_contexts(todo) + "\t"
        output += todo.due.to_s.colorize(:blue) + "\t"
        output += todo.subject.colorize(:yellow) + "\n"
        $stdout << output
      end
    end

    private

    def list_completed(todo)
      todo.completed ? "[x]" : "[ ]"
    end

    def list_projects(todo)
      "[" + todo.projects.join(", ").colorize(:green) + "]"
    end

    def list_contexts(todo)
      "(" + todo.contexts.join(", ").colorize(:cyan) + ")"
    end
  end
end
