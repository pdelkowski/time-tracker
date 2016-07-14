'use strict'

app.service 'ExceptionMapperService', ['$http', ($http) ->
  @parseError = (errorList) ->
    errorMsgs = []
    self = @

    if errorList instanceof Array
        for e in errorList
            errorMsgs.push(e)
    else if errorList.constructor == Object
        for k, v of errorList
            if v instanceof Array
                for e in v
                    errorMsgs.push(e)
            else
                errorMsgs.push(v)
    else
        errorMsgs.push(errorList)

    return errorMsgs

  return
]
