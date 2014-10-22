angular.module 'fast-it.magic'
.controller 'deckController',
($scope) ->
  $scope.deck = [
    name: "Snapcaster mage"
    cost: "1U"
    type: "creature"
    strength: "2"
    toughness: "1"
    rarity: "rare"
  ,
    name: "Augure of Bolas"
    cost: "1U"
    type: "creature"
    strength: "1"
    toughness: "3"
    rarity: "uncommon"
  ,
    name: "Supreme Verdict"
    cost: "1WWU"
    type: "sorcery"
    rarity: "rare"
  ,
    name: "Elspeth, Sun's Champion"
    cost: "4WW"
    type: "planeswalker"
    rarity: "mythic rare"
  ,
    name: "Restoration Angel"
    cost: "3W"
    type: "creature"
    strength: "3"
    toughness: "4"
    rarity: "rare"
  ]
