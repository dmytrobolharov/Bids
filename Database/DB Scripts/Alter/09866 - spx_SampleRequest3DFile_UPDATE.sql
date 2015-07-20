IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest3DFile_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest3DFile_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest3DFile_UPDATE]
(
	@SampleRequest3DFileID UNIQUEIDENTIFIER
	, @SampleRequest3DFileDescription NVARCHAR(MAX) = NULL
	, @SampleRequest3DFileExt NVARCHAR(5) = NULL
	, @SampleRequest3DFileName NVARCHAR(500) = NULL
	, @SampleRequest3DFileSize NVARCHAR(20) = NULL
	, @SampleRequest3DFileShared INT = NULL
	, @MUser NVARCHAR(200) = NULL
	, @MDate DATETIME = NULL
)
AS
BEGIN
	UPDATE pSampleRequest3DFiles SET
		SampleRequest3DFileDescription = ISNULL(@SampleRequest3DFileDescription, s3d.SampleRequest3DFileDescription)
		, SampleRequest3DFileExt = ISNULL(@SampleRequest3DFileExt, s3d.SampleRequest3DFileExt)
		, SampleRequest3DFileName = ISNULL(@SampleRequest3DFileName, s3d.SampleRequest3DFileName)
		, SampleRequest3DFileShared = ISNULL(@SampleRequest3DFileShared, s3d.SampleRequest3DFileShared)
		, SampleRequest3DFileSize = ISNULL(@SampleRequest3DFileSize, s3d.SampleRequest3DFileSize)
		, MDate = ISNULL(@MDate, s3d.MDate)
		, MUser = ISNULL(@MUser, s3d.MUser)
	FROM pSampleRequest3DFiles s3d WHERE s3d.SampleRequest3DFileID = @SampleRequest3DFileID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09866', GetDate())
GO