angular.module 'fast-it.magic'
.directive 'card', ->
  restrict: 'E'
  scope:
    data: '='
  templateUrl: 'views/card.html'
  controller: 'cardController'
