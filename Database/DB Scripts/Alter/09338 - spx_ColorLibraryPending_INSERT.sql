IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorLibraryPending_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorLibraryPending_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ColorLibraryPending_INSERT]
(
	@ColorPaletteID UNIQUEIDENTIFIER
	, @ColorFolderID UNIQUEIDENTIFIER
	, @ColorCode NVARCHAR(40)
	, @ColorName NVARCHAR(40)
	, @ColorSource NVARCHAR(150)
	, @ColorNotes NTEXT
	, @HEX NVARCHAR(10)
	, @R INT
	, @G INT
	, @B INT
	, @H DECIMAL
	, @S DECIMAL
	, @L DECIMAL
	, @LAB_L NVARCHAR(10)
	, @LAB_A NVARCHAR(10)
	, @LAB_B NVARCHAR(10)
	, @Action NVARCHAR(50)
	, @ColorImage INT
	, @CUser NVARCHAR(200)
	, @CDate DATETIME
	, @MUser NVARCHAR(200)
	, @MDate DATETIME
	, @ColorImageType NVARCHAR(5)
	, @ImageID UNIQUEIDENTIFIER = NULL
	, @ImageVersion INT = NULL	
)
AS


DECLARE @ColorCodeCount int
EXEC @ColorCodeCount = spx_ColorFolder_CheckColorCodeUnique @ColorFolderID = @ColorFolderID, @ColorCode = @ColorCode

IF @ColorCodeCount = 0
BEGIN 
	IF (SELECT COUNT(*) FROM ColorLibraryPending WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
	BEGIN
		DECLARE @SystemServerStorageID UNIQUEIDENTIFIER
		SELECT @SystemServerStorageID = SystemServerStorageID FROM pColorFolder WHERE ColorFolderID = @ColorFolderID

		INSERT INTO ColorLibraryPending (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
			HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID, 
			ColorImageType, isUpload, ImageID, ImageVersion) 
		VALUES (@ColorPaletteID, @ColorFolderID, @ColorCode,  @ColorName, 'CUSTOM', @ColorNotes, 
			@HEX, @R, @G, @B, @H, @S, @L, @LAB_L, @LAB_A, @LAB_B, @CUser, @CDate, @MUser, @MDate, @Action, @ColorImage, @SystemServerStorageID ,
			@ColorImageType, 1, @ImageID, @ImageVersion)
	END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09338', GetDate())
GO
