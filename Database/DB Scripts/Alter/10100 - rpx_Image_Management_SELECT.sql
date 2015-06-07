IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Image_Management_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Image_Management_SELECT]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rpx_Image_Management_SELECT]
	@ImageSub1 nvarchar(100) = NULL
	, @ImageCategory nvarchar(100) = NULL
	, @ImageFileType nvarchar(50) = NULL
	, @CUser nvarchar(200) = NULL
	, @MUser nvarchar(200) = NULL
	, @Keywords nvarchar(4000) = NULL
AS

DECLARE	@tmp_table TABLE
	(
		RowNumb int IDENTITY(0,1)
		, ImageType nvarchar(100)
		, ImageNo nvarchar(20)
		, ImageDescription nvarchar(200)
		, ImageCategory nvarchar(100)
		, CUser nvarchar(200)
		, CDate datetime
		, MUser nvarchar(200)
		, MDate datetime
		, ImageFileType nvarchar(50)
		, ImageFile nvarchar(max)
		, ImageSub1 nvarchar(100)
		, ImageKeywords nvarchar(4000)
	)

INSERT INTO @tmp_table
	(
		ImageType
		, ImageNo
		, ImageDescription
		, ImageCategory
		, CUser
		, CDate
		, MUser
		, MDate
		, ImageFileType
		, ImageFile
		, ImageKeywords
	)
SELECT
		ImageSubFolder1
		, ImageNo
		, ImageDescription
		, ImageSubFolder7
		, CUser
		, CDate
		, MUser
		, MDate
		, ImageFileType
		, (dbo.fnx_GetStreamingImagePath(pImage.ImageID, pImage.[Version], 2000)) AS ImageFile
		, ImageKeywords
FROM
	pImage
WHERE
	((ImageSubFolder1 = @ImageSub1 AND @ImageSub1 IS NOT NULL) OR (@ImageSub1 IS NULL))
	AND	((ImageSubFolder7 = @ImageCategory AND @ImageCategory IS NOT NULL) OR (@ImageCategory IS NULL))
	AND	((ImageFileType = @ImageFileType AND @ImageFileType IS NOT NULL) OR (@ImageFileType IS NULL))
	AND	((CUser = @CUser AND @CUser IS NOT NULL) OR (@CUser IS NULL))
	AND	((MUser = @MUser AND @MUser IS NOT NULL) OR (@MUser IS NULL))
	AND	((ImageKeywords Like '%' + @Keywords + '%' AND @Keywords IS NOT NULL) OR (@Keywords IS NULL))
ORDER BY
	ImageNo

SELECT
	RowNumb % 4 AS TableColumn
	, RowNumb / 4 AS TableRow
	, ImageType
	, ImageNo
	, ImageDescription
	, ImageCategory
	, CUser
	, CDate
	, MUser
	, MDate
	, ImageFile
FROM
	@tmp_table
ORDER BY
	ImageNo



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10100', GetUTCDate())
GO