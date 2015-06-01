class Watcher
  constructor: ->
    document.addEventListener('observejs:loaded', @start)

  start: =>
    @observer = new MutationObserver(@observed)
    @observer.observe(document, {
      attributes: true,
      subtree: true,
      childList: true,
      attributeFilter: [ObserveJS.attributeName],
      characterData: true
    })

    @inspect(document)

  observed: (mutations) =>
    mutations.forEach (mutation) =>
      if mutation.type == 'attributes'
        ObserveJS.Creator.update(mutation.target)
      else
        @add(mutation.addedNodes)
        @destroy(mutation.removedNodes)


  add: (nodes) =>
    for node in nodes
      continue unless ObserveJS.isDOM(node)
      if node.hasAttribute(ObserveJS.attributeName)
        ObserveJS.Creator.create(node, node.getAttribute(ObserveJS.attributeName))

      for child in node.querySelectorAll("[#{ObserveJS.attributeName}]")
        ObserveJS.Creator.create(child, child.getAttribute(ObserveJS.attributeName))

  destroy: (nodes) =>
    for node in nodes
      continue unless ObserveJS.isDOM(node)
      if node.hasAttribute(ObserveJS.attributeName)
        ObserveJS.Creator.destroy(node)

      for child in node.querySelectorAll("[#{ObserveJS.attributeName}]")
        ObserveJS.Creator.destroy(child)

  inspect: (node) ->
    if ObserveJS.isDOM(node)
      found = node.querySelectorAll("[#{ObserveJS.attributeName}]")
      ObserveJS.Creator.create(el) for el in found

@ObserveJS.Watcher = new Watcher()
