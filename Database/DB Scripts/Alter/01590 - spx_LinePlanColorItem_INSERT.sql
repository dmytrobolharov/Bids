IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanColorItem_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanColorItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanColorItem_INSERT] (
	@LinePlanRangeID UNIQUEIDENTIFIER , 
	@LinePlanID UNIQUEIDENTIFIER , 
	@ColorPaletteID UNIQUEIDENTIFIER , 
	@CUser NVARCHAR(200), 
	@CDate DATETIME 
)
AS

IF NOT EXISTS (SELECT * FROM pLinePlanColorItem WITH(NOLOCK) WHERE LinePlanRangeID = @LinePlanRangeID AND LinePlanID = @LinePlanID AND ColorPaletteID = @ColorPaletteID) 

BEGIN
	INSERT INTO pLinePlanColorItem (LinePlanId, LinePlanRangeID, ColorPaletteID, CUser, CDate, MUser, MDate)
	VALUES (@LinePlanID, @LinePlanRangeID, @ColorPaletteID, @Cuser, @CDate, @Cuser, @CDate)
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01590'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01590', GetDate())
END	

GO

