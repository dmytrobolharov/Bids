--WI # 24037 : Unlock Button Logic

IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE UPPER(DesignString) = UPPER('btn_unlockheader.gif'))
BEGIN

	INSERT INTO sSystemButtons ([ButtonIcon], [DesignString], [en_US])
	VALUES ('Icon_unlock32.png', 'btn_unlockheader.gif', 'unlock header')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07452', GetDate())
GO