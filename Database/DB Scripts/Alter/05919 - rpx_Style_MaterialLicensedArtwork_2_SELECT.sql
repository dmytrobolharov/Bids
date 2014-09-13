IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_MaterialLicensedArtwork_2_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_MaterialLicensedArtwork_2_SELECT]
GO


CREATE     PROCEDURE [dbo].[rpx_Style_MaterialLicensedArtwork_2_SELECT] 
	@StyleID	AS VARCHAR(255)
	,@StyleSet	As INT
	,@FlagBOM	AS INT
AS

BEGIN
	CREATE TABLE #tempLicensedArtworkImages
	(
		TableRow int identity(0,1),
		MaterialDescription nvarchar(255),
		FilePath nvarchar(255)
	)
	
	IF  @FlagBOM=0
	BEGIN
		/*Insert the images into the temp table so that they can be arranged for a matrix.*/
		INSERT INTO #tempLicensedArtworkImages (MaterialDescription, FilePath)
		SELECT ('(' + sm.MaterialNo + ') ' + sm.MaterialName) AS MaterialDescription, 
			(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath	--Comment #01
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
		/*Insert the images into the temp table so that they can be arranged for a matrix.*/
		INSERT INTO #tempLicensedArtworkImages (MaterialDescription, FilePath)
		SELECT ('(' + sm.MaterialNo + ') ' + sm.MaterialName) AS MaterialDescription, 
			(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath	--Comment #01
		FROM	pStyleBOM sm, hImage hi 
		WHERE ((sm.MaterialImageID = hi.ImageID) 
			AND (sm.MaterialImageVersion = hi.Version) 
			AND (sm.StyleSet =  @StyleSet) 
			AND (sm.StyleID = @StyleID))
			AND (sm.License = 1)
		ORDER BY sm.MainMaterial DESC, sm.MaterialType, sm.MaterialSort, sm.MaterialNo
	END

	IF((SELECT COUNT(*) FROM #tempLicensedArtworkImages) = 0)
		BEGIN
			SELECT 0 AS [Column],
			0 AS Row,
			'' AS MaterialDescription,
			'' AS Filepath
		END
	ELSE
		BEGIN
			SELECT
				TableRow % 2 AS [Column],
				TableRow / 2 AS Row,
				MaterialDescription,
				FilePath
			FROM #tempLicensedArtworkImages	
		END

	DROP TABLE #tempLicensedArtworkImages
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05919', GetDate())
GO
