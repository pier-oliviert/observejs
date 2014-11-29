@Ethereal = {
  attributeName: 'as'
}

@Ethereal.isDOM = (el) ->
  el instanceof HTMLDocument ||
  el instanceof HTMLElement

listen = (e) ->
  if e.type && e.type == 'DOMContentLoaded'
    document.removeEventListener('DOMContentLoaded', listen)

  Ethereal.Watcher(document, {
      attributes: true,
      subtree: true,
      childList: true,
      attributeFilter: [Ethereal.attributeName],
      characterData: true
  })

  Ethereal.Watcher().inspect(document.body)

  document.addEventListener 'submit', (e) ->
    if e.target.getAttribute('disabled')? || e.target.dataset['remote'] != 'true'
      return

    Ethereal.XHR.Form(e.target)

    e.preventDefault()
    return false

  document.addEventListener 'click', (e) ->
    el = e.target
    while el? && !(el instanceof HTMLAnchorElement)
      el = el.parentElement

    return unless el?

    if el.getAttribute('disabled')? || el.dataset['remote'] != 'true'
      return

    xhr = new Ethereal.XHR(el)
    xhr.send(el.getAttribute('href'))

    e.preventDefault()
    return false


if document.readyState == 'complete'
  listen()
else
  document.addEventListener('DOMContentLoaded', listen)



