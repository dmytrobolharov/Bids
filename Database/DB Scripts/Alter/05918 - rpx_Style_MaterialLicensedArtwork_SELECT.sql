IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_MaterialLicensedArtwork_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_MaterialLicensedArtwork_SELECT]
GO


CREATE  PROCEDURE [dbo].[rpx_Style_MaterialLicensedArtwork_SELECT] 
	@StyleID	AS VARCHAR(255)
	,@StyleSet	As INT
	,@FlagBOM	AS INT=0
AS

BEGIN
	IF  @FlagBOM=0
	BEGIN
		SELECT ('(' + sm.MaterialNo + ') ' + sm.MaterialName) AS MaterialDescription, 
		(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath
		FROM	pStyleMaterials sm, hImage hi 
		WHERE ((sm.MaterialImageID = hi.ImageID) 
		AND (sm.MaterialImageVersion = hi.Version) 
		AND (sm.StyleSet =  @StyleSet) 
		AND (sm.StyleID = @StyleID))
		AND (sm.License = 1)
		ORDER BY sm.MainMaterial DESC, sm.MaterialType, sm.MaterialSort, sm.MaterialNo
	END
	ELSE
	IF @FlagBOM=1
	BEGIN
		SELECT ('(' + sm.MaterialNo + ') ' + sm.MaterialName) AS MaterialDescription, 
		(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath
		FROM	pStyleBOM sm, hImage hi 
		WHERE ((sm.MaterialImageID = hi.ImageID) 
		AND (sm.MaterialImageVersion = hi.Version) 
		AND (sm.StyleSet =  @StyleSet) 
		AND (sm.StyleID = @StyleID))
		AND (sm.License = 1)
		ORDER BY sm.MainMaterial DESC, sm.MaterialType, sm.MaterialSort, sm.MaterialNo
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05918', GetDate())
GO
