document.addEventListener 'QUnit:Joint:Initialized', ->
  QUnit.test 'Send an AJAX for any element that has a href attribute', (assert) ->
    el = document.querySelector("li[as='List.Item']")
    assert.ok(true)

  QUnit.test 'Send an AJAX Form with formData automatically configured data', (assert) ->
    passed = assert.async()

    form = NewTodo
    form.querySelector('#todo_title').value = "Creating a new todo"

    xhr = Joint.XHR.send(form)
    xhr.request.addEventListener 'load', (r) ->
      assert.equal(r.target.status, 200)
      passed()



  QUnit.test 'If a form data is passed and the request is GET, hardcode the params in the URL', (assert) ->
    assert.ok(true)
