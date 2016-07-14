'use strict'

app.service 'ActionService', ['$document', '$location', ($document, $location) ->
  @getCurrentUrl = () ->
    return $location.absUrl()

  return
]
