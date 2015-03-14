class XHRData
  constructor: (el) ->
    @backend = {}
    if el instanceof HTMLFormElement
      @form = el

  set: (k, v) =>
    @backend[k] = v
    @keys().push(k)

  value: (k) =>
    @backend[k]

  has: (k) =>
    @backend[k]?

  keys: =>
    store = []
    fn = ->
      store
    @keys = fn
    fn()

  any: =>
    @keys().length > 0

  serialize: =>
    formData = new FormData(@form)
    for key in @keys()
      formData.append key, @value(key)

    formData

class Response
  constructor: (@xhr) ->
    @xhr.request.addEventListener 'load', @process
    @xhr.request.addEventListener 'error', @failure
    @xhr.request.addEventListener 'abort', @failure

  process: (e) =>
    if e.target.status >= 200 && e.target.status < 300
      @success(e)

  success: (e) =>
    if e.target.responseText.length > 1
      eval(e.target.responseText)(e.target.element)

  failure: (e) =>
    event = new CustomEvent("Joint:XHR:failed", {bubbles: true})
    event.response = e
    @xhr.request.element.dispatchEvent(event)


class XHR
  script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"

  @send: (el) ->

    xhr = new XHR(el)
    xhr.send()
    xhr

  constructor: (el) ->
    @data = new XHRData(el)
    @request = new XMLHttpRequest()
    @request.element = el
    @response = new Response(this)

    @method = el.getAttribute('method') || 'GET'

  send: =>
    action = @request.element.getAttribute('action') || @request.element.getAttribute('href')

    unless action?
      throw "Cannot send a request to the server if the element isn't a Form or if the element doesn't have the HREF attributes: <div href>"
      return

    if @method == 'GET' && @data.any()
      parser = document.createElement('a')
      parser.href = action
      params = parser.search.substring(1).split('&')

      for key in @data.keys()
        params.push "#{key}=#{@data.value(key)}"

      parser.search = "?#{params.join("&")}"

      action = parser.href

    @request.open @method, action
    @request.setRequestHeader 'accept', "*/*;q=0.5, #{@script}"
    @request.setRequestHeader 'X-Requested-With', "XMLHttpRequest"

    if @method != 'GET'
      token = document.querySelector('meta[name=csrf-token]').getAttribute('content')
      @request.setRequestHeader 'X-CSRF-Token', token

    @request.send(@data.serialize())


Joint.XHR = XHR

document.addEventListener 'submit', (e) =>
  if e.target.getAttribute('disabled')? || e.target.dataset['remote'] != 'true'
    return

  XHR.send(e.target)

  e.preventDefault()
  return false

document.addEventListener 'click', (e) =>
  el = e.target
  while el? && !(el instanceof HTMLAnchorElement)
    el = el.parentElement

  return unless el?

  if el.getAttribute('disabled')? || el.dataset['remote'] != 'true'
    return

  XHR.send(el)

  e.preventDefault()
  return false
