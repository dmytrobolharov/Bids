IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style3DFile_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style3DFile_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_Style3DFile_DELETE]
(
	@Style3DFileID UNIQUEIDENTIFIER
)
AS
BEGIN
	DELETE FROM pStyle3DFiles
	WHERE Style3DFileID = @Style3DFileID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09667', GetDate())
GO