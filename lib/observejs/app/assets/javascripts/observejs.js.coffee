#= require_tree './polyfills'
#= require 'observejs/base'
#= require 'observejs/watcher'
#= require 'observejs/creator'
#= require 'observejs/observer'
#= require 'observejs/xhr'
#= require 'observejs/ext'

if document.readyState == 'complete'
  window.ObserveJS.initialize()
else
  document.addEventListener 'DOMContentLoaded', ->
    window.ObserveJS.initialize()
