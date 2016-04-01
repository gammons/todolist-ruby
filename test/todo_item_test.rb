require 'test_helper'

describe Todo::Item do
  it "#load_from_hash" do
    todo = Todo::Item.new
    todo.load_from_hash({"subject": "test subject",
                         "projects": %w(proj1 proj2),
                         "contexts": %w(cont1 cont2),
                         "due": "2016-04-01",
                         "id": 1,
                         "completed": true})
    todo.subject.must_equal "test subject"
    todo.projects.must_equal %w(proj1 proj2)
    todo.contexts.must_equal %w(cont1 cont2)
    todo.due.must_equal "2016-04-01"
    todo.completed.must_equal true
  end
end
