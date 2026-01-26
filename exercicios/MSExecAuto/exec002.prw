#Include 'totvs.ch'
#Include 'protheus.ch'

User Function AUTOFORN()
    Local aArea   := FWGetArea()
    Local cA2cod  := 'FOR001'
    Local cA2loja := '01'
    Local cA2nome := 'INDUSTRIA METALURGICA DO SUL'
    Local cA2nomf := 'METAL SUL'
    Local cA2end  := 'AVENIDA DAS INDUSTRIAS, 4500'
    Local cA2tipo := 'J'
    Local cA2mun  := 'CURITIBA'
    Local cA2est  := 'PR'
    Local cA2cgc  := '53194165000199'
    Local aDados  := {}

    Private lMsErroAuto := .F.

    RpcSetEnv('99', '01')

    aadd(aDados, {'A2_COD'   , cA2cod , Nil})
    aadd(aDados, {'A2_LOJA'  , cA2loja, Nil})
    aadd(aDados, {'A2_NOME'  , cA2nome, Nil})
    aadd(aDados, {'A2_NREDUZ', cA2nomf, Nil})
    aadd(aDados, {'A2_END'   , cA2end , Nil})
    aadd(aDados, {'A2_TIPO'  , cA2tipo, Nil})
    aadd(aDados, {'A2_MUN'   , cA2mun , Nil})
    aadd(aDados, {'A2_EST'   , cA2est , Nil})
    aadd(aDados, {'A2_CGC'   , cA2cgc , Nil})

    MsExecAuto( {|a, b| MATA020(a, b)}, aDados, 3 )

    If lMsErroAuto 
        MostraErro()
    Else
        FWAlertSuccess('Fornecedor: ' + cA2nome + ' incluído com sucesso na SA2!', 'Atenção')
    EndIf

    RpcClearEnv()

    FWRestArea(aArea)
Return
