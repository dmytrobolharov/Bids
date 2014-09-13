--WI # 21576 : Color Folder - Create New Unique ID for pColorPalette

IF OBJECT_ID(N'spx_ColorLibraryPANTONEPending_INSERT', N'P') IS NOT NULL
DROP PROCEDURE [dbo].[spx_ColorLibraryPANTONEPending_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ColorLibraryPANTONEPending_INSERT]  ( 
	@BookOrder int, 
	@PANTONEType nvarchar(50),
	@ColorPaletteID uniqueidentifier, 
	@ColorFolderID uniqueidentifier, 
	@ColorImage int,
	@CUser nVarchar (200), 
	@CDate datetime,
	@MUser nVarchar (200), 
	@MDate datetime  
) 
AS

DECLARE @SystemServerStorageID UNIQUEIDENTIFIER
DECLARE @ColorCode nvarchar(50)
DECLARE @ColorHEX nvarchar(7)

IF @PANTONEType = 'PANTONE TCX'
	BEGIN
		SELECT @ColorCode = PANTONEColor FROM ColorLibraryTCX WHERE BookOrder = @BookOrder AND PANTONEType = 'PANTONE TCX'

		IF (SELECT COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
		BEGIN 
			IF (SELECT COUNT(*) FROM ColorLibraryPending WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
			BEGIN
				SELECT @SystemServerStorageID = SystemServerStorageID FROM pColorFolder WHERE ColorFolderID = @ColorFolderID

				INSERT INTO ColorLibraryPending (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
					HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID) 
				SELECT @ColorPaletteId, @ColorFolderId, PANTONEColor, PANTONEName, PANTONEType, '' AS ColorNotes, 
					sRGB_HTML, sRGB_D65_2_R, sRGB_D65_2_G, sRGB_D65_2_B, 0 AS H, 0 AS S, 0 AS L, 
					CIELab_D50_2_L, CIELab_D50_2_A, CIELab_D50_2_B, @CUser, @CDate, @MUser, @MDate, 1, @ColorImage, @SystemServerStorageID 
				FROM ColorLibraryTCX WHERE BookOrder = @BookOrder

			END
		END
	END
ELSE IF @PANTONEType = 'PANTONE TPX'
	BEGIN
		SELECT @ColorCode = PANTONEColor FROM ColorLibraryTPX WHERE BookOrder = @BookOrder AND PANTONEType = 'PANTONE TPX'

		IF (SELECT COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
		BEGIN 
			IF (SELECT COUNT(*) FROM ColorLibraryPending WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
			BEGIN		
				SELECT @SystemServerStorageID = SystemServerStorageID FROM pColorFolder WHERE ColorFolderID = @ColorFolderID

				INSERT INTO ColorLibraryPending (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
					HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID) 
				SELECT @ColorPaletteId, @ColorFolderId, PANTONEColor, PANTONEName, PANTONEType, '' AS ColorNotes, 
					sRGB_HTML, sRGB_D65_2_R, sRGB_D65_2_G, sRGB_D65_2_B, 0 AS H, 0 AS S, 0 AS L, 
					CIELab_D50_2_L, CIELab_D50_2_A, CIELab_D50_2_B, @CUser, @CDate, @MUser, @MDate, 1, @ColorImage, @SystemServerStorageID 
				FROM ColorLibraryTPX WHERE BookOrder = @BookOrder

			END
		END
	END
ELSE IF @PANTONEType = 'PANTONE TN'
	BEGIN
		SELECT @ColorCode = PANTONEColor FROM pColorLibraryTN WHERE BookOrder = @BookOrder AND PANTONEType = 'PANTONE TN'

		IF (SELECT COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
		BEGIN 
			IF (SELECT COUNT(*) FROM ColorLibraryPending WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
			BEGIN		
				SELECT @SystemServerStorageID = SystemServerStorageID FROM pColorFolder WHERE ColorFolderID = @ColorFolderID

				INSERT INTO ColorLibraryPending (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
					HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID) 
				SELECT @ColorPaletteId, @ColorFolderId, PANTONEColor, PANTONEName, PANTONEType, '' AS ColorNotes, 
					sRGB_HTML, sRGB_D65_2_R, sRGB_D65_2_G, sRGB_D65_2_B, 0 AS H, 0 AS S, 0 AS L, 
					CIELab_D50_2_L, CIELab_D50_2_A, CIELab_D50_2_B, @CUser, @CDate, @MUser, @MDate, 1, @ColorImage, @SystemServerStorageID 
				FROM pColorLibraryTN WHERE BookOrder = @BookOrder

			END
		END
	END
ELSE IF @PANTONEType = 'PANTONE COATED'
	BEGIN

		SELECT @ColorCode = PANTONEColor FROM ColorLibraryCoated WHERE BookOrder = @BookOrder AND PANTONEType = 'PANTONE COATED'

		IF (SELECT COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
		BEGIN 
			IF (SELECT COUNT(*) FROM ColorLibraryPending WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
			BEGIN		
				SELECT @SystemServerStorageID = SystemServerStorageID FROM pColorFolder WHERE ColorFolderID = @ColorFolderID

				INSERT INTO ColorLibraryPending (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
					HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID) 
				SELECT @ColorPaletteId, @ColorFolderId, PANTONEColor, PANTONEName, PANTONEType, '' AS ColorNotes, 
					sRGB_HTML, sRGB_D65_2_R, sRGB_D65_2_G, sRGB_D65_2_B, 0 AS H, 0 AS S, 0 AS L, 
					CIELab_D50_2_L, CIELab_D50_2_A, CIELab_D50_2_B, @CUser, @CDate, @MUser, @MDate, 1, @ColorImage, @SystemServerStorageID 
				FROM ColorLibraryCoated WHERE BookOrder = @BookOrder

			END
		END
	END
ELSE IF @PANTONEType = 'PANTONE UNCOATED'
	BEGIN

		SELECT @ColorCode = PANTONEColor FROM ColorLibraryUncoated WHERE BookOrder = @BookOrder AND PANTONEType = 'PANTONE UNCOATED'

		IF (SELECT COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
		BEGIN 
			IF (SELECT COUNT(*) FROM ColorLibraryPending WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
			BEGIN		
				SELECT @SystemServerStorageID = SystemServerStorageID FROM pColorFolder WHERE ColorFolderID = @ColorFolderID

				INSERT INTO ColorLibraryPending (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
					HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID) 
				SELECT @ColorPaletteId, @ColorFolderId, PANTONEColor, PANTONEName, PANTONEType, '' AS ColorNotes, 
					sRGB_HTML, sRGB_D65_2_R, sRGB_D65_2_G, sRGB_D65_2_B, 0 AS H, 0 AS S, 0 AS L, 
					CIELab_D50_2_L, CIELab_D50_2_A, CIELab_D50_2_B, @CUser, @CDate, @MUser, @MDate, 1, @ColorImage, @SystemServerStorageID 
				FROM ColorLibraryUncoated WHERE BookOrder = @BookOrder

			END
		END
	END

ELSE IF @PANTONEType = 'PANTONE Pastels & Neons COATED'
	BEGIN

		SELECT @ColorCode = PANTONEColor FROM ColorLibraryPantonePNCoated WHERE BookOrder = @BookOrder AND PANTONEType = 'PANTONE Pastels & Neons COATED'

		IF (SELECT COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
		BEGIN 
			IF (SELECT COUNT(*) FROM ColorLibraryPending WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
			BEGIN		
				SELECT @SystemServerStorageID = SystemServerStorageID FROM pColorFolder WHERE ColorFolderID = @ColorFolderID

				INSERT INTO ColorLibraryPending (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
					HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID) 
				SELECT @ColorPaletteId, @ColorFolderId, PANTONEColor, PANTONEName, PANTONEType, '' AS ColorNotes, 
					sRGB_HTML, sRGB_D65_2_R, sRGB_D65_2_G, sRGB_D65_2_B, 0 AS H, 0 AS S, 0 AS L, 
					CIELab_D50_2_L, CIELab_D50_2_A, CIELab_D50_2_B, @CUser, @CDate, @MUser, @MDate, 1, @ColorImage, @SystemServerStorageID 
				FROM ColorLibraryPantonePNCoated WHERE BookOrder = @BookOrder

			END
		END
	END
ELSE IF @PANTONEType = 'PANTONE Pastels & Neons UNCOATED'
	BEGIN

		SELECT @ColorCode = PANTONEColor FROM ColorLibraryPantonePNUncoated WHERE BookOrder = @BookOrder AND PANTONEType = 'PANTONE Pastels & Neons UNCOATED'

		IF (SELECT COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
		BEGIN 
			IF (SELECT COUNT(*) FROM ColorLibraryPending WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
			BEGIN		
				SELECT @SystemServerStorageID = SystemServerStorageID FROM pColorFolder WHERE ColorFolderID = @ColorFolderID

				INSERT INTO ColorLibraryPending (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
					HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID) 
				SELECT @ColorPaletteId, @ColorFolderId, PANTONEColor, PANTONEName, PANTONEType, '' AS ColorNotes, 
					sRGB_HTML, sRGB_D65_2_R, sRGB_D65_2_G, sRGB_D65_2_B, 0 AS H, 0 AS S, 0 AS L, 
					CIELab_D50_2_L, CIELab_D50_2_A, CIELab_D50_2_B, @CUser, @CDate, @MUser, @MDate, 1, @ColorImage, @SystemServerStorageID 
				FROM ColorLibraryPantonePNUncoated WHERE BookOrder = @BookOrder

			END
		END
	END
ELSE
	BEGIN
		SELECT @ColorCode = PantoneNumber, @ColorHEX = [HEX] FROM ColorLibrary WHERE ID = @BookOrder --AND PantoneType = 'Burberry Default'
		
		IF @ColorHEX IS NULL 
		BEGIN
			SET @ColorImage = 1
		END
			
		IF (SELECT COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
		BEGIN 
			IF (SELECT COUNT(*) FROM ColorLibraryPending WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
			BEGIN		
				SELECT @SystemServerStorageID = SystemServerStorageID FROM pColorFolder WHERE ColorFolderID = @ColorFolderID

				INSERT INTO ColorLibraryPending (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
					HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID, ColorLibraryID
					--** Comment#01
					,ColorPaletteCustom1,ColorPaletteCustom2,ColorPaletteCustom3,ColorPaletteCustom4,ColorPaletteCustom5,ColorPaletteCustom6,ColorPaletteCustom7
					,ColorPaletteCustom8,ColorPaletteCustom9,ColorPaletteCustom10) 
				SELECT a.ColorPaletteID, @ColorFolderID, a.PantoneNumber,  a.PantoneName, a.ColorSource, b.ColorNotes, 
					a.HEX, a.R, a.G, a.B, a.H, a.S, a.L, a.LAB_L, a.LAB_A, a.LAB_B, @CUser, @CDate, @MUser, @MDate, 1, @ColorImage, @SystemServerStorageID, a.ColorLibraryID
					--** Comment#01
					,b.ColorPaletteCustom1,b.ColorPaletteCustom2,b.ColorPaletteCustom3,b.ColorPaletteCustom4,b.ColorPaletteCustom5,b.ColorPaletteCustom6,b.ColorPaletteCustom7
					,b.ColorPaletteCustom8,b.ColorPaletteCustom9,b.ColorPaletteCustom10
				FROM ColorLibrary a LEFT OUTER JOIN pColorPalette b ON a.ColorLibraryID = b.ColorLibraryID AND a.ColorPaletteID = b.ColorPaletteID WHERE a.ID = @BookOrder
			
			END
		END
	END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06737', GetDate())
GO
