# todo-cli

Todo-cli is a super simple GTD-style todo list, based upon the command line.  It has the following features:

* Very quick, easy-to-use syntax.  Tries to get out of the way as much as possible.
* Supports projects, contexts, and due dates
* Storage is a simple JSON file, defaulting to `~/.todos.json`

## Quick start

### Creating todos

`todo c <description> due <due date>`

Creating a todo is done by using `todo c`.  You can add projects and contexts with the `+project` and `@context` syntax.  Set due dates by adding `due <date>` at the end.


**Examples**

`todo c water the flowers due today`

`todo c bring up the performance issue with @frank at +teamlead meeting due mon`

`todo c meeting with @nick due today`

`todo c talk with @jp about the +hiring_project due tomorrow`

### Listing + filtering todos


**Basic filtering**

`todo l` - List all todos.
`todo l due today` - List todos, filtering on those due today.
`todo t` - Shortcut for all todos due today
`todo l +project` - Show all todos relating to `+project`.
`todo l +project due today` - Show all todos relating to `+project` due today.
`todo l +project @context due mon` - Show all todos relating to `+project` with `@context` due today.

`todo l completed`

**Filter by date**

**Ordering**

`todo l order date`
`todo l order date desc`

`todo l order context`
`todo l order project`
`todo l order subject`

**Grouping**

`todo l by p`
`todo l by c`

### Completing todos

`todo c 1`

`todo u 1`


### Archiving

`todo archive +project`
`todo archive @context`
`todo archive 5`
`todo list archived`


##TODO

* List todos by project and by context

## Faqs

**Really?  Another todo app?**

Yep.  I've used almost all of them, and I was really looking for something as simple as possible.  All I really need is to be reminded of things that I need to do


**How is this different from Todo.txt?**

It's really not that much different.  The

**How

```ruby
gem install todo-cli
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/todo-cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

