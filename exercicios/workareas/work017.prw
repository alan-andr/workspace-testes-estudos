#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK017()
    Local aAreaAnt := GetArea()
    Local aAreaSA1 := SA1->( GetArea() )

    Local cCliCod := ""
    Local cCliLoja := ""
    Local cNomeCli := ""

    cCliCod := SC5->C5_CLIENTE
    cCliLoja := SC5->C5_LOJACLI

    DbSelectArea("SA1")
    DbSetOrder(1)

    If SA1->( DbSeek( xFilial("SA1") + cCliCod + cCliLoja ) )
        cNomeCli := SA1->A1_NOME
        ConOut("Cliente encontrado: " + cNomeCli)
    Else
        ConOut("Cliente não encontrado na SA1")
    EndIf

    RestArea(aAreaSA1)

    RestArea(aAreaAnt)

Return 
