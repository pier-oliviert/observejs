instance = undefined

class Watcher
  constructor: (target, config = {}) ->
    @observer = new MutationObserver(@observed)
    @observer.observe(target, config)

  observed: (mutations) =>
    mutations.forEach (mutation) =>
      if mutation.type == 'attributes'
        Joint.God.update(target)
      else
        @add(mutation.addedNodes)
        @destroy(mutation.removedNodes)


  add: (nodes) =>
    for node in nodes
      continue unless Joint.isDOM(node)
      if node.hasAttribute(Joint.attributeName)
        Joint.God.create(node, node.getAttribute(Ethereal.attributeName))

      for child in node.querySelectorAll("[#{Joint.attributeName}]")
        Joint.God.create(child, child.getAttribute(Ethereal.attributeName))

  destroy: (nodes) =>
    for node in nodes
      continue unless Joint.isDOM(node)
      if node.hasAttribute(Joint.attributeName)
        Joint.God.destroy(node)

      for child in node.querySelectorAll("[#{Joint.attributeName}]")
        Joint.God.destroy(child)

  inspect: (node) ->
    if Joint.isDOM(node)
      found = node.querySelectorAll("[#{Joint.attributeName}]")
      Joint.God.create(el) for el in found

# !! **************************************** !! #

Joint.Watcher = ->
  unless instance?
    i = 0
    target = null
    target = if Joint.isDOM(arguments[i]) then arguments[i++] else document
    instance = new Watcher(target, arguments[i])

  instance

