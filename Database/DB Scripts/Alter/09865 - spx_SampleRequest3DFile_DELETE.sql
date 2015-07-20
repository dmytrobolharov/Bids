IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest3DFile_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest3DFile_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest3DFile_DELETE]
(
	@SampleRequest3DFileID UNIQUEIDENTIFIER
)
AS
BEGIN
	DELETE FROM pSampleRequest3DFiles
	WHERE SampleRequest3DFileID = @SampleRequest3DFileID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09865', GetDate())
GO