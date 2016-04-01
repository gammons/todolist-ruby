module Todo
  class Store
    attr_reader :file, :todos

    DEFAULT_FILE_LOC = "~/.todos.json"

    def initialize(file = DEFAULT_FILE_LOC)
      @file = file
      @todos = []
    end

    def load(file = DEFAULT_FILE_LOC)
      if File.exists?(File.expand_path(file))
        read_todos(File.read(File.expand_path(file)))
      else
        $stdout << "Could not read todos file\n"
      end
    end

    def save
      file = File.open(File.expand_path(default_file_loc),"w")
      file << @todos.map {|t| t.to_hash }.to_json
      file.flush
    end

    def add(todo_item)
      todo_item.id = next_id
      @todos << todo_item
    end

    def remove(todo_item)
      @todos.reject! {|t| t == todo_item }
    end

    # due today
    # by project
    # by context
    #
    def filter(args)

    end

    def read_todos(data)
      @todos = []
      JSON.parse(data).each do |todo|
        item = Item.new
        item.load_from_hash(todo)
        @todos << item
      end
    end

    def default_file_loc
      DEFAULT_FILE_LOC
    end

    def next_id
      return 1 if @todos.empty?
      @todos.max {|t| t.id }.id + 1
    end
  end
end
