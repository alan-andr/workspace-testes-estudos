#Include "protheus.ch"
#Include "totvs.ch"

// ! https://tdn.totvs.com/display/public/framework/LockByName
// ! https://tdn.totvs.com/pages/releaseview.action?pageId=6814897 UnlockByName

User Function zMulti02()
    Local aArea := FWGetArea()

    // * Se não conseguir travar, quer dizer que algum usuário já está executando
    If ! LockByName("zMulti02_lock", .T., .F.)
        FWAlertError("Atenção, outro usuário já está executando essa rotina", "Falha no Lock")

    // * Senão, aciona o processamento das rotinas
    Else 
        Processa({|| fSuaRotina()}, "Exportando...")

        // * Aciona o destravamento do lock
        UnlockByName("zMulti02_lock", .T., .F.)
    EndIf

    FWRestArea(aArea)
Return 

Static Function fSuaRotina()
    FWAlertInfo("Em construção", "Teste")
Return
