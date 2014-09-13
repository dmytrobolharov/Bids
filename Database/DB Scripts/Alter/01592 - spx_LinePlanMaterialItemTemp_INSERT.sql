IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMaterialItemTemp_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanMaterialItemTemp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanMaterialItemTemp_INSERT] (
	@LinePlanRangeID UNIQUEIDENTIFIER, 
	@LinePlanID UNIQUEIDENTIFIER, 
	@LinePlanColorGroupID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@MaterialAllocated INT 
)
AS

IF NOT EXISTS (SELECT * FROM pLinePlanMaterialItemTemp WHERE LinePlanRangeID = @LinePlanRangeID 
		AND LinePlanID = @LinePlanID AND MaterialID = @MaterialID AND LinePlanColorGroupID = @LinePlanColorGroupID) 

BEGIN
	INSERT INTO pLinePlanMaterialItemTemp (LinePlanMaterialItemID, LinePlanId, LinePlanRangeID, MaterialID, LinePlanColorGroupID)
	SELECT LinePlanMaterialItemID, LinePlanId, LinePlanRangeID, MaterialID, @LinePlanColorGroupID FROM pLinePlanMaterialItem
	WHERE LinePlanRangeID = @LinePlanRangeID AND LinePlanID = @LinePlanID AND MaterialID = @MaterialID 		
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01592'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01592', GetDate())
END	

GO
