#### printme
easy printing directive for angularjs

#### Demo
![alt tag](https://raw.githubusercontent.com/albertywu/printme/master/demo.gif)

#### Install
Use bower:
```
bower install printme
```

Include in html:
```
<script src="bower_components/printme/printme.js"></script>
```

Include in angular module dependencies:
```
var app = angular.module('myApp', ['printMe', ...]
```

#### Usage

Apply it to any directive to make it printable (hides directive, opens print modal):
```
<my-directive print-me></my-directive>
```

#### Advanced Usage

Trigger print at a later time (useful for async components that might take a while to load)
```
<my-async-directive print-me="trigger"></my-async-directive>
```

Inside `myAsyncDirective`:
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
