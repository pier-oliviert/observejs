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

  QUnit.test 'Failed AJAX will emit and event', (assert) ->
    passed = assert.async()

    form = NewTodo.cloneNode(true)

    form.addEventListener 'Joint:XHR:Failed', (e) ->
      assert.equal(form, e.response.target.element)
      passed()

    form.setAttribute('action', 'http://error.domain.cyz')
    Joint.XHR.send(form)


  QUnit.test 'If a form data is passed and the request is GET, hardcode the params in the URL', (assert) ->
    assert.ok(true)
