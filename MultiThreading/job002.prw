#Include "protheus.ch"
User Function CalcBonus()
    Local nSalBase  := 5000.00
    Local nBonus    := 10
    Local nValTotal := 0
    Local cEnv      := GetEnvServer()

    nValTotal := StartJob("U_ProcBonus", cEnv, .T., nSalBase, nBonus)

    If nValTotal <> Nil
        Alert("O valor do bonus calculado pelo Job eh: " + cValToChar(nValTotal))
    Else
        Alert("Ocorreu um erro no processamento do Job.")
    EndIf

Return

User Function ProcBonus(nSal, nPerc)
    Local nRes := 0

    nRes := (nSal * nPerc) / 100

Return nRes
