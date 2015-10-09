(angular.module 'printMe', [])

.constant 'PRINT_ME_CONSTANTS',
  id: 'print-me-css'
  css:
    """
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

# first hides element, then opens up a print dialog!
# <div print-me>foo</div>
# <div print-me="later">bar</div>
.directive 'printMe', ($timeout, $window, PRINT_ME_CONSTANTS) ->
  restrict: 'A'
  scope: no
  controller: ($scope, $element) ->

    @print = $scope.print = ->
      $timeout ->
        console.log "printing #{ $element.html() }"
        $window.print()
        $element.remove()
    @

  link: (scope, elem, attrs) ->

    elem.attr 'id', 'print-area'

    if attrs.printMe is 'trigger'
      # allow a child / sibling directive to explicitly call scope.print()

    else
      # default: print on the next tick
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
