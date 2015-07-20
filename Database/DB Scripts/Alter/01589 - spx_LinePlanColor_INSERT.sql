IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanColor_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanColor_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_LinePlanColor_INSERT] (
	@LinePlanID UNIQUEIDENTIFIER , 
	@ColorPaletteID UNIQUEIDENTIFIER , 
	@CreatedBy NVARCHAR(200), 
	@CreatedDate DATETIME 
)
AS

IF NOT EXISTS (SELECT * FROM pLinePlanColor WITH(NOLOCK) WHERE LinePlanID = @LinePlanID AND ColorPaletteID = @ColorPaletteID) 

BEGIN
	INSERT INTO pLinePlanColor (LinePlanId, ColorFolderId, ColorPaletteID, CUser, CDate, MUser, MDate)
	SELECT @LinePlanID, ColorFolderID, ColorPaletteID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pColorPalette WITH(NOLOCK) WHERE ColorPaletteID = @ColorPaletteID
END




GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01589'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01589', GetDate())
END	

GO

