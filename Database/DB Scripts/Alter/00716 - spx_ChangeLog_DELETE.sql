IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLog_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ChangeLog_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_ChangeLog_DELETE]
(
@ChangeLogID uniqueidentifier
)
AS 

DELETE FROM pChangeLog WHERE ChangeLogID = @ChangeLogID



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '716', GetDate())
GO
