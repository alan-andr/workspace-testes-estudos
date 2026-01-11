#Include 'protheus.ch'
#Include 'totvs.ch'

User Function DBSEL05()
    Local aArea     := FWGetArea()
    Local cCodProd  := 'PROD-9988'
    Local cDescProd := 'TECLADO MECANICO RBG PADRAO ABNT2'
    Local nEstoqMin := 50

    RpcSetEnv('99', '01')

    DbSelectArea('SB1')
    SB1->( DbSetOrder(1) )

    If ! DbSeek( xFilial('SB1') + cCodProd)
        RecLock('SB1', .T.)
            SB1->B1_FILIAL := xFilial( 'SB1' )
            SB1->B1_COD    := cCodProd
            SB1->B1_DESC   := cDescProd
            SB1->B1_EMIN   := nEstoqMin
        SB1->( MsUnlock() )

        FWAlertInfo('O registro foi criado com sucesso na SB1.')
    Else
        RecLock('SB1', .F.)
            SB1->B1_DESC := cDescProd
            SB1->B1_EMIN := nEstoqMin
        SB1->( MsUnlock() )

        FWAlertInfo('O registro foi alterado com sucesso na SB1.')
    EndIf

    SB1->( DbCloseArea() )

    RpcClearEnv()

    FWRestArea(aArea)
Return
