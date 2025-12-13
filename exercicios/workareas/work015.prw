#Include 'totvs.ch'
#Include 'protheus.ch'

User Function WORK015()
    Local cCod := ""
    Local cNome := ""
    Local cLoja := ""

    RpcSetEnv("99", "01")

    DbSelectArea("SA2")
    DbSetOrder(2)
    DbGoTop()

    If SA2->( EoF() )

        Alert("A tabela SA2 não possui registros.")

    Else 

        While !SA2->( EoF() )

            If xFilial("SA2") == SA2->A2_FILIAL
                cCod := SA2->A2_COD
                cNome := SA2->A2_NOME
                cLoja := SA2->A2_LOJA

                ConOut("A2_COD: " + cCod + " A2_NOME: " + cNome + " A2_LOJA: " + cLoja)
            EndIf

            SA2->( DbSkip() )

        EndDo

    EndIF

    SA2->( DbCloseArea() )

    RpcClearEnv()
Return
