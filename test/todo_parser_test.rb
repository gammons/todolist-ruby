require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/todo-cli'

describe Todo::Parser do
  describe "#subject" do
    it "responds to the most basic subject" do
      Todo::Parser.new.subject("doing thangs").must_equal "doing thangs"
    end

    it "keeps all projects" do
      Todo::Parser.new.subject("doing thangs +bigproj").must_equal "doing thangs +bigproj"
    end

    it "keeps all contexts" do
      Todo::Parser.new.subject("doing thangs @bob").must_equal "doing thangs @bob"
    end

    it "does not mutate the original string" do
      thing = "doing thangs @bob +bigproj"
      Todo::Parser.new.subject(thing)
      thing.must_equal("doing thangs @bob +bigproj")
    end
  end

  describe "#projects" do
    it "retrieves all the projects for the todo" do
      Todo::Parser.new.projects("doing thangs").must_equal []
      Todo::Parser.new.projects("doing thangs +bigproj").must_equal ["bigproj"]
      Todo::Parser.new.projects("doing thangs +bigproj @sue +anotherproj").must_equal %w(bigproj anotherproj)
    end
  end

  describe "#contexts" do
    it "retrieves all the contexts for the todo" do
      Todo::Parser.new.contexts("doing thangs").must_equal []
      Todo::Parser.new.contexts("doing thangs @bob").must_equal ["bob"]
      Todo::Parser.new.contexts("doing thangs @bob @sue +anotherproj").must_equal %w(bob sue)
    end
  end

  describe "#due" do
    it "passes to chronic.parse" do
      Todo::Parser.new.due("doing thangs today @bob @sue due tomorrow").must_equal Date.today + 1
    end

    it "uses the last 'due' in the string" do
      Todo::Parser.new.due("I am due today something that is due tomorrow").must_equal Date.today + 1
    end
  end

  describe "#parse" do
    it "generates a todo" do
      item = Todo::Parser.new.parse("got something to do with @bob on +project due 2 days from now")
      item.class.must_equal Todo::Item
      item.subject.must_equal "got something to do with @bob on +project"
      item.projects.must_equal %w(project)
      item.contexts.must_equal %w(bob)
      item.due.must_equal Date.today + 2
    end
  end
end
