module Todo
  class Item
    attr_accessor :id, :subject, :projects, :contexts, :due, :completed, :archived

    def initialize
      projects, contexts = [],[]
      completed = false
      archived = false
    end

    def valid?
      @subject != nil && @subject != ''
    end

    def completed?
      @completed
    end

    def archived?
      @archived
    end

    def archive
      @archived = true
    end

    def unarchive
      @archived = false
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
      @archived = hash.fetch(:archived, nil) || hash.fetch("archived", false)
    end

    def to_hash
      {
        subject: subject,
        projects: projects,
        contexts: contexts,
        due: due,
        completed: completed,
        id: id,
        archived: archived
      }
    end
  end
end
