document.addEventListener 'readystatechange', (e) ->
  return unless document.readyState == 'complete'
  QUnit.test 'Should return a template bound to the class', (assert) ->
    elements = document.querySelectorAll("li[as='List.Item']")

    list = document.querySelector("[as='List']")
    assert.ok list.instance.template() instanceof HTMLTemplateElement, "Should have a template associated with the List"

    for li in elements
      assert.throws li.instance.template, "No template should be found for those list element."

