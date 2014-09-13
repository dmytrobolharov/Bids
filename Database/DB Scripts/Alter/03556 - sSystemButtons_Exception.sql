SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE UPPER(DesignString) = UPPER('btn_exception.gif'))
BEGIN

	INSERT INTO sSystemButtons ([ButtonIcon], [DesignString], [en_US])
	VALUES ('Icon_warning.gif', 'btn_exception.gif', 'exceptions')

END
GO


SET NOCOUNT Off
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03556', GetDate())
GO