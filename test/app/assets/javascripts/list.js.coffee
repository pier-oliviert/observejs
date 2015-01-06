Joint.bind 'List', class
  loaded: ->
    @on 'todos:create', document, @append

  append: (e) =>
    @element().insertBefore(e.HTML, @element().firstChild)
