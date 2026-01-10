#Include 'totvs.ch'
#Include 'protheus.ch'

User Function DBSEL02()
    Local aArea     := FWGetArea()
    Local cGrupo    := '0002'
    Local cDescri   := 'Materiais de Escritório'
    Local nCustoStd := 1500.00

    RpcSetEnv('99', '01')

    DbSelectArea('SB1')
    DbSetOrder(4)

    If ! DbSeek( xFilial('SB1') + cGrupo )
        RecLock( 'SB1' , .T.)
            SB1->B1_GRUPO    := cGrupo
            SB1->B1_CUSTD := nCustoStd
            SB1->B1_DESC     := cDescri
        SB1->( MsUnlock() )

        FWAlertInfo("O registro foi incluído na SB1")

    Else

        While SB1->B1_GRUPO == cGrupo .AND. !( EoF() ) 

            If SB1->B1_CUSTD > 1200 
                ConOut('Produto: ' + SB1->B1_DESC + ' - Custo: ' + cValToChar(SB1->B1_CUSTD) + ' - ATENÇÃO: ITEM DE ALTO CUSTO')
            EndIf

            SB1->( DbSkip() )

        Enddo

    EndIf

    SB1->( DbCloseArea() )

    RpcClearEnv()

    FWRestArea(aArea)
Return
