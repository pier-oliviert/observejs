#= require 'joint/ext'
#= require 'joint/base'
#= require 'joint/creator'
#= require 'joint/watcher'
#= require 'joint/xhr'

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

if document.readyState == 'complete'
  window.Joint.initialize()
else
  document.addEventListener 'DOMContentLoaded', ->
    window.Joint.initialize()
