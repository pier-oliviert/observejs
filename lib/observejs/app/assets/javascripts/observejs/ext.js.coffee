ObserveJS.HTML = {
  parse: (text) ->
    el = document.createElement('div')
    el.innerHTML = text
    if el.children.length > 1
      el.children
    else
      el.children[0]
}
