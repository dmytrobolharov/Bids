/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/



ALTER   PROCEDURE [dbo].[rpx_Style_ImageSummary_SELECT] 
	@StyleID AS varchar(255), 
	@StyleSet As int
AS


CREATE TABLE #tempImageDesign
(
	ImageRow int identity(0,1),
	ImageName nvarchar(255),
	ImagePath nvarchar(255),
	ImageType varchar(50)
)
 
CREATE TABLE #tempImageDetail
(
	ImageRow int identity(0,1),
	ImageName nvarchar(255),
	ImagePath nvarchar(255),
	ImageType varchar(50)
)

CREATE TABLE #tempImageDevelopment
(
	ImageRow int identity(0,1),
	ImageName nvarchar(255),
	ImagePath nvarchar(255),
	ImageType varchar(50)
)
 
CREATE TABLE #tempImageMaterial
(
	ImageRow int identity(0,1),
	ImageName nvarchar(255),
	ImagePath nvarchar(255),
	ImageType varchar(50)
)
 
CREATE TABLE #tempImageArtwork
(
	ImageRow int identity(0,1),
	ImageName nvarchar(255),
	ImagePath nvarchar(255),
	ImageType varchar(50)
)
 
CREATE TABLE #tempImageLicense
(
	ImageRow int identity(0,1),
	ImageName nvarchar(255),
	ImagePath nvarchar(255),
	ImageType varchar(50)
)

CREATE TABLE #tempImage
(
	ImageRow int,
	ImageType varchar(50),
	ImageName0 nvarchar(255),
	ImagePath0 nvarchar(255),
	ImageName1 nvarchar(255),
	ImagePath1 nvarchar(255),
	ImageName2 nvarchar(255),
	ImagePath2 nvarchar(255),
	ImageName3 nvarchar(255),
	ImagePath3 nvarchar(255)
)

DECLARE @I as int
DECLARE @Row_Count int
DECLARE @ImageRow int
DECLARE @ImageMod int
DECLARE @ImageName varchar(255)
DECLARE @ImagePath varchar(255)
DECLARE @ImageTypeCode varchar(200)
DECLARE @ImageTypeName varchar(200)


