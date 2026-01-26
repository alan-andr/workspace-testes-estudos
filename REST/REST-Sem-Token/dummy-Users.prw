#Include 'protheus.ch'
#Include 'totvs.ch'

User Function DUMUSRS() 
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRest        := FWRest():New('https://dummyjson.com' )
    Local cPath        := '/users'
    Local jJson        := jsonObject():New()
    Local cLastError   := ''
    Local cErrorDetail := ''
    Local nX           := 0
    Local aUsers       := {}

    Local cFullName    := ''
    Local nAge         := 0
    Local cEmail       := ''
    Local cPhone       := ''
    Local cUserName    := ''
    Local cPass        := ''

    aadd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus + ' + GetBuild() + ')')
    aadd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aadd(aHeader, 'Accept: application/json')

    oRest:SetPath(cPath)

    If oRest:Get(aHeader)

        jJson:fromJson(oRest:GetResult())

        aAdd(aUsers, jJson['users'])

        For nX := 1 To Len(aUsers[1])

            cFullName := aUsers[1 ,nX, 'firstName' ] + ' ' + aUsers[1, nX, 'lastName' ]
            nAge      := aUsers[1, nX, 'age' ]
            cEmail    := aUsers[1, nX, 'email' ]
            cPhone    := aUsers[1, nX, 'phone' ]
            cUserName := aUsers[1, nX, 'username' ]
            cPass     := aUsers[1, nX, 'password' ]

            GetToken( cUserName, cPass )

        Next nX

    Else
        cLastError   := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()
        FWAlertError('Erro: ' + cLastError + ' - detalhes: ' + cErrorDetail, '')
    EndIf

    FWRestArea(aArea)
Return

Static Function GetToken(cUsr, cPass)
    Default cUsr       := 'emily'
    Default cPass      := 'emilyspass'

    Local aHeader      := {}
    Local oRest        := FWRest():New('https://dummyjson.com' )
    Local cPath        := '/auth/login'
    Local jJson        := jsonObject():New()
    Local cJsonBody    := ''
    Local cResult      := ''
    Local cLastError   := ''
    Local cErrorDetail := ''

    Local cToken       := ''
    Local cRetUsrNm    := ''

    aAdd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aAdd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aAdd(aHeader, 'Accept: application/json')

    jJson[ 'username' ]    := cUsr
    jJson[ 'password' ]    := cPass
    jJson[ 'expiresMins' ] := 60

    cJsonBody := jJson:toJson()

    oRest:SetPath(cPath)
    oRest:SetPostParams(cJsonBody)

    If oRest:Post(aHeader)
        cResult := oRest:GetResult()

        jJson:fromJson(cResult)

        cToken    := jJson[ 'accessToken' ]
        cRetUsrNm := jJson[ 'username' ]

        FWAlertInfo( '<b>Usuário: </b>' + cRetUsrNm + CRLF +;
                     '<b>Token: </b>' + cToken, '' )
    Else
        cLastError   := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()
        FWAlertError('Erro: ' + cLastError + ' - detalhes: ' + cErrorDetail, '')
    EndIf

Return
