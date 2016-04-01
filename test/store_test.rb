require 'test_helper'

describe Todo::Store do
  describe "#load" do
    it "does not fail when file does not exist" do
      Todo::Store.new.load("notexist.json")
    end

    it "loads the todos it finds" do
      store = Todo::Store.new
      store.load("test/todos.json")
      todo = store.todos.first
      todo.subject.must_equal "do this thing"
      todo.projects.must_equal ["bigproj"]
      todo.contexts.must_equal %w(bob sue)
      todo.due.must_equal "2016-04-01"
      todo.completed.must_equal false
    end
  end

  it "#store" do
    store = Todo::Store.new
    store.stub :default_file_loc, "test/write_todos.json" do
      store.load("test/todos.json")
      store.save
      File.exists?("test/write_todos.json").must_equal true
      store.load("test/write_todos.json")
      store.todos.size.must_equal 2
    end
    FileUtils.rm_rf("test/write_todos.json")
  end

  it "add" do
    store = Todo::Store.new
    item = Todo::Item.new
    item.subject = "test"
    store.add(item)
    store.todos.size.must_equal 1
    store.todos[0].must_equal item
  end

  it "remove" do
    store = Todo::Store.new
    item = Todo::Item.new
    item.subject = "test"
    store.add(item)
    store.remove(item)
    store.todos.size.must_equal 0
  end
end

