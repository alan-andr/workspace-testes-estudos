#Include 'protheus.ch'
#Include 'totvs.ch'

User Function WORK020()
    Local aArea    := FWGetArea()
    Local cCodProd := "00010"
    Local cDesc    := "TECLADO MECANICO"
    Local cTipo     := "PA"
    Local cUnid    := "UN"

    RpcSetEnv("99", "01")

    DbSelectArea("SB1")
    DbSetOrder(1)

    If ! DbSeek( xFilial("SB1") + PadR(cCodProd, TamSX3("B1_COD")[1]) )

        If RecLock("SB1", .T.)
            SB1->B1_FILIAL := xFilial("SB1")
            SB1->B1_COD    := cCodProd
            SB1->B1_DESC   := cDesc
            SB1->B1_TIPO   := cTipo
            SB1->B1_UM     := cUnid
            SB1->( MsUnlock() )
        Else
            FWAlertError("Erro: não foi possível realizar o registro, tente novamente.")
            Return .F.
        EndIf

    Else

        RecLock("SB1", .F.)
            SB1->B1_FILIAL := xFilial("SB1")
            SB1->B1_COD    := cCodProd
            SB1->B1_DESC   := cDesc
            SB1->B1_TIPO   := cTipo
            SB1->B1_UM     := cUnid
        SB1->( MsUnlock() )    

        FWAlertInfo("O registro do produto: " + cCodProd + " já existe no sistema.")

    EndIf

    SB1->( DbCloseArea() )

    RpcClearEnv()

    FWRestArea(aArea)
Return
