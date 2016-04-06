class Creator

  update: (el) =>
    model = el.getAttribute(ObserveJS.attributeName)
    if model?
      @create(el, model)
    else
      @destroy(el)

  create: (el) =>
    model = el.getAttribute(ObserveJS.attributeName)
    if ObserveJS.cache[model]?
      if el.instance?
        el.instance.loaded()
        return

      el.instance = new ObserveJS.cache[model](el)

      el.instance.element = ->
        el

      observer = new ObserveJS.Observer(el.instance)

      el.instance.observe = (observer, key, callback) ->
        observer.bind(key, callback)

      el.instance.observe = el.instance.observe.bind(el.instance, observer)
      el.instance.observe.observer = observer

      el.instance.on = (event, target, callback) ->
        if !callback?
          callback = target
          target = el

        if !el.contains(target)
          throw "error: #{model} is trying to bind an event on a target that isn't a children, or itself. If you desire to bind an event to the document, use when()"
          return
        callback = callback.bind(el.instance)

        el.instance.on.events.push([event, target, callback])
        target.addEventListener(event, callback)

      el.instance.when = (event, callback) ->
        callback = callback.bind(el.instance)

        el.instance.on.events.push([event, document, callback])
        document.addEventListener(event, callback)

      el.instance.on.events = []

      if el.instance.loaded?
        el.instance.loaded()

    else
      throw "error: #{model} is not registered. Add your model with ObserveJS.bind(#{model}, {})"

  destroy: (el) =>
    el.instance.on.events?.forEach (event) ->
      event[1].removeEventListener(event[0], event[2])

    el.instance.unloaded?()
    el.instance.observe.observer.disconnect()
    delete el.instance

@ObserveJS.Creator = new Creator()
