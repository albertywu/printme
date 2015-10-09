// Generated by CoffeeScript 1.8.0
(function() {
  (angular.module('app', ['printMe'])).controller('MainCtrl', function($compile, $window, $scope) {
    $scope.printTable = function() {
      var elem;
      elem = $compile('<async-component print-me="trigger"></async-component>')($scope);
      $window.document.body.appendChild(elem[0]);
    };
    return $scope.printText = function() {
      var elem;
      elem = $compile('<sync-component print-me></sync-component>')($scope);
      $window.document.body.appendChild(elem[0]);
    };
  }).directive('syncComponent', function() {
    return {
      scope: {},
      template: "<div>loaded syncComponent!</div>",
      link: function(scope, el, attrs) {
        return window._debugScope = scope;
      }
    };
  }).directive('asyncComponent', function($timeout) {
    return {
      scope: {},
      template: "<table class=\"pure-table\">\n  <thead>\n    <tr>\n      <th>First Name</th>\n      <th>Middle Initial</th>\n      <th>Last Name</th>\n    </tr>\n  </thead>\n  <tbody>\n    <tr ng-repeat=\"row in state.rows\">\n      <td>{{ row.firstName }}</td>\n      <td>{{ row.middleInitial }}</td>\n      <td>{{ row.lastName }}</td>\n    </tr>\n  </tbody>\n</table>",
      require: 'printMe',
      link: function(scope, el, attrs, printMe) {
        scope.state = {
          rows: []
        };
        return $timeout(function() {
          scope.state.rows = [
            {
              firstName: 'Albert',
              middleInitial: 'Y',
              lastName: 'Wu'
            }, {
              firstName: 'Raj',
              middleInitial: 'R',
              lastName: 'Ram'
            }, {
              firstName: 'Eric',
              middleInitial: 'P',
              lastName: 'Miller'
            }, {
              firstName: 'Toby',
              middleInitial: 'M',
              lastName: 'Jackson'
            }, {
              firstName: 'Boris',
              middleInitial: 'C',
              lastName: 'Cherny'
            }
          ];
          return printMe.print();
        }, 2000);
      }
    };
  });

}).call(this);