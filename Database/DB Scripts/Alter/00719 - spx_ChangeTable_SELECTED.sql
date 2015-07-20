IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeTable_SELECTED]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ChangeTable_SELECTED]
GO

CREATE PROCEDURE [dbo].[spx_ChangeTable_SELECTED]
(
@ChangeTableID uniqueidentifier
)
AS 

SELECT ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML 
FROM pChangeTable WITH (NOLOCK)
WHERE ChangeTableID = @ChangeTableID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '719', GetDate())
GO
