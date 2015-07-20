IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeTransaction_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ChangeTransaction_DELETE]
GO


CREATE procedure [dbo].[spx_ChangeTransaction_DELETE] (@ChangeTransID uniqueidentifier)
AS


IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
BEGIN

	--It will clean the change tranasaction table if it no change found.
	IF NOT EXISTS(SELECT ChangeLogItemID, ChangeTransID, ChangeLogID, ChangeFieldName, 
			ChangeFieldAlias, ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText,  
			ChangeAfterText, ChangeSort FROM pChangeLogItem 
		WHERE EXISTS (SELECT ChangeLogID FROM pChangeLog WHERE ChangeTransID = @ChangeTransID))
	BEGIN
		DELETE FROM pChangeLog WHERE ChangeTransID = @ChangeTransID
	END

	IF NOT EXISTS(SELECT * FROM pChangeLog WHERE ChangeTransID = @ChangeTransID) 
	BEGIN
		DELETE FROM pChangeTransaction WHERE ChangeTransID = @ChangeTransID
	END

END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '720', GetDate())
GO
