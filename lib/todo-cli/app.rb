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
      Formatter.new(filtered).print!
    end
  end
end
