IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequestSubmit_SpecImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequestSubmit_SpecImage_SELECT]
GO

CREATE   PROCEDURE [dbo].[rpx_SampleRequestSubmit_SpecImage_SELECT]
(	
	@SampleRequestSubmitID nvarchar(50)	
)
AS

DECLARE @StyleID nvarchar(50)
DECLARE	@StyleSet int
DECLARE @SpecSketchID nvarchar(50)
DECLARE @SpecSketchVersion nvarchar(255)
DECLARE @ImageHistoryID nvarchar(50)
DECLARE @SQLStr nvarchar(255)

/*Get some values.*/
SELECT
	@StyleID = StyleID,
	@StyleSet = StyleSet
FROM pSampleRequestSubmit
WHERE SampleRequestSubmitID = @SampleRequestSubmitID

IF (@StyleSet = 1)
	BEGIN
		SELECT @SpecSketchID = SpecSketchID1, @SpecSketchVersion = SpecSketchVersion1
		FROM pStyleImage
		WHERE StyleID = @StyleID
	END
ELSE IF (@StyleSet = 2)
	BEGIN
		SELECT @SpecSketchID = SpecSketchID2, @SpecSketchVersion = SpecSketchVersion2
		FROM pStyleImage
		WHERE StyleID = @StyleID
	END
ELSE IF (@StyleSet = 3)
	BEGIN
		SELECT @SpecSketchID = SpecSketchID3, @SpecSketchVersion = SpecSketchVersion3
		FROM pStyleImage
		WHERE StyleID = @StyleID
	END
ELSE IF (@StyleSet = 4)
	BEGIN
		SELECT @SpecSketchID = SpecSketchID4, @SpecSketchVersion = SpecSketchVersion4
		FROM pStyleImage
		WHERE StyleID = @StyleID
	END

SELECT @ImageHistoryID = ImageHistoryID
FROM hImage
WHERE (ImageID = @SpecSketchID) AND (Version = @SpecSketchVersion)


SET @SQLStr = dbo.fnx_GetStreamingImagePath(@SpecSketchID, @SpecSketchVersion, 2000)	--Comment #01


SELECT @SQLStr AS ImagePath


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10132', GetUTCDate())
GO