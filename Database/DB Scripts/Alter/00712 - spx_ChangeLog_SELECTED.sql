IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLog_SELECTED]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ChangeLog_SELECTED]
GO

CREATE PROCEDURE [dbo].[spx_ChangeLog_SELECTED]
(
@ChangeLogID uniqueidentifier
)
AS 

SELECT ChangeLogID, ChangeTableID, ChangeTablePKID, ChangeUserID, ChangeUserName, ChangeDate, ChangeSort
FROM pChangeLog WITH (NOLOCK)
WHERE ChangeLogID = @ChangeLogID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '712', GetDate())
GO
