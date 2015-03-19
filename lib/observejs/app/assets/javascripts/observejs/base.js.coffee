class ObserveJS
  attributeName: 'as'

  constructor: ->
    @cache = {}

  initialize: =>
    event = new CustomEvent('observejs:loaded')
    document.dispatchEvent(event)

  isDOM: (el) ->
    el instanceof HTMLDocument ||
    el instanceof HTMLElement

  bind: (name, kls) =>
    @cache[name] = kls

window.ObserveJS = new ObserveJS()
