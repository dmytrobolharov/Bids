IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLogItem_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ChangeLogItem_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_ChangeLogItem_SELECT]
(
@ChangeLogID uniqueidentifier
)
AS 

SELECT ChangeLogItemID, ChangeLogID, ChangeFieldName, ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, ChangeSort
FROM pChangeLogItem WITH (NOLOCK)
WHERE ChangeLogID = @ChangeLogID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '715', GetDate())
GO
