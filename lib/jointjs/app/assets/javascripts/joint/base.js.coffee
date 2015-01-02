class Joint
  attributeName: 'as'

  constructor: ->
    @cache = {}

  initialize: =>
    event = new CustomEvent('joint:loaded')
    document.dispatchEvent(event)

  isDOM: (el) ->
    el instanceof HTMLDocument ||
    el instanceof HTMLElement

  bind: (name, kls) =>
    @cache[name] = kls

window.Joint = new Joint()
