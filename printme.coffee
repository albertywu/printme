(angular.module 'printMe', [])



# Usages:
#
# Regular mode:
# <my-directive print-me>foo</my-directive>
#
# Manual trigger mode (useful for async directives):
# <my-async-directive print-me="trigger">bar</my-async-directive>
.directive 'printMe', ($timeout, $window, PRINT_ME_CONSTANTS) ->
  restrict: 'A'
  scope: no
  controller: ($scope, $element) ->

    @print = $scope.print = ->
      $timeout ->
        $window.print()
        $element.remove()
    @

  link: (scope, elem, attrs) ->

    elem.attr 'id', 'print-area'

    if attrs.printMe is 'trigger'
      # Do nothing;
      # We patiently wait until a sibling / child directive calls scope.print() via the controller API

    else
      # default behavior: print on the next tick
      scope.print()

    appendStyles = ->
      return if $window.document.getElementById PRINT_ME_CONSTANTS.id
      styleTag = $window.document.createElement 'style'
      styleTag.type = 'text/css'
      styleTag.id = PRINT_ME_CONSTANTS.id
      if styleTag.styleSheet
        styleTag.styleSheet.cssText = PRINT_ME_CONSTANTS.css
      else
        styleTag.appendChild $window.document.createTextNode PRINT_ME_CONSTANTS.css

      $window.document.head.appendChild styleTag

    appendStyles()


.constant 'PRINT_ME_CONSTANTS',
  id: 'print-me-css'
  css: """
    @media screen {
      #print-area {
        display: none;
      }
    }

    @media print {
      body * {
        visibility: hidden;
      }

      #print-area, #print-area * {
        visibility: visible;
      }

      #print-area {
        position: absolute;
        left: 0;
        top: 0.5in;
      }
    }
  """