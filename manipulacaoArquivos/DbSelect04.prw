#Include 'protheus.ch'
#Include 'totvs.ch'

User Function DBSEL04()
    Local aArea := FWGetArea()
    Local lEncontrou := Nil

    RpcSetEnv('99', '01')

    DbSelectArea('SA2')
    DbGoTop()

    While ! SA2->( EoF() )

        If AllTrim(SA2->A2_MUN) == 'CURITIBA'
            ConOut('Nome: ' + AllTrim(SA2->A2_NOME) + 'Código: ' + AllTrim(SA2->A2_COD))
            lEncontrou := .T.
        EndIf

        SA2->( DbSkip() )
    EndDo

    If ! lEncontrou
        FWAlertError('Não existe nenhum fornecedor da cidade de Curitiba.')
    EndIf

    SA2->( DbCloseArea() )

    RpcClearEnv()
    FWRestArea(aArea)
Return
