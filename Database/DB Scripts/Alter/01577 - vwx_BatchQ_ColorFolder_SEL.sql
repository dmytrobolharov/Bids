IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_ColorFolder_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_ColorFolder_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_ColorFolder_SEL]
AS

	SELECT * FROM dbo.pColorFolder
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01577'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01577', GetDate())
END	

GO
