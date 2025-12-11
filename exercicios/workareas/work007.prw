#Include 'protheus.ch'
#Include 'totvs.ch'

User Function WORK007()
    Local cAliasSE1 := "SE1"
    Local cAliasSA1 := "SA1"

    Local cCodCli := ""
    Local cLojaCli := ""
    Local cNomFantas := ""
    Local nValor := 0

    RpcSetEnv("99", "01")

    DbSelectArea( cAliasSA1 )
    DbSetOrder(1)

    DbSelectArea( cAliasSE1 )
    DbSetOrder(1)
    DbGoTop()

    While .NOT. ( cAliasSE1 )->( EoF() )

        nValor := ( cAliasSE1 )->( E1_VALOR )

        If nValor > 5000

            cCodCli := ( cAliasSE1 )->( E1_CLIENTE )
            cLojaCli := ( cAliasSE1 )->( E1_LOJA)

            DbSelectArea(cAliasSA1)

            If DbSeek( xFilial( cAliasSA1 ) + cCodCli + cLojaCli )
                cNomFantas := ( cAliasSA1 )->( A1_NOME )
            Else
                cNomFantas := "CLIENTE DESCONHECIDO"
            EndIf

            ConOut("Titulo Alto Valor: " + cCodCli + " | Nome: " + cNomFantas + " | R$ " + cValToChar(nValor))

        Else 

            DbSelectArea(cAliasSE1)

        EndIf

        ( cAliasSE1 )->( DbSkip() )

    EndDo

    DbCloseArea()

    RpcClearEnv()
Return
