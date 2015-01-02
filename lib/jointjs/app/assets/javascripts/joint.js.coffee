#= require 'joint/ext'
#= require 'joint/base'
#= require 'joint/watcher'
#= require 'joint/creator'
#= require 'joint/xhr'

if document.readyState == 'complete'
  window.Joint.initialize()
else
  document.addEventListener 'DOMContentLoaded', ->
    window.Joint.initialize()

