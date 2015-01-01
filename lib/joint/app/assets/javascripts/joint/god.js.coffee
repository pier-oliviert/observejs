class God
  update: (el) =>
    model = el.getAttribute(Joint.attributeName)
    if model?
      @create(el, model)
    else
      @destroy(el)

  create: (el) =>
    model = el.getAttribute(Joint.attributeName)
    if @modelExists(model)
      el.instance = new Joint.Models.klass[model](el)

      el.instance.element = ->
        el

      el.instance.on = (event, target, callback) ->
        if callback?
          el.instance.on.events.push([event, target, callback])
        else
          callback = target
          target = el
        target.addEventListener(event, callback)

      el.instance.on.events = []

      if el.instance.loaded?
        el.instance.loaded()

    else
      throw "error: #{model} is not registered. Add your model with Joint.Models.add(#{model})"

  destroy: (el) =>
    el.instance.on.events?.forEach (event) ->
      event[1].removeEventListener(event[0], event[2])


  modelExists: (name) =>
    Joint.Models.klass[name]?
    

Joint.God = new God

