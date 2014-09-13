
/****** Object:  StoredProcedure [dbo].[spx_ColorLibraryPANTONEPending_INSERT]    Script Date: 09/07/2012 12:51:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorLibraryPANTONEPending_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorLibraryPANTONEPending_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorLibraryPANTONEPending_INSERT]    Script Date: 09/07/2012 12:51:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ColorLibraryPANTONEPending_INSERT]  ( 
	@BookOrder int, 
	@PANTONEType varchar(50),
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
DECLARE @ColorCode varchar(50)
DECLARE @ColorHEX varchar(7)

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
					HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID) 
				SELECT ColorPaletteID, @ColorFolderID, PantoneNumber,  PantoneName, ColorSource, '', 
					HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, @CUser, @CDate, @MUser, @MDate, 1, @ColorImage, @SystemServerStorageID
				FROM ColorLibrary WHERE ID = @BookOrder
			
			END
		END
	END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05012', GetDate())
GO