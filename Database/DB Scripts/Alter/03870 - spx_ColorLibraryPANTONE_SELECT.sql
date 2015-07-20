IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorLibraryPANTONE_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorLibraryPANTONE_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[spx_ColorLibraryPANTONE_SELECT] (
	@ColorLibraryTypeID varchar(40),
	@SqlString varchar(4000),
	@Red as float,
	@Green as float,
	@Blue as float
)
AS

SET @ColorLibraryTypeID  = LOWER (@ColorLibraryTypeID) 

IF @Red = 0 AND @Green = 0 AND @Blue = 0
	BEGIN
		SELECT @SqlString
	END
ELSE
	BEGIN

	DECLARE @bRed as float, @bGreen as float, @bBlue as float
	DECLARE @RedLow float, @GreenLow float, @BlueLow float
	DECLARE @RedMax float, @GreenMax float, @BlueMax float
	DECLARE @RGBMAX as varchar(20)

	CREATE TABLE #tmpColorRGB 
	(
		[ColorName] [varchar](200) NULL,
		[ColorValue] int NULL
	)

	INSERT INTO #tmpColorRGB (ColorName, ColorValue) VALUES ('Red', @Red)
	INSERT INTO #tmpColorRGB (ColorName, ColorValue) VALUES ('Green', @Green)
	INSERT INTO #tmpColorRGB (ColorName, ColorValue) VALUES ('Blue', @Blue)

	SELECT @Red = @Red/255, @Green = @Green/255, @Blue = @Blue/255
	SELECT @bRed = 0.10, @bGreen = 0.10, @bBlue = 0.10

	IF @RGBMAX = 'Red' SET @bGreen = 0.05
	IF @RGBMAX = 'Green' SET @bGreen = 0.05
	IF @RGBMAX = 'Blue' SET @bGreen = 0.05

	SELECT @RedLow = CASE 
		WHEN (@Red - @bRed) > 0 THEN (@Red - @bRed) 
		ELSE 0 END, @RedMax = (@bRed + @Red)

	SELECT @GreenLow = CASE 
		WHEN (@Green - @bGreen) > 0 THEN (@Green - @bGreen) 
		ELSE 0 END, @GreenMax = (@bGreen + @Green)

	SELECT @BlueLow = CASE 
		WHEN (@Blue - @bBlue) > 0 THEN (@Blue - @bBlue) 
		ELSE 0 END, @BlueMax = (@bBlue + @Blue)

	SELECT @RedLow = @RedLow*255, @GreenLow = @GreenLow*255, @BlueLow = @BlueLow*255
	SELECT @RedMax = @RedMax*255, @GreenMax = @GreenMax*255, @BlueMax = @BlueMax*255

	IF @ColorLibraryTypeID = '00000000-0000-0000-0000-00000000000a' --TCX
		BEGIN

			IF (SELECT COUNT(*) FROM ColorLibraryTCX WHERE  sRGB_D65_2_R BETWEEN @RedLow AND @RedMax 
					AND sRGB_D65_2_G BETWEEN @GreenLow AND @GreenMax AND sRGB_D65_2_B BETWEEN @BlueLow AND @BlueMax) <> 0
				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END
			ELSE
				BEGIN

					SELECT @bRed = 0.15, @bGreen = 0.15, @bBlue = 0.15

					IF @RGBMAX = 'Red' SET @bGreen = 0.05
					IF @RGBMAX = 'Green' SET @bGreen = 0.05
					IF @RGBMAX = 'Blue' SET @bGreen = 0.05

					SELECT @RedLow = CASE 
						WHEN (@Red - @bRed) > 0 THEN (@Red - @bRed) 
						ELSE 0 END, @RedMax = (@bRed + @Red)

					SELECT @GreenLow = CASE 
						WHEN (@Green - @bGreen) > 0 THEN (@Green - @bGreen) 
						ELSE 0 END, @GreenMax = (@bGreen + @Green)

					SELECT @BlueLow = CASE 
						WHEN (@Blue - @bBlue) > 0 THEN (@Blue - @bBlue) 
						ELSE 0 END, @BlueMax = (@bBlue + @Blue)

					SELECT @RedLow = @RedLow*255, @GreenLow = @GreenLow*255, @BlueLow = @BlueLow*255
					SELECT @RedMax = @RedMax*255, @GreenMax = @GreenMax*255, @BlueMax = @BlueMax*255

			IF (SELECT COUNT(*) FROM ColorLibraryTCX WHERE  sRGB_D65_2_R BETWEEN @RedLow AND @RedMax 
					AND sRGB_D65_2_G BETWEEN @GreenLow AND @GreenMax AND sRGB_D65_2_B BETWEEN @BlueLow AND @BlueMax) <> 0
				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END
			ELSE

					SELECT @bRed = 0.20, @bGreen = 0.20, @bBlue = 0.20

					IF @RGBMAX = 'Red' SET @bGreen = 0.05
					IF @RGBMAX = 'Green' SET @bGreen = 0.05
					IF @RGBMAX = 'Blue' SET @bGreen = 0.05

					SELECT @RedLow = CASE 
						WHEN (@Red - @bRed) > 0 THEN (@Red - @bRed) 
						ELSE 0 END, @RedMax = (@bRed + @Red)

					SELECT @GreenLow = CASE 
						WHEN (@Green - @bGreen) > 0 THEN (@Green - @bGreen) 
						ELSE 0 END, @GreenMax = (@bGreen + @Green)

					SELECT @BlueLow = CASE 
						WHEN (@Blue - @bBlue) > 0 THEN (@Blue - @bBlue) 
						ELSE 0 END, @BlueMax = (@bBlue + @Blue)

					SELECT @RedLow = @RedLow*255, @GreenLow = @GreenLow*255, @BlueLow = @BlueLow*255
					SELECT @RedMax = @RedMax*255, @GreenMax = @GreenMax*255, @BlueMax = @BlueMax*255

				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END

			END
		END 
	ELSE IF @ColorLibraryTypeID = '00000000-0000-0000-0000-00000000000b' --TPX
		BEGIN

			IF (SELECT COUNT(*) FROM ColorLibraryTPX WHERE  sRGB_D65_2_R BETWEEN @RedLow AND @RedMax 
					AND sRGB_D65_2_G BETWEEN @GreenLow AND @GreenMax AND sRGB_D65_2_B BETWEEN @BlueLow AND @BlueMax) <> 0
				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END
			ELSE
				BEGIN

					SELECT @bRed = 0.15, @bGreen = 0.15, @bBlue = 0.15

					IF @RGBMAX = 'Red' SET @bGreen = 0.05
					IF @RGBMAX = 'Green' SET @bGreen = 0.05
					IF @RGBMAX = 'Blue' SET @bGreen = 0.05

					SELECT @RedLow = CASE 
						WHEN (@Red - @bRed) > 0 THEN (@Red - @bRed) 
						ELSE 0 END, @RedMax = (@bRed + @Red)

					SELECT @GreenLow = CASE 
						WHEN (@Green - @bGreen) > 0 THEN (@Green - @bGreen) 
						ELSE 0 END, @GreenMax = (@bGreen + @Green)

					SELECT @BlueLow = CASE 
						WHEN (@Blue - @bBlue) > 0 THEN (@Blue - @bBlue) 
						ELSE 0 END, @BlueMax = (@bBlue + @Blue)

					SELECT @RedLow = @RedLow*255, @GreenLow = @GreenLow*255, @BlueLow = @BlueLow*255
					SELECT @RedMax = @RedMax*255, @GreenMax = @GreenMax*255, @BlueMax = @BlueMax*255

			IF (SELECT COUNT(*) FROM ColorLibraryTPX WHERE  sRGB_D65_2_R BETWEEN @RedLow AND @RedMax 
					AND sRGB_D65_2_G BETWEEN @GreenLow AND @GreenMax AND sRGB_D65_2_B BETWEEN @BlueLow AND @BlueMax) <> 0
				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END
			ELSE

					SELECT @bRed = 0.20, @bGreen = 0.20, @bBlue = 0.20

					IF @RGBMAX = 'Red' SET @bGreen = 0.05
					IF @RGBMAX = 'Green' SET @bGreen = 0.05
					IF @RGBMAX = 'Blue' SET @bGreen = 0.05

					SELECT @RedLow = CASE 
						WHEN (@Red - @bRed) > 0 THEN (@Red - @bRed) 
						ELSE 0 END, @RedMax = (@bRed + @Red)

					SELECT @GreenLow = CASE 
						WHEN (@Green - @bGreen) > 0 THEN (@Green - @bGreen) 
						ELSE 0 END, @GreenMax = (@bGreen + @Green)

					SELECT @BlueLow = CASE 
						WHEN (@Blue - @bBlue) > 0 THEN (@Blue - @bBlue) 
						ELSE 0 END, @BlueMax = (@bBlue + @Blue)

					SELECT @RedLow = @RedLow*255, @GreenLow = @GreenLow*255, @BlueLow = @BlueLow*255
					SELECT @RedMax = @RedMax*255, @GreenMax = @GreenMax*255, @BlueMax = @BlueMax*255

				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END

			END
		END 
	ELSE IF @ColorLibraryTypeID = '00000000-0000-0000-0000-00000000000c' -- TN
	BEGIN
		IF (SELECT COUNT(*) FROM pColorLibraryTN WHERE  sRGB_D65_2_R BETWEEN @RedLow AND @RedMax 
					AND sRGB_D65_2_G BETWEEN @GreenLow AND @GreenMax AND sRGB_D65_2_B BETWEEN @BlueLow AND @BlueMax) <> 0
				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END
			ELSE
				BEGIN

					SELECT @bRed = 0.15, @bGreen = 0.15, @bBlue = 0.15

					IF @RGBMAX = 'Red' SET @bGreen = 0.05
					IF @RGBMAX = 'Green' SET @bGreen = 0.05
					IF @RGBMAX = 'Blue' SET @bGreen = 0.05

					SELECT @RedLow = CASE 
						WHEN (@Red - @bRed) > 0 THEN (@Red - @bRed) 
						ELSE 0 END, @RedMax = (@bRed + @Red)

					SELECT @GreenLow = CASE 
						WHEN (@Green - @bGreen) > 0 THEN (@Green - @bGreen) 
						ELSE 0 END, @GreenMax = (@bGreen + @Green)

					SELECT @BlueLow = CASE 
						WHEN (@Blue - @bBlue) > 0 THEN (@Blue - @bBlue) 
						ELSE 0 END, @BlueMax = (@bBlue + @Blue)

					SELECT @RedLow = @RedLow*255, @GreenLow = @GreenLow*255, @BlueLow = @BlueLow*255
					SELECT @RedMax = @RedMax*255, @GreenMax = @GreenMax*255, @BlueMax = @BlueMax*255

			IF (SELECT COUNT(*) FROM pColorLibraryTN WHERE  sRGB_D65_2_R BETWEEN @RedLow AND @RedMax 
					AND sRGB_D65_2_G BETWEEN @GreenLow AND @GreenMax AND sRGB_D65_2_B BETWEEN @BlueLow AND @BlueMax) <> 0
				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END
			ELSE

					SELECT @bRed = 0.20, @bGreen = 0.20, @bBlue = 0.20

					IF @RGBMAX = 'Red' SET @bGreen = 0.05
					IF @RGBMAX = 'Green' SET @bGreen = 0.05
					IF @RGBMAX = 'Blue' SET @bGreen = 0.05

					SELECT @RedLow = CASE 
						WHEN (@Red - @bRed) > 0 THEN (@Red - @bRed) 
						ELSE 0 END, @RedMax = (@bRed + @Red)

					SELECT @GreenLow = CASE 
						WHEN (@Green - @bGreen) > 0 THEN (@Green - @bGreen) 
						ELSE 0 END, @GreenMax = (@bGreen + @Green)

					SELECT @BlueLow = CASE 
						WHEN (@Blue - @bBlue) > 0 THEN (@Blue - @bBlue) 
						ELSE 0 END, @BlueMax = (@bBlue + @Blue)

					SELECT @RedLow = @RedLow*255, @GreenLow = @GreenLow*255, @BlueLow = @BlueLow*255
					SELECT @RedMax = @RedMax*255, @GreenMax = @GreenMax*255, @BlueMax = @BlueMax*255

				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
						AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END

			END
	END
	ELSE IF @ColorLibraryTypeID = '00000000-0000-0000-0000-00000000000d' --PANTONE UNCOATED
			OR @ColorLibraryTypeID = '00000000-0000-0000-0000-00000000000e' --PANTONE COATED
		BEGIN

			DECLARE @Count INT 
			IF @ColorLibraryTypeID = '00000000-0000-0000-0000-00000000000d' 
				SELECT @Count = COUNT(*) FROM ColorLibraryUnCoated WHERE  sRGB_D65_2_R BETWEEN @RedLow AND @RedMax 
				AND sRGB_D65_2_G BETWEEN @GreenLow AND @GreenMax AND sRGB_D65_2_B BETWEEN @BlueLow AND @BlueMax
			ELSE 
				SELECT @Count = COUNT(*) FROM ColorLibraryCoated WHERE  sRGB_D65_2_R BETWEEN @RedLow AND @RedMax 
				AND sRGB_D65_2_G BETWEEN @GreenLow AND @GreenMax AND sRGB_D65_2_B BETWEEN @BlueLow AND @BlueMax


			IF @Count <> 0
			BEGIN
				SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
				AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
				AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
			END
			ELSE
			BEGIN

				SELECT @bRed = 0.15, @bGreen = 0.15, @bBlue = 0.15

				IF @RGBMAX = 'Red' SET @bGreen = 0.05
				IF @RGBMAX = 'Green' SET @bGreen = 0.05
				IF @RGBMAX = 'Blue' SET @bGreen = 0.05

				SELECT @RedLow = CASE 
					WHEN (@Red - @bRed) > 0 THEN (@Red - @bRed) 
					ELSE 0 END, @RedMax = (@bRed + @Red)

				SELECT @GreenLow = CASE 
					WHEN (@Green - @bGreen) > 0 THEN (@Green - @bGreen) 
					ELSE 0 END, @GreenMax = (@bGreen + @Green)

				SELECT @BlueLow = CASE 
					WHEN (@Blue - @bBlue) > 0 THEN (@Blue - @bBlue) 
					ELSE 0 END, @BlueMax = (@bBlue + @Blue)

				SELECT @RedLow = @RedLow*255, @GreenLow = @GreenLow*255, @BlueLow = @BlueLow*255
				SELECT @RedMax = @RedMax*255, @GreenMax = @GreenMax*255, @BlueMax = @BlueMax*255

				IF @ColorLibraryTypeID = '00000000-0000-0000-0000-00000000000d' 
					SELECT @Count = COUNT(*) FROM ColorLibraryUnCoated WHERE  sRGB_D65_2_R BETWEEN @RedLow AND @RedMax 
					AND sRGB_D65_2_G BETWEEN @GreenLow AND @GreenMax AND sRGB_D65_2_B BETWEEN @BlueLow AND @BlueMax
				ELSE 
					SELECT @Count = COUNT(*) FROM ColorLibraryCoated WHERE  sRGB_D65_2_R BETWEEN @RedLow AND @RedMax 
					AND sRGB_D65_2_G BETWEEN @GreenLow AND @GreenMax AND sRGB_D65_2_B BETWEEN @BlueLow AND @BlueMax


				IF @Count <> 0
				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
					AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
					AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END
				ELSE
					SELECT @bRed = 0.20, @bGreen = 0.20, @bBlue = 0.20

				IF @RGBMAX = 'Red' SET @bGreen = 0.05
				IF @RGBMAX = 'Green' SET @bGreen = 0.05
				IF @RGBMAX = 'Blue' SET @bGreen = 0.05

				SELECT @RedLow = CASE 
					WHEN (@Red - @bRed) > 0 THEN (@Red - @bRed) 
					ELSE 0 END, @RedMax = (@bRed + @Red)

				SELECT @GreenLow = CASE 
					WHEN (@Green - @bGreen) > 0 THEN (@Green - @bGreen) 
					ELSE 0 END, @GreenMax = (@bGreen + @Green)

				SELECT @BlueLow = CASE 
					WHEN (@Blue - @bBlue) > 0 THEN (@Blue - @bBlue) 
					ELSE 0 END, @BlueMax = (@bBlue + @Blue)

				SELECT @RedLow = @RedLow*255, @GreenLow = @GreenLow*255, @BlueLow = @BlueLow*255
				SELECT @RedMax = @RedMax*255, @GreenMax = @GreenMax*255, @BlueMax = @BlueMax*255

				BEGIN
					SELECT @SqlString + ' AND sRGB_D65_2_R BETWEEN ' + CAST(@RedLow AS VARCHAR(20)) + ' AND ' + CAST(@RedMax AS VARCHAR(20)) + '
					AND sRGB_D65_2_G BETWEEN ' + CAST(@GreenLow AS VARCHAR(20)) + ' AND ' + CAST(@GreenMax AS VARCHAR(20)) + '
					AND sRGB_D65_2_B BETWEEN ' + CAST(@BlueLow AS VARCHAR(20)) + ' AND ' + CAST(@BlueMax AS VARCHAR(20)) + ' '
				END

			END
		END  -- COATED / UNCOTED*/

END --  @Red = 0 AND @Green = 0 AND @Blue = 0



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03870', GetDate())
GO
