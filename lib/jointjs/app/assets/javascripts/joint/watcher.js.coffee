class Watcher
  constructor: ->
    document.addEventListener('joint:loaded', @start)

  start: =>
    @observer = new MutationObserver(@observed)
    @observer.observe(document, {
      attributes: true,
      subtree: true,
      childList: true,
      attributeFilter: [Joint.attributeName],
      characterData: true
    })

    @inspect(document)

  observed: (mutations) =>
    mutations.forEach (mutation) =>
      if mutation.type == 'attributes'
        Joint.Creator.update(target)
      else
        @add(mutation.addedNodes)
        @destroy(mutation.removedNodes)


  add: (nodes) =>
    for node in nodes
      continue unless Joint.isDOM(node)
      if node.hasAttribute(Joint.attributeName)
        Joint.Creator.create(node, node.getAttribute(Joint.attributeName))

      for child in node.querySelectorAll("[#{Joint.attributeName}]")
        Joint.Creator.create(child, child.getAttribute(Joint.attributeName))

  destroy: (nodes) =>
    for node in nodes
      continue unless Joint.isDOM(node)
      if node.hasAttribute(Joint.attributeName)
        Joint.Creator.destroy(node)

      for child in node.querySelectorAll("[#{Joint.attributeName}]")
        Joint.Creator.destroy(child)

  inspect: (node) ->
    if Joint.isDOM(node)
      found = node.querySelectorAll("[#{Joint.attributeName}]")
      Joint.Creator.create(el) for el in found

@Joint.Watcher = new Watcher()
