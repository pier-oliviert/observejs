# ObserveJS

ObserveJS is an event-based library created for Ruby On Rails to help people build interactive application **without committing to a Single Page Application (SPA)**.

Based on Custom Elements, ObserveJS takes an innovative approach that re-use views and partials and leverages custom events to make you change application to any server response.

This framework is not like any other JS alternative. It brings concepts from different paradigms and merges them together. It's not as simple as building some JS classes and have everything fed via JSON. Obviously, this won't be for everyone.

To understand what ObserveJS is all about, you need to understand the foundation on which ObserveJS was built.

## Javascript Classes bound like Custom Elements

You may not know about Custom elements, these guys aren't as popular as React but they aren't useless. Trust me. What you need to know here is that by defining an attribute on an element, you can let ObserveJS instantiate a JavaScript class that will be bound to this object. Here's an example:

```html
<div class='datepicker' as='Datepicker'>
</div>
```

Here, you defined an element with the ```as``` attribute. That attribute is special as it will be detected by ObserveJS. It will locate a Javascript class that has been declared the same name and instantiate it. Here's how it would look in JS:

```javascript
ObserveJS.bind('Datepicker', class {
  // This method is called after the class is configured and attached to
  // the element
  loaded() {
    console.log("I'm instantiated")
    
    this.element()
    // <div class='datepicker' as='Datepicker'>
    
    //This look for data-loading
    this.observe('loading', this.changeStatus)
  }
  
  changeStatus(mutation) {
  }
})
```

The object instantiated inherit a few methods that are shown below. The most important method of all is probably the ```this.element()``` method. It returns the element that was bound to this class.

Now, if you would have the DOM element rendered in a page, automatically, the associated JavaScript class would get instantiated and initialized. Those objects have default API that makes your life easier.

## JS Object's instance methods

### ```this.element()```

Returns the element bound to the JS object.

### ```this.on(event_name, callback)```

Bind an event to the specified callback. The event is bound to the element associated with the class. In the example above, this would mean that the event would be bound to the ```div``` element. The callback will be fired only if an event matching its name bubbles up to the element or if an event is fired directly on this event.

### ```this.on(event_name, target, callback)```

Bind an event on a **descendant** of the element associated with the given class. If the target is not a descendant, an Exception will be raised. This is basically the same thing as the previous method except that you can bind it to a descendant.

### ```this.when(event_name, callback)```

Bind an event to ```document```. This should be used only when dealing with server side events or when you need to capture an event from another element that is not a descendant.

All those methods are available to configure your object at any time. You will probably find it useful to setup your callabcks in the ```loaded()``` method as it is **the callback used by ObserveJS when the object is configured**.

### ```this.observe(attribute, callback)```

Bind a callback to a change made to data-* attribute on ```this.element()```. You can call this on different attribute.
