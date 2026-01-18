#Include 'protheus.ch'
#Include 'totvs.ch'

User Function LIBRARY()
    Local aArea        := FWGetArea()
    Local aHeader      := {}
    Local oRest        := FWRest():New('https://openlibrary.org' )
    Local cBook        := AllTrim( FWInputBox( 'Insira o nome do livro: <b>(English)</b>' , '' ) )
    Local cPath        := '/search.json?title=' + StrTran( Lower( cBook ), ' ', '+' )
    Local cResult      := ''
    Local nHTTPcod     := 0
    Local jJson        := jsonObject():New()
    Local cLastError   := ''
    Local cErrorDetail := ''

    Local cTitle       := ''
    Local cAuthor      := ''
    Local nPublish     := 0
    Local cBorrow      := ''

    aadd(aHeader, 'User-Agent: Mozilla/4.0 (Compatible; Protheus ' + GetBuild() + ')')
    aadd(aHeader, 'Content-Type: application/json; charset=utf-8')
    aadd(aHeader, 'Accept: application/json')

    oRest:SetPath(cPath)

    If oRest:Get(aHeader)
        cResult  := oRest:GetResult()
        nHTTPcod := Val( oRest:GetHTTPCode() )

        If nHTTPcod == 200
            jJson:fromJson(cResult)

            cAuthor  := jJson[ 'docs' , 1, 'author_name' , 1]
            nPublish := jJson[ 'docs' , 1, 'first_publish_year' ]
            cBorrow  := jJson[ 'docs' , 1, 'ebook_access' ]
            cTitle   := jJson[ 'docs' , 1, 'title' ]

            FWAlertSuccess( '<b>Titulo:</b> ' + cTitle + CRLF +;
                            '<b>Autor:</b> ' + cAuthor + CRLF +;
                            '<b>Publicado:</b> ' + cvalToChar(nPublish) + CRLF +;
                            '<b>Acesso:</b> ' + cBorrow, 'Resultado API Library' )

        Else
            FWAlertInfo('O livro <b>' + cBook + '</b> não foi encontrado nos registros da API Library.', 'Alerta')
        EndIf

    Else
        cLastError   := oRest:GetLastError()
        cErrorDetail := oRest:GetResult()
        FWAlertError('Erro: ' + cLastError + ' - detalhes: ' + cErrorDetail, '')
    EndIf

    FreeObj(jJson)
    FWRestArea(aArea)
Return 
