
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanColorItemTemp_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanColorItemTemp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanColorItemTemp_INSERT] (
	@LinePlanColorItemID UNIQUEIDENTIFIER, 
	@LinePlanColorGroupID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@ColorAllocated INT = 1 
)
AS

IF (SELECT COUNT(*) FROM pLinePlanColorItemTemp WHERE LinePlanColorItemID = @LinePlanColorItemID 
	AND LinePlanColorGroupID = @LinePlanColorGroupID) = 0

BEGIN
	INSERT INTO pLinePlanColorItemTemp (LinePlanId, LinePlanRangeID, ColorPaletteID, LinePlanColorGroupID, LinePlanColorItemID)
	SELECT LinePlanID, LinePlanRangeID, ColorPaletteID, @LinePlanColorGroupID, @LinePlanColorItemID FROM pLinePlanColorItem 
		WHERE LinePlanColorItemID = @LinePlanColorItemID 
END


GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01587'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01587', GetDate())
END	

GO

