module Todo
  class App

    def initialize
      @store = Store.new
      @store.load
    end

    def create_todo(args)
      todo = Parser.new.parse(args)
      if todo.valid?
        @store.add!(todo)
        $stdout << "Todo added.\n"
      else
        $stdout << "Todo not saved, it needs a description..\n"
      end
    end

    def edit_todo(args)
      id = args.split(' ')[0]
      to_edit = args.sub(/\d+/,'')

      todo = @store.find(id)
      if todo
        case to_edit.split(' ')[0]
        when "due"
          todo.due = Parser.new.due(to_edit)
          @store.save
          $stdout << "Due date updated.\n"
        end
      else
        $stdout << "Todo not found.\n"
      end
    end

    def complete_todo(id)
      todo = @store.find(id)
      if todo
        todo.mark_complete
        @store.save
        $stdout << "Todo completed.\n"
      else
        $stdout << "Todo not found.\n"
      end
    end

    def archive_completed
      @store.todos.select {|t| t.completed? }.each {|t| t.archive }
      @store.save
      $stdout << "All completed todos have been archived.\n"
    end

    def archive_todo(id)
      todo = @store.find(id)
      if todo
        todo.archive
        @store.save
        $stdout << "Todo archived.\n"
      else
        $stdout << "Todo not found.\n"
      end
    end

    def uncomplete_todo(id)
      todo = @store.find(id)
      if todo
        todo.mark_incomplete
        @store.save
        $stdout << "Todo uncompleted.\n"
      else
        $stdout << "Todo not found.\n"
      end
    end

    def delete_todo(id)
      todo = @store.find(id)
      if todo
        @store.remove!(todo)
        $stdout << "Todo deleted.\n"
      else
        $stdout << "Todo not found.\n"
      end
    end


    def list_todos(args)
      filter = Filter.new(@store.todos, args)
      filtered = filter.filter
      if filter.grouped?
        GroupedFormatter.new(filtered).print!
      else
        Formatter.new(filtered).print!
      end
    end
  end
end
