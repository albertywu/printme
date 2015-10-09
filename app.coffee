(angular.module 'app', ['printMe'])


# Set up demo
.controller 'MainCtrl', ($compile, $window, $scope) ->

  $scope.printTable = ->
    elem = $compile(
      '<async-component print-me="trigger"></async-component>'
    )($scope)
    $window.document.body.appendChild elem[0]
    return

  $scope.printText = ->
    elem = $compile(
      '<sync-component print-me></sync-component>'
    )($scope)
    $window.document.body.appendChild elem[0]
    return

# Sample directive that loads in same tick
.directive 'syncComponent', ->
  scope: {} # isolate scope
  template: """
    <div>loaded syncComponent!</div>
  """
  link: (scope, el, attrs) ->
    window._debugScope = scope


# Sample directive that loads in future tick
.directive 'asyncComponent', ($timeout) ->
  scope: {} # isolate scope
  template: """
    <table class="pure-table">
      <thead>
        <tr>
          <th>First Name</th>
          <th>Middle Initial</th>
          <th>Last Name</th>
        </tr>
      </thead>
      <tbody>
        <tr ng-repeat="row in state.rows">
          <td>{{ row.firstName }}</td>
          <td>{{ row.middleInitial }}</td>
          <td>{{ row.lastName }}</td>
        </tr>
      </tbody>
    </table>
  """
  require: 'printMe'
  link: (scope, el, attrs, printMe) ->

    scope.state =
      rows: []

    $timeout ->
      scope.state.rows = [
        (firstName: 'Albert', middleInitial: 'Y', lastName: 'Wu')
        (firstName: 'Raj', middleInitial: 'R', lastName: 'Ram')
        (firstName: 'Eric', middleInitial: 'P', lastName: 'Miller')
        (firstName: 'Toby', middleInitial: 'M', lastName: 'Jackson')
        (firstName: 'Boris', middleInitial: 'C', lastName: 'Cherny')
      ]

      printMe.print()
    , 2000
