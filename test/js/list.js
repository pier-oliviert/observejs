(function() {

  function List() {

    this.loaded = function() {

      this.on('click', this.remove)
      this.on('click', document, this.hello)
    }

    this.remove = function() {
      this.remove()
    }

    this.hello = function() {
      console.log('hello')
    }
  }

  Shiny.Models.add(List, "List")
})()
