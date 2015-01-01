class Models
  klass: {}
  add: (kls, name) ->
    unless name?
      name = kls.name
    @klass[name] = kls

Joint.Models = new Models
