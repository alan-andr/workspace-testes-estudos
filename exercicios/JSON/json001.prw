#Include 'protheus.ch'
#Include 'totvs.ch'

User Function JSON001()
    Local aArea   := FWGetArea()
    Local jJson   := jsonObject():New()
    Local cResult := ''
    Local aProps  := {}

    jJson['nome'] := 'Ignácio'
    jJson['sobrenome'] := 'Alvares'
    jJson['email'] := 'ignacio@gmail.com'
    jJson['tel'] := '84991005566'
    jJson['contatos'] := {}

    aAdd(jJson['contatos'], jJson['email'])
    aAdd(jJson['contatos'], jJson['tel'])

    aProps := jJson:GetNames()

    FWAlertInfo('Quantidade de propriedades no JSON: ' + cValToChar( Len(aProps) ))

    If jJson:HasProperty('nome')
        cResult := jJson:GetJsonText('nome')

        FWAlertInfo('O nome contido na propriedade "nome": ' + cResult)
    Else
        FWAlertError('Não existe essa propriedade no JSON.')
    EndIf

    FWRestArea(aArea)
Return
