#Include 'totvs.ch'
#Include 'protheus.ch'

User Function COND003()
    Local aPessoas := {}
    Local nX := 0

    aAdd(aPessoas, {"Carlos Silva", "ATIVO", "ANALISTA"})
    aAdd(aPessoas, {"Mariana Souza", "INATIVO", "DIRETOR"})
    aAdd(aPessoas, {"Roberto Dias", "ATIVO", "DIRETOR"})
    aAdd(aPessoas, {"Ana Paula", "ATIVO", "GERENTE"})

    For nX := 1 To Len( aPessoas )

        If aPessoas[nX, 2] == "ATIVO" .AND. aPessoas[nX, 3] == "DIRETOR"
            FWAlertSuccess("Acesso liberado!", "Sucesso")
        EndIf

    Next nX
    
Return
