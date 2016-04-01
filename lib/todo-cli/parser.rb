module Todo
  class Parser

    def parse(item)
      todo = Item.new
      todo.subject = subject(item)
      todo.projects = projects(item)
      todo.contexts = contexts(item)
      todo.due = due(item)
      todo
    end

    # private stuff below

    def subject(item)
      if item.index(' due')
        item[0..(item.rindex(' due') - 1)]
      else
        item
      end
    end

    def projects(item)
      return [] if item.nil?
      item.scan(/ \+\w+/).map {|i| i.gsub(/ \+/,'') }
    end

    def contexts(item)
      return [] if item.nil?
      item.scan(/ \@\w+/).map {|i| i.gsub(/ \@/,'') }
    end

    def due(item)
      due = Chronic.parse(item.split("due").last)
      due.nil? ? nil : due.to_date
    end
  end
end
