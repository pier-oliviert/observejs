# JointJS

Event based JavaScript framework tailored made for Ruby on rails.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jointjs'
```

Then add this line to application.js

```js
//= require 'joint'
```
## Usage

Ethereal is an event based framework that manages the life cycle of JavaScript objects. Here's a simple Todo where you can dynamically add/remove items on the list.

```erb
<!-- views/todos/index.html.erb -->
<%= content_tag :ol, as: 'Todo.List', do %>
  <%= render @todos %>
<% end %>
```

```coffee
# assets/javascripts/todos/list.js.coffee 
Joint.bind 'Todo.List', class
  # @element() always return the element to which your object is bound.

  loaded: =>
    @element().on 'todos:create', @add
    @element().on 'todos:destroy', @delete

  add: (e) =>
    @element().appendChild(e.html)

  delete: (e) =>
    @element().querySelector("[tid=#{e.todoId}]")?.remove()

```

```ruby
  #views/todos/create.js.erb
  e.html = "<%= j render(@todo) %>".toHTML()
```

```ruby
  #views/todos/destroy.js.erb
  e.todoId = <%= @todo.id %> 
```

Some notes:

- Automatic instantiation. No need to wrap things in DOMContentReady anymore.
- Events are built following the "controller:action" pattern.
- A callback (@loaded) is called right after Ethereal has instantiated an object.
- In *.js.erb, an event is created. You can set HTML to the event object.
- To ease the process, a toHTML() method has been added to the String object (JS).
- You need to register any class you create through the ```Joint.bind 'name', Class```. The name is the attribute you set in your DOM.


