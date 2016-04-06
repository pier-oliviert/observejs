class @ObserveJS.Observer
  constructor: (model) ->
    @keys = {}
    @observer = new MutationObserver(@mutated.bind(this, model))
    @observer.observe(model.element(), {
      childList: false
      characterData: false
      attributes: true
    })

  bind: (key, callback) ->
    @keys["data-#{key}"] = callback

  mutated: (model, mutations) ->
    for mutation in mutations
      if (callback = @keys[mutation.attributeName])?
        callback(mutation)

  disconnect: =>
    @observer.disconnect()


