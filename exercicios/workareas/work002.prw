#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK002()
    Local cAlias := "SB1"

    RpcSetEnv( "99", "01" )

    DbSelectArea( cAlias ) 
    DbSetOrder(1) // Indice 01 = B1_FILIAL + B1_COD 
    DbGoTop()

    While !EoF()

        If (cAlias)->(B1_TIPO) == "PA"
            ConOut("Codigo: " + AllTrim( (cAlias)->(B1_COD) ) + " Descricao: " + AllTrim( (cAlias)->(B1_DESC) ))
        EndIf

        DbSkip()
    EndDo

    DbCloseArea()

    RpcClearEnv()
Return
