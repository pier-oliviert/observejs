class XHR
  script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"

  completed: (req) ->
    if e.target.responseText.length > 1
      eval(e.target.responseText)(req.element)

  send: (el, formData) ->
    action = el.getAttribute('action') || el.getAttribute('href')

    unless action?
      throw "Cannot send a request to the server if the element isn't a Form or if the element doesn't have the HREF attributes: <div href>"
      return

    method = el.getAttribute('method') || 'GET'
    if formData? && (method != 'GET')
      param = document.querySelector('meta[name=csrf-param]').getAttribute('content')
      token = document.querySelector('meta[name=csrf-token]').getAttribute('content')
      data.append(param, token)

    request = new XMLHttpRequest()
    request.element = el
    request.addEventListener('load', @completed)
    request.setRequestHeader('accept', "*/*;q=0.5, #{@script}")
    request.setRequestHeader('X-Requested-With', "XMLHttpRequest")

    request.send(action, method, data)


@Joint.XHR = new XHR()
