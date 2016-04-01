module Todo
  class Item
    attr_accessor :id, :subject, :projects, :contexts, :due, :completed

    def initialize
      projects, contexts = [],[]
      completed = false
    end

    def valid?
      @subject != nil && @subject != ''
    end

    def mark_complete
      @completed = true
    end

    def mark_incomplete
      @completed = false
    end

    def load_from_hash(hash)
      @id = hash.fetch(:id, nil) || hash.fetch("id")
      @subject = hash.fetch(:subject, nil) || hash.fetch("subject")
      @projects = hash.fetch(:projects, nil) || hash.fetch("projects")
      @contexts = hash.fetch(:contexts, nil) || hash.fetch("contexts")
      @due = hash.fetch(:due, nil) || hash.fetch("due")
      @completed = hash.fetch(:completed, nil) || hash.fetch("completed")
    end

    def to_hash
      {subject: subject, projects: projects, contexts: contexts, due: due, completed: completed, id: id}
    end
  end
end
