#Include "protheus.ch"
#Include "totvs.ch"

// ! https://tdn.totvs.com/display/tec/StartJob

User Function MT010INC()
    Local aArea := FWGetArea()
    Local lAguardar := .F.

    // * Aciona a função que vai criar o saldo no armazém padrão e vai disparar em e-mail, mas sem barrar o processo principal (caso haja algum error log)
    StartJob("U_zMulti01", GetEnvServer(), lAguardar, cEmpAnt, cFilAnt, SB1->B1_COD, SB1->B1_LOCPAD)

    FWRestArea(aArea)
Return

User Function U_zMulti01(cParEmp, cParFil, cParProduto, cParArmazem)
    Local aArea    := {}
    Local aRet     := {Nil, ""} // * [1] Houve falha {.T. = Sim, .F. = Não}; [2] Texto de observação
    Local aDados   := {}
    Local aLogAuto := {}
    Local nAux     := 0 
    Local cLogTxt  := ""

    // * Variáveis para o disparo do e-mail
    Local cAssunto  := ""
    Local cMensagem := ""
    Local cPara     := "alanrecordes@gmail.com"

    // * Abaixo o usuário e senha que serão usados para realizar a alteração
    // * O ideal aqui é encapsular essa senha em um parâmetro ou txt, para não deixar chumbada no fonte
    // * Deixar chumbado é uma péssima prática
    // * Aqui poderia ser algo como MemoRead(), GetMv() não daria pois precisa carregar o dicionário primeiro, a não ser que você passe a senha
    // * por parâmetro direto na chamada da user function, por exemplo, cParPass ali após dParVencto
    Local cArqConf := MemoRead("c:\temp\x_config\autoarmazem.txt") // * Salvar como usuário e senha depois transformar para base64 
    Local cTxt     := Decode64(cArqConf)
    Local aUsuario := StrTokArr(cTxt, "|")
    Local cUsuario := aUsuario[1]
    Local cPass    := aUsuario[2]

    // * Variáveis de controle do ExecAuto
    Private lMsHelpAuto      := .T.
    Private lMsAutoErrNoFIle := .T.
    Private lMsErroAuto      := .F.

    // * Prepara o ambiente da empresa
    If Select("SX2") == 0
        RpcSetEnv(cParEmp, cParFil, cUsuario, cPass, "COM")
    EndIf

    aArea := FWGetArea()

    // * Adiciona os campos
    aadd(aDados, {"B9_COD"  , cParProduto, Nil})
    aadd(aDados, {"B9_LOCAL", cParArmazem, Nil})
    aadd(aDados, {"B9_QINI" , 0          , Nil})

    // * Chama a inclusão
    MsExecAuto({|a, b| MATA020(a, b)}, aDados, 3)

    // * Se houve erro, mostra a mensagem  e aborta o restante das operações
    If lMsErroAuto 
        aLogAuto := GetAutoGrLog()

        For nAux := 1 To Len(aLogAuto)
            cLogTxt += aLogAuto[nAux] + CRLF
        Next nAux

        aRet[1] := .T.
        aRet[2] := cLogTxt
    Else
        aRet[1] := .F.
        aRet[2] := "Saldo inicial no armazém cadastrado com sucesso!"
    EndIf

    // * Agora realiza o disparo do e-mail
    cAssunto  := "[Produtos] Novo produto incluído: " + SB1->B1_COD
    cMensagem := ""
    cMensagem += "<p>Olá.</p>"
    cMensagem += "<p>Um novo produto foi cadastrado no sistema, no dia " + dToC( Date() ) + " às " + Time() + ".</p>"
    cMensagem += "<p><strong>Abaixo as informações do Produto:</strong></p>"
    cMensagem += "<p>Código: " + AllTrim(SB1->B1_COD) + "</p>"
    cMensagem += "<p>Descrição: " + AllTrim(SB1->B1_DESC) + "</p>"
    cMensagem += "<p>Tipo: " + AllTrim(SB1->B1_TIPO) + "</p>"
    cMensagem += "<p>U.M: " + AllTrim(SB1->B1_UM) + "</p>"
    cMensagem += "<br>"
    cMensagem += "<p>" + aRet[2] + "</p>"
    GpeMail(cAssunto, cMensagem, cPara)

    FWRestArea(aArea)
Return
