/****** Object:  StoredProcedure [dbo].[spx_ColorLibraryPending_INSERT]    Script Date: 07/30/2012 12:29:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorLibraryPending_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorLibraryPending_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_ColorLibraryPending_INSERT]    Script Date: 07/30/2012 12:29:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ColorLibraryPending_INSERT]  ( 
	@ColorPaletteID uniqueidentifier, 
	@ColorFolderID uniqueidentifier, 
	@ColorCode nvarchar(40),
	@ColorName nvarchar(40),
	@ColorSource nvarchar(150),
	@ColorNotes ntext,
	@HEX nvarchar(10),
	@R int,
	@G int,
	@B int,
	@H decimal,
	@S decimal,
	@L decimal,
	@LAB_L nvarchar(10),
	@LAB_A nvarchar(10),
	@LAB_B nvarchar(10),
	@Action nvarchar(50),
	@ColorImage int,
	@CUser nVarchar (200), 
	@CDate datetime,
	@MUser nVarchar (200), 
	@MDate datetime  
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
			HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID, ColorImageType) 
		VALUES (@ColorPaletteID, @ColorFolderID, @ColorCode,  @ColorName, 'CUSTOM', @ColorNotes, 
			@HEX, @R, @G, @B, @H, @S, @L, @LAB_L, @LAB_A, @LAB_B, @CUser, @CDate, @MUser, @MDate, @Action, @ColorImage, @SystemServerStorageID , '2')
	END
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03729', GetDate())
GO