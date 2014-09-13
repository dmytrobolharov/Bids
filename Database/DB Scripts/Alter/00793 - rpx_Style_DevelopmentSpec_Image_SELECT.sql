/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/


ALTER    PROCEDURE [dbo].[rpx_Style_DevelopmentSpec_Image_SELECT] 
	@StyleID AS varchar(255), 
	@StyleSet int
AS
-- For Development Specification 


IF (@StyleSet = 1)
   BEGIN
	SELECT DISTINCT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath	--Comment #01
	FROM	pStyleImage si, hImage hi 
	WHERE	((si.SpecSketchID1 = hi.ImageID) 
		AND (si.SpecSketchVersion1 = hi.Version) 
		AND (CAST(si.StyleID AS varchar(255)) = @StyleID))
   END
ELSE IF (@StyleSet = 2)
   BEGIN
	SELECT DISTINCT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath	--Comment #01
	FROM	pStyleImage si, hImage hi 
	WHERE	((si.SpecSketchID2 = hi.ImageID) 
		AND (si.SpecSketchVersion2 = hi.Version) 
		AND (CAST(si.StyleID AS varchar(255)) = @StyleID))
   END
ELSE IF (@StyleSet = 3)
   BEGIN
	SELECT DISTINCT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath	--Comment #01
	FROM	pStyleImage si, hImage hi 
	WHERE	((si.SpecSketchID3 = hi.ImageID) 
		AND (si.SpecSketchVersion3 = hi.Version) 
		AND (CAST(si.StyleID AS varchar(255)) = @StyleID))
   END
ELSE IF (@StyleSet = 4)
   BEGIN
	SELECT DISTINCT (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath	--Comment #01
	FROM	pStyleImage si, hImage hi 
	WHERE	((si.SpecSketchID4 = hi.ImageID) 
		AND (si.SpecSketchVersion4 = hi.Version) 
		AND (CAST(si.StyleID AS varchar(255)) = @StyleID))
   END
ELSE
   BEGIN
	SELECT 1
   END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '793', GetDate())
GO