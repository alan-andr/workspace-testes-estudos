#Include 'totvs.ch'
#Include 'protheus.ch'

User Function DIALOG001()
    Local cTitulo := 'Primeira tela com MSDialog'
    Local nCorPreto := CLR_BLACK
    Local nCorBranco := CLR_WHITE

    Local nTop := 10
    Local nLeft := 10
    Local nBottom := 600
    Local nRight := 900
    Local oDlg := Nil

    Local oSay := Nil

    Local cFonte := 'Arial'
    Local oFontTit := TFont():New(cFonte, , -12, , .T.)

    oDlg := MSDialog():New( nTop, nLeft, nBottom, nRight, cTitulo,,,,,nCorPreto,nCorBranco,,,.T. )

    oSay := TSay():New( 05,05, {|| '<b>Alteração de Parâmetro</b>'}, oDlg,,oFontTit,,,,.T.,nCorPreto,nCorBranco, 100,20 )
    
    oDlg:Activate()

Return
