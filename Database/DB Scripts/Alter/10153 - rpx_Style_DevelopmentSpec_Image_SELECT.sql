IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_DevelopmentSpec_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_DevelopmentSpec_Image_SELECT]
GO

CREATE    PROCEDURE [dbo].[rpx_Style_DevelopmentSpec_Image_SELECT] 
	@StyleID AS nvarchar(255), 
	@StyleSet int
AS
-- For Development Specification 


IF (@StyleSet = 1)
   BEGIN
	SELECT DISTINCT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath	--Comment #01
	FROM	pStyleImage si, hImage hi 
	WHERE	((si.SpecSketchID1 = hi.ImageID) 
		AND (si.SpecSketchVersion1 = hi.Version) 
		AND (CAST(si.StyleID AS nvarchar(255)) = @StyleID))
   END
ELSE IF (@StyleSet = 2)
   BEGIN
	SELECT DISTINCT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath	--Comment #01
	FROM	pStyleImage si, hImage hi 
	WHERE	((si.SpecSketchID2 = hi.ImageID) 
		AND (si.SpecSketchVersion2 = hi.Version) 
		AND (CAST(si.StyleID AS nvarchar(255)) = @StyleID))
   END
ELSE IF (@StyleSet = 3)
   BEGIN
	SELECT DISTINCT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath	--Comment #01
	FROM	pStyleImage si, hImage hi 
	WHERE	((si.SpecSketchID3 = hi.ImageID) 
		AND (si.SpecSketchVersion3 = hi.Version) 
		AND (CAST(si.StyleID AS nvarchar(255)) = @StyleID))
   END
ELSE IF (@StyleSet = 4)
   BEGIN
	SELECT DISTINCT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath	--Comment #01
	FROM	pStyleImage si, hImage hi 
	WHERE	((si.SpecSketchID4 = hi.ImageID) 
		AND (si.SpecSketchVersion4 = hi.Version) 
		AND (CAST(si.StyleID AS nvarchar(255)) = @StyleID))
   END
ELSE
   BEGIN
	SELECT 1
   END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10153', GetUTCDate())
GO