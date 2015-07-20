/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/



ALTER   PROCEDURE [dbo].[rpx_SampleRequestSubmit_SpecImage_SELECT]
(	
	@SampleRequestSubmitID varchar(50)	
)
AS

DECLARE @StyleID varchar(50)
DECLARE	@StyleSet int
DECLARE @SpecSketchID varchar(50)
DECLARE @SpecSketchVersion nvarchar(255)
DECLARE @ImageHistoryID varchar(50)
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


SET @SQLStr = dbo.fnx_GetStreamingImagePath(@SpecSketchID, @SpecSketchVersion)	--Comment #01


SELECT @SQLStr AS ImagePath
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '802', GetDate())
GO