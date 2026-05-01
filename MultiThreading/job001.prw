#Include "totvs.ch"
#Include "protheus.ch"

User Function JOB001()
    Local aArea := FWGetArea()
    Local lWait := .F.
    StartJob("U_MeuJob", GetEnvServer(), lWait, cEmpAnt, cFilAnt)

    FWRestArea(aArea)
Return

User Function MeuJob(cEmp, cFil)
    RpcSetEnv(cEmp, cFil)

    ConOut("Iniciando a execução do MeuJob...")
    ConOut("Processando a empresa: " + cEmp + " Filial: " + cFil)

    RpcClearEnv()
Return
