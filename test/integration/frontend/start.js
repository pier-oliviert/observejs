var utils = require('utils')

casper.test.begin('Ethereal initialize?', function suite(test) {
  casper.start('http://localhost:3000', function started() {
    test.assertTitle('Ethereal Test Suite', 'Should load the test suite homepage');
    test.assertEval(function() {
      return Ethereal instanceof Object
    }, 'Ethereal should be loaded')
  })

  casper.on('remote.message', function(msg) {
    this.echo("Console message: " + msg);
  })

  casper.on("page.error", function(msg, trace) {
    this.echo("Browser Error: " + msg, "ERROR");
  });

  casper.on('remote.callback', function(event) {
    if (event.name !== 'DOMContentReady') {
      return
    }

    test.assertEval(function() {
      return Ethereal.Models.klass.Todos !== undefined
    }, "Todos should registered")

    test.assertEval(function() {
      var el = document.querySelector("ul[as='Todos']")
      return el.instance == undefined
    }, "Todos should be bound to the element")

  })

  casper.then(function() {
    casper.evaluate(function() {
      if(document.readyState == 'complete') {
        window.callPhantom({
          name: 'DOMContentReady'
        })
      } else {
        document.addEventListener('DOMContentReady', function() {
          window.callPhantom({
            name: 'DOMContentReady'
          })
        })
      }
    })
  })


  casper.run(function() {
    test.done()
  })
})
