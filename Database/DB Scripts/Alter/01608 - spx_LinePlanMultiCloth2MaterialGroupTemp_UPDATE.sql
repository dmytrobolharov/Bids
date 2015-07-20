IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_UPDATE]
GO

CREATE PROCEDURE  [dbo].[spx_LinePlanMultiCloth2MaterialGroupTemp_UPDATE] (
	@MaterialCoreItemID	UNIQUEIDENTIFIER,
	@MaterialCoreColorID	UNIQUEIDENTIFIER,
	@MaterialColorID	UNIQUEIDENTIFIER,
	@LinePlanColorGroupID	UNIQUEIDENTIFIER,
	@LinePlanMultiCloth2ColorTempID UNIQUEIDENTIFIER
)
AS 


UPDATE pLinePlanMultiCloth2MaterialGroupItemTemp
SET  MaterialColorID = @MaterialColorID 
WHERE MaterialCoreItemID = @MaterialCoreItemID	
AND LinePlanColorGroupID = @LinePlanColorGroupID
AND MaterialCoreColorID = @MaterialCoreColorID
AND LinePlanMultiCloth2ColorTempID = @LinePlanMultiCloth2ColorTempID





GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01608'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01608', GetDate())
END	

GO
