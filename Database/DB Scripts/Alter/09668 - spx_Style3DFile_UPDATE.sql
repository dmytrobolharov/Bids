IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style3DFile_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style3DFile_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Style3DFile_UPDATE]
(
	@Style3DFileID UNIQUEIDENTIFIER
	, @Style3DFileDescription NVARCHAR(MAX) = NULL
	, @Style3DFileExt NVARCHAR(5) = NULL
	, @Style3DFileName NVARCHAR(500) = NULL
	, @Style3DFileSize NVARCHAR(20) = NULL
	, @Style3DFileShared INT = NULL
	, @MUser NVARCHAR(200) = NULL
	, @MDate DATETIME = NULL
)
AS
BEGIN
	UPDATE pStyle3DFiles SET
		Style3DFileDescription = ISNULL(@Style3DFileDescription, s3d.Style3DFileDescription)
		, Style3DFileExt = ISNULL(@Style3DFileExt, s3d.Style3DFileExt)
		, Style3DFileName = ISNULL(@Style3DFileName, s3d.Style3DFileName)
		, Style3DFileShared = ISNULL(@Style3DFileShared, s3d.Style3DFileShared)
		, Style3DFileSize = ISNULL(@Style3DFileSize, s3d.Style3DFileSize)
		, MDate = ISNULL(@MDate, s3d.MDate)
		, MUser = ISNULL(@MUser, s3d.MUser)
	FROM pStyle3DFiles s3d WHERE s3d.Style3DFileID = @Style3DFileID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09668', GetDate())
GO