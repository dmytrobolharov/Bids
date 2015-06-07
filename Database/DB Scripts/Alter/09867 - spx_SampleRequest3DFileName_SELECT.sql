IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest3DFileName_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest3DFileName_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SampleRequest3DFileName_SELECT]
(
	@SampleRequest3DFileID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT SampleRequest3DFileName
	FROM pSampleRequest3DFiles
	WHERE SampleRequest3DFileID = @SampleRequest3DFileID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09867', GetDate())
GO