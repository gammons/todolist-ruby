require 'test_helper'

describe Todo::Filter do
  describe "#parse_date_range" do
    it "today" do
      Todo::Filter.new([], "today").parse_date_range.must_equal [Date.today, Date.today]
      Todo::Filter.new([], "today").parse_date_range.must_equal [Date.today, Date.today]
    end

    it "tomorrow" do
      Todo::Filter.new([], "tomorrow").parse_date_range.must_equal [Date.today + 1, Date.today + 1]
      Todo::Filter.new([], "tomorrow").parse_date_range.must_equal [Date.today + 1, Date.today + 1]
    end
  end

  describe "#filter_projects" do
    it "includes projects asked for" do
      item1 = Todo::Item.new
      item1.projects = %w(proj1 proj2)

      item2 = Todo::Item.new
      item2.projects = %w(proj2 proj3)

      item3 = Todo::Item.new
      item3.projects = %w(proj3 proj4)

      item4 = Todo::Item.new
      item4.projects = []

      todos = [item1,item2,item3,item4]

      Todo::Filter.new(todos, "+proj1 +proj2").filter_projects.must_equal [item1,item2]
    end
  end

  describe "#filter_contexts" do
    it "includes contexts asked for" do
      item1 = Todo::Item.new
      item1.contexts = %w(cont1 cont2)

      item2 = Todo::Item.new
      item2.contexts = %w(cont2 cont3)

      item3 = Todo::Item.new
      item3.contexts = %w(cont3 cont4)

      item4 = Todo::Item.new
      item4.contexts = []

      todos = [item1,item2,item3,item4]

      Todo::Filter.new(todos, "@cont1 @cont2").filter_contexts.must_equal [item1,item2]
    end
  end
end

