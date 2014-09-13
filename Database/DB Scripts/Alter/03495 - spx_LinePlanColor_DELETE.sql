IF EXISTS (select * from sysobjects where id = object_id('spx_LinePlanColor_DELETE') and sysstat & 0xf = 4)
	drop procedure spx_LinePlanColor_DELETE
GO
CREATE PROCEDURE [dbo].[spx_LinePlanColor_DELETE] (
	@LinePlanID UNIQUEIDENTIFIER , 
	@ColorPaletteID UNIQUEIDENTIFIER 
)
AS
BEGIN
	DELETE FROM pLinePlanColor WHERE ColorPaletteID = @ColorPaletteID AND LinePlanID=@LinePlanID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03495', GetDate())
GO