document.addEventListener 'readystatechange', (e) ->
  QUnit.test 'All declared HTML element should have an instance', (assert) ->
    elements = document.querySelectorAll("li[as='List.Item']")
    for li in elements
      assert.ok li.instance, "No instance bound to the element"

