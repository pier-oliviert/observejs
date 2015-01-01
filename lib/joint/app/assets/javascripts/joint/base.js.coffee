@Joint = {
  attributeName: 'as'
}

@Joint.isDOM = (el) ->
  el instanceof HTMLDocument ||
  el instanceof HTMLElement

listen = (e) ->
  if e.type && e.type == 'DOMContentLoaded'
    document.removeEventListener('DOMContentLoaded', listen)

  Joint.Watcher(document, {
      attributes: true,
      subtree: true,
      childList: true,
      attributeFilter: [Joint.attributeName],
      characterData: true
  })

  Joint.Watcher().inspect(document.body)

  document.addEventListener 'submit', (e) ->
    if e.target.getAttribute('disabled')? || e.target.dataset['remote'] != 'true'
      return

    Joint.XHR.Form(e.target)

    e.preventDefault()
    return false

  document.addEventListener 'click', (e) ->
    el = e.target
    while el? && !(el instanceof HTMLAnchorElement)
      el = el.parentElement

    return unless el?

    if el.getAttribute('disabled')? || el.dataset['remote'] != 'true'
      return

    xhr = new Joint.XHR(el)
    xhr.send(el.getAttribute('href'))

    e.preventDefault()
    return false


if document.readyState == 'complete'
  listen()
else
  document.addEventListener('DOMContentLoaded', listen)