-- BEGIN Design Sketch
BEGIN
	SET @ImageTypeCode = 'Design'
	SET @ImageTypeName = 'Design Sketch'
	INSERT INTO #tempImageDesign (ImageName, ImagePath, ImageType)
	SELECT @ImageTypeName AS ImageName, 
		(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS ImagePath,	--Comment #01
		@ImageTypeCode AS ImageType 	
	FROM pStyleHeader AS sm INNER JOIN
	  hImage AS hi ON sm.DesignSketchID = hi.ImageID AND sm.DesignSketchVersion = hi.Version
	WHERE (sm.StyleID = @StyleID)

	INSERT INTO #tempImage (ImageRow, ImageName0, ImagePath0, ImageType)
	SELECT 0 AS ImageRow, ImageName, ImagePath, @ImageTypeCode AS ImageType FROM #tempImageDesign
END
-- END Design Sketch

-- BEGIN Detail Sketch
BEGIN
	SET @ImageTypeCode = 'Detail'
	SET @ImageTypeName = 'Detail Sketch'
	INSERT INTO #tempImageDetail (ImageName, ImagePath, ImageType)
	SELECT @ImageTypeName AS ImageName, 
		(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS ImagePath,	--Comment #01
		@ImageTypeCode AS ImageType 	
	FROM   pStyleImageItem AS sm INNER JOIN
	  hImage AS hi ON sm.ImageID = hi.ImageID AND sm.ImageVersion = hi.Version
	WHERE ((sm.StyleSet =  @StyleSet) AND (sm.StyleID = @StyleID) AND (sm.ImageVersion <> 0))
	ORDER BY sm.Sort

	BEGIN
		SET @I = 0
		SET @Row_Count = (SELECT COUNT(*) FROM #tempImageDetail)

		WHILE @I < @Row_Count 
		
			BEGIN
				SET @ImageName = ''
				SET @ImagePath = ''
				
				SELECT @ImageRow = ImageRow % 4, @ImageName = ImageName, @ImagePath = ImagePath FROM #tempImageDetail WHERE ImageRow = @I
				
				IF @ImageRow = 0
					BEGIN
						SET @ImageMod = @I
						INSERT INTO #tempImage (ImageRow, ImageName0, ImagePath0, ImageType)
						SELECT @I, ImageName, ImagePath, @ImageTypeCode AS ImageType FROM #tempImageDetail WHERE ImageRow = @I
					END
				ELSE IF @ImageRow = 1
					BEGIN
						UPDATE #tempImage SET ImageName1 = @ImageName, ImagePath1 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				ELSE IF @ImageRow = 2
					BEGIN
						UPDATE #tempImage SET ImageName2 = @ImageName, ImagePath2 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				ELSE IF @ImageRow = 3
					BEGIN
						UPDATE #tempImage SET ImageName3 = @ImageName, ImagePath3 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				SET @I = @I + 1
			END
		
	END
END

-- END Detail Sketch

-- BEGIN Development Sketch
BEGIN
	SET @ImageTypeCode = 'Development'
	SET @ImageTypeName = 'Development Spec Image'
	INSERT INTO #tempImageDevelopment (ImageName, ImagePath, ImageType)
	SELECT @ImageTypeName AS ImageName, 
		(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS ImagePath,	--Comment #01
		@ImageTypeCode AS ImageType 	
	FROM pStyleImage AS sm INNER JOIN
	  hImage AS hi ON sm.SpecSketchID1 = hi.ImageID AND sm.SpecSketchVersion1 = hi.Version
	WHERE (sm.StyleID = @StyleID)

	INSERT INTO #tempImage (ImageRow, ImageName0, ImagePath0, ImageType)
	SELECT 0 AS ImageRow, ImageName, ImagePath, @ImageTypeCode AS ImageType FROM #tempImageDevelopment
END

-- BEGIN Material Sketch
BEGIN
	SET @ImageTypeCode = 'Material'
	SET @ImageTypeName = 'Material Sketch'
	INSERT INTO #tempImageMaterial (ImageName, ImagePath, ImageType)
	SELECT ('(' + sm.MaterialNo + ') ' + sm.MaterialName) AS ImageName, 
		(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS ImagePath,	--Comment #01
		@ImageTypeCode AS ImageType 	
	FROM pStyleMaterials AS sm INNER JOIN
	hImage AS hi ON sm.MaterialImageID = hi.ImageID AND sm.MaterialImageVersion = hi.Version
	WHERE ((sm.StyleSet =  @StyleSet) 
		AND (sm.StyleID = @StyleID))
	ORDER BY sm.MainMaterial DESC, sm.MaterialType, sm.MaterialSort, sm.MaterialNo

	BEGIN
		SET @I = 0
		SET @Row_Count = (SELECT COUNT(*) FROM #tempImageMaterial)

		WHILE @I < @Row_Count 
		
			BEGIN
				SET @ImageName = ''
				SET @ImagePath = ''
				
				SELECT @ImageRow = ImageRow % 4, @ImageName = ImageName, @ImagePath = ImagePath FROM #tempImageMaterial WHERE ImageRow = @I
				
				IF @ImageRow = 0
					BEGIN
						SET @ImageMod = @I
						INSERT INTO #tempImage (ImageRow, ImageName0, ImagePath0, ImageType)
						SELECT @I, ImageName, ImagePath, @ImageTypeCode AS ImageType FROM #tempImageMaterial WHERE ImageRow = @I
					END
				ELSE IF @ImageRow = 1
					BEGIN
						UPDATE #tempImage SET ImageName1 = @ImageName, ImagePath1 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				ELSE IF @ImageRow = 2
					BEGIN
						UPDATE #tempImage SET ImageName2 = @ImageName, ImagePath2 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				ELSE IF @ImageRow = 3
					BEGIN
						UPDATE #tempImage SET ImageName3 = @ImageName, ImagePath3 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				SET @I = @I + 1
			END
		
	END
END

-- END Detail Sketch	

-- BEGIN License Images
BEGIN
	SET @ImageTypeCode = 'License'
	SET @ImageTypeName = 'License Images'

	INSERT INTO #tempImageLicense (ImageName, ImagePath, ImageType)
	SELECT ('(' + sm.MaterialNo + ') ' + sm.MaterialName) AS ImageName, 
		(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS ImagePath,	--Comment #01
		@ImageTypeCode AS ImageType 	
	FROM pStyleMaterials AS sm INNER JOIN
	hImage AS hi ON sm.MaterialImageID = hi.ImageID AND sm.MaterialImageVersion = hi.Version
	WHERE ((sm.StyleSet =  @StyleSet) 
		AND (sm.StyleID = @StyleID))
		AND (sm.License = 1)
	ORDER BY sm.MainMaterial DESC, sm.MaterialType, sm.MaterialSort, sm.MaterialNo

	BEGIN
		SET @I = 0
		SET @Row_Count = (SELECT COUNT(*) FROM #tempImageLicense)

		WHILE @I < @Row_Count 
		
			BEGIN
				SET @ImageName = ''
				SET @ImagePath = ''
				
				SELECT @ImageRow = ImageRow % 4, @ImageName = ImageName, @ImagePath = ImagePath FROM #tempImageLicense WHERE ImageRow = @I
				
				IF @ImageRow = 0
					BEGIN
						SET @ImageMod = @I
						INSERT INTO #tempImage (ImageRow, ImageName0, ImagePath0, ImageType)
						SELECT @I, ImageName, ImagePath, @ImageTypeCode AS ImageType FROM #tempImageLicense WHERE ImageRow = @I
					END
				ELSE IF @ImageRow = 1
					BEGIN
						UPDATE #tempImage SET ImageName1 = @ImageName, ImagePath1 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				ELSE IF @ImageRow = 2
					BEGIN
						UPDATE #tempImage SET ImageName2 = @ImageName, ImagePath2 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				ELSE IF @ImageRow = 3
					BEGIN
						UPDATE #tempImage SET ImageName3 = @ImageName, ImagePath3 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				SET @I = @I + 1
			END
		
	END
END


-- BEGIN Artwork Sketch
BEGIN

	SET @ImageTypeCode = 'Artwork'
	SET @ImageTypeName = 'Artwork Images'

	INSERT INTO #tempImageArtwork (ImageName, ImagePath, ImageType)
	SELECT ('(' + sm.MaterialNo + ') ' + sm.MaterialName) AS ImageName, 
		(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS ImagePath,	--Comment #01
		@ImageTypeCode AS ImageType 	
	FROM pStyleMaterials AS sm INNER JOIN
	hImage AS hi ON sm.MaterialImageID = hi.ImageID AND sm.MaterialImageVersion = hi.Version
	WHERE ((sm.StyleSet =  @StyleSet) 
		AND (sm.StyleID = @StyleID))
		AND (sm.Artwork = 1)
	ORDER BY sm.MainMaterial DESC, sm.MaterialType, sm.MaterialSort, sm.MaterialNo

	BEGIN
		SET @I = 0
		SET @Row_Count = (SELECT COUNT(*) FROM #tempImageArtwork)

		WHILE @I < @Row_Count 
		
			BEGIN
				SET @ImageName = ''
				SET @ImagePath = ''
				
				SELECT @ImageRow = ImageRow % 4, @ImageName = ImageName, @ImagePath = ImagePath FROM #tempImageArtwork WHERE ImageRow = @I
				
				IF @ImageRow = 0
					BEGIN
						SET @ImageMod = @I
						INSERT INTO #tempImage (ImageRow, ImageName0, ImagePath0, ImageType)
						SELECT @I, ImageName, ImagePath, @ImageTypeCode AS ImageType FROM #tempImageArtwork WHERE ImageRow = @I
					END
				ELSE IF @ImageRow = 1
					BEGIN
						UPDATE #tempImage SET ImageName1 = @ImageName, ImagePath1 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				ELSE IF @ImageRow = 2
					BEGIN
						UPDATE #tempImage SET ImageName2 = @ImageName, ImagePath2 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				ELSE IF @ImageRow = 3
					BEGIN
						UPDATE #tempImage SET ImageName3 = @ImageName, ImagePath3 = @ImagePath WHERE ImageRow = @ImageMod AND ImageType = @ImageTypeCode
					END
				SET @I = @I + 1
			END
		
	END
END
	
BEGIN
	SELECT * FROM #tempImage
END

BEGIN
	DROP TABLE #tempImage
	DROP TABLE #tempImageDesign
	DROP TABLE #tempImageDetail
	DROP TABLE #tempImageDevelopment
	DROP TABLE #tempImageMaterial
	DROP TABLE #tempImageArtwork
	DROP TABLE #tempImageLicense	
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '847', GetDate())
GO