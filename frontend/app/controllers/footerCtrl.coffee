'use strict'

app.controller 'footerCtrl', (['$scope', '$document', 'team', 'pages', ($scope, $document, team, pages) ->
  $document.scrollTopAnimated(0, 500)

  $scope.team = team.data.results
  $scope.pages = pages.data.results
])

app.controller 'footerAffiliateCtrl', (['$scope', 'affiliates', ($scope, affiliates) ->
  $scope.affiliates = affiliates.data.results
])
