#Include 'totvs.ch'
#Include 'protheus.ch'

User Function EX002TST()
    Local cMsg := FwInputBox("Insira uma palavra: ")

    If !Empty(cMsg)
        MsgInfo("Você digitou: " + cMsg, "Mensagem")
    Else 
        MsgAlert("Você não inseriu nenhum valor", "Aviso")
    EndIf
Return
