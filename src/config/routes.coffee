angular.module 'fast-it.magic'
.config ($routeProvider, $httpProvider, $compileProvider) ->
  $compileProvider.aHrefSanitizationWhitelist /^\s*(mailto|tel|http|https):/

  $routeProvider
    .when '/', templateUrl: 'views/home.html'
    .otherwise redirectTo: '/'

  delete $httpProvider.defaults.headers.common['X-Requested-With']
