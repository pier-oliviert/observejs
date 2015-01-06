document.addEventListener 'readystatechange', (e) ->
  return unless document.readyState == 'complete'
  QUnit.test 'All declared HTML element should have an instance', (assert) ->
    elements = document.querySelectorAll("li[as='List.Item']")
    for li in elements
      assert.ok li.instance, "No instance bound to the element"

  QUnit.test 'If an element is inserted in the DOM, load its instance', (assert) ->
    count = document.querySelectorAll("li[as='List.Item']").length
    li = "<li as='List.Item'>Item ##{count + 1}</li>".toHTML()
    document.querySelector('ol.test.items').appendChild(li)
    assert.ok count + 1 == document.querySelectorAll("li[as='List.Item']").length, "Should instantiate a new instance for the new item"
    li.remove()
  
  event = new CustomEvent('QUnit:Joint:Initialized')
  document.dispatchEvent(event)

