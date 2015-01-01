class XHR
  script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"
  constructor: (el) ->
    @element(el)
    @request = new XMLHttpRequest()
    @request.addEventListener('load', @completed)


  element: (el) ->
    @element = ->
      el

  completed: (e) =>
    if e.target.responseText.length > 1
      eval(e.target.responseText)(@element())

  send: (src, method = 'GET', data) =>
    @request.open(method, src)
    @request.setRequestHeader('accept', "*/*;q=0.5, #{@script}")
    @request.setRequestHeader('X-Requested-With', "XMLHttpRequest")

    @request.send(data)

  @Form: (element) =>
    xhr = new XHR(element)
    data = new FormData(element)
    param = document.querySelector('meta[name=csrf-param]').getAttribute('content')
    token = document.querySelector('meta[name=csrf-token]').getAttribute('content')
    data.append(param, token)
    xhr.send(element.getAttribute('action'), element.getAttribute('method'), data)
    xhr


