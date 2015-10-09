## printme
easy printing directive for angularjs

## demo
![alt tag](https://raw.githubusercontent.com/albertywu/printme/master/demo.gif)

## install
use bower:
```
bower install printme
```

include in html:
```
<script src="bower_components/printme/printme.js"></script>
```

include in angular module dependencies:
```
var app = angular.module('myApp', ['printMe', ...]
```

## usage

Apply it to any directive to make it printable (hides directive, opens print modal):
```
<my-directive print-me></my-directive>
```

## advanced usage

trigger print at a later time (useful for async components that might take a while to load)
```
<my-async-directive print-me="trigger"></my-async-directive>
```

inside `myAsyncDirective`:
```coffeescript
.directive 'myAsyncDirective', ->
  scope: { ... } # isolate scope
  template: """
    ...
  """
  require: 'printMe'
  link: (scope, el, attrs, printMe) ->
    # do something async
    # wait.. wait.. wait..
    # invoke printMe.print() when ready to print.
```
