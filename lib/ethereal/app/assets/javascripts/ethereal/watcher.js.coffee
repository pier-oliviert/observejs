instance = undefined

class Watcher
  constructor: (target, config = {}) ->
    @observer = new MutationObserver(@observed)
    @observer.observe(target, config)

  observed: (mutations) =>
    mutations.forEach (mutation) =>
      if mutation.type == 'attributes'
        Ethereal.God.update(target)
      else
        @add(mutation.addedNodes)
        @destroy(mutation.removedNodes)


  add: (nodes) =>
    for node in nodes
      continue unless Ethereal.isDOM(node)
      if node.hasAttribute(Ethereal.attributeName)
        Ethereal.God.create(node, node.getAttribute(Ethereal.attributeName))

      for child in node.querySelectorAll("[#{Ethereal.attributeName}]")
        Ethereal.God.create(child, child.getAttribute(Ethereal.attributeName))

  destroy: (nodes) =>
    for node in nodes
      continue unless Ethereal.isDOM(node)
      if node.hasAttribute(Ethereal.attributeName)
        Ethereal.God.destroy(node)

      for child in node.querySelectorAll("[#{Ethereal.attributeName}]")
        Ethereal.God.destroy(child)

  inspect: (node) ->
    if Ethereal.isDOM(node)
      found = node.querySelectorAll("[#{Ethereal.attributeName}]")
      Ethereal.God.create(el) for el in found

# !! **************************************** !! #

Ethereal.Watcher = ->
  unless instance?
    i = 0
    target = null
    target = if Ethereal.isDOM(arguments[i]) then arguments[i++] else document
    instance = new Watcher(target, arguments[i])

  instance

