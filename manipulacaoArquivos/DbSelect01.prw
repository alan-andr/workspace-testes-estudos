#Include 'protheus.ch'
#Include 'totvs.ch'

User Function DBSEL01()
    Local aArea := FWGetArea()
    Local cNumOrc := '000105'
    Local cCliente := 'Transportadora Alvorada'

    RpcSetEnv('99', '01')

    DbSelectArea('SCJ')
    SCJ->( DbSetOrder(1) )

    If ! DbSeek( xFilial('SCJ') + cNumOrc )
        FWAlertInfo('O orçamento não existe.', 'Alerta')
    Else

        If SCJ->CJ_STATUS == 'A'
            FWAlertInfo('O pedido do cliente ' + cCliente + ' ainda está em processamento.')
        ElseIf SCJ->CJ_STATUS == 'F'
            FWAlertInfo('O pedido do cliente ' + cCliente + ' já foi enviado.', 'Alerta')
        EndIf

    EndIf

    SCJ->( DbCloseArea() )
    RpcClearEnv()
    FWRestArea(aArea)

Return
