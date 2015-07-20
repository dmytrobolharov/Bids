IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialTemp_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialTemp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialTemp_INSERT] (
	@LinePlanRangeID UNIQUEIDENTIFIER, 
	@LinePlanID UNIQUEIDENTIFIER, 
	@LinePlanColorGroupID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialAllocated INT
)
AS

IF (SELECT COUNT(*) FROM pLinePlanMultiCloth2MaterialTemp WHERE LinePlanRangeID = @LinePlanRangeID AND LinePlanID = @LinePlanID AND MaterialID = @MaterialID AND LinePlanColorGroupID = @LinePlanColorGroupID) = 0
BEGIN
	INSERT INTO pLinePlanMultiCloth2MaterialTemp (LinePlanMaterialItemID, LinePlanId, LinePlanRangeID, MaterialID, LinePlanColorGroupID)
	SELECT LinePlanMaterialItemID, LinePlanId, LinePlanRangeID, MaterialID, @LinePlanColorGroupID FROM pLinePlanMaterialItem
	WHERE LinePlanRangeID = @LinePlanRangeID AND LinePlanID = @LinePlanID AND MaterialID = @MaterialID 		
END

--This logic will apply only if you need color to load from main material color as style colorways
BEGIN
	--Select SeasonYearID from pLinePlan table
	DECLARE @LineSeason varchar(100)
	DECLARE @LineYear int
	DECLARE @LineSeasonYearID uniqueidentifier

	SELECT @LineSeason = [Season], @LineYear = [YEAR] FROM pLinePlan WHERE LinePlanID = @LinePlanID
	SELECT @LineSeasonYearID = SeasonYearID FROM pSeasonYear WHERE [Year] = @LineYear AND [Season] = @LineSeason 

	--Insert Material values to pLinePlanMultiCloth2
	INSERT INTO pLinePlanMultiCloth2ColorTemp (LinePlanColorGroupID, LinePlanRangeID, LinePlanID, MaterialColorID, MaterialID, ColorPaletteID)
	SELECT @LinePlanColorGroupID, @LinePlanRangeID, @LinePlanID, pMaterialColorSeasonYear.MaterialColorID, pMaterialColor.MaterialID, pMaterialColor.ColorPaletteID
	FROM  pMaterialColor INNER JOIN
	  pMaterialColorSeasonYear ON pMaterialColor.MaterialColorID = pMaterialColorSeasonYear.MaterialColorID
	 WHERE SeasonYearID = @LineSeasonYearID AND pMaterialColor.MaterialID = @MaterialId

END


GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01593'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01593', GetDate())
END	

GO

