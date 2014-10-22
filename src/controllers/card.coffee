angular.module 'fast-it.magic'
.controller 'cardController',
($scope) ->
  $scope.addCard = (card) ->
    card.count = (card.count || 0) + 1
