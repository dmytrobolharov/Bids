IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ChangeLogItem_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_ChangeLogItem_SEL]
GO


CREATE VIEW [dbo].[vwx_ChangeLogItem_SEL]
AS

SELECT b.ChangeTableID, b.ChangeTablePKID, b.ChangeUserName, b.ChangeDate,a.*,
c.ChangeTransTablePKID 
FROM dbo.pChangeLogItem a WITH (NOLOCK)
	INNER JOIN	dbo.pChangeLog b WITH (NOLOCK) ON a.ChangeLogID = b.ChangeLogID
	INNER JOIN dbo.pChangeTransaction c WITH (NOLOCK) ON c.ChangeTransID = a.ChangeTransID 

GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '685', GetDate())
GO
