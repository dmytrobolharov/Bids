IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningAttribute_Full_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_Full_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_Full_SELECT]
	@PlanningID UNIQUEIDENTIFIER
AS
BEGIN
	WITH dsc as (
		SELECT b.CustomID as BrandID, b.Custom as Brand, vw.*, 
		CASE 
			WHEN vw.AttributeLevel = 1 THEN 1 -- divisions level
			WHEN vw.AttributeLevel IN (2,3) AND pb.PlanningPlanningCh > 0 THEN 1 
		ELSE 0 
		END IsVisible 
		FROM vwx_Division_StyleType_StyleCategory_SELECT vw
			INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID	
			INNER JOIN vwx_Division_SEL d ON pd.DivisionID = d.CustomID
			INNER JOIN pBrand b ON d.BrandID = b.CustomID	
			LEFT JOIN pPlanningBusiness pb ON vw.DivisionID = pb.PlanningDivisionID 
				AND ISNULL(vw.StyleTypeID,'0') = ISNULL(pb.PlanningStyleTypeID, '0')
				AND ISNULL(vw.StyleCategoryID,'00000000-0000-0000-0000-000000000000') = ISNULL(pb.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000')
				AND pb.PlanningID = @PlanningID
				AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000000') -- Number of Styles
				
	SELECT DISTINCT b.CustomID AS BrandID, b.Custom AS Brand, NULL AS DivisionID, NULL AS DivisionName, 
		NULL AS StyleTypeID, NULL AS StyleTypeDescription, 
		NULL AS StyleCategoryID, NULL AS StyleCategory, 
		0 AS AttributeLevel, 1 as IsVisible,
		NULL as DeliveryID, NULL as DeliveryName
	FROM pPlanningDivision pd
	INNER JOIN vwx_Division_SEL d ON pd.DivisionID = d.CustomID
	INNER JOIN pBrand b ON d.BrandID = b.CustomID
	WHERE pd.PlanningID = @PlanningID
	
	UNION 
	
	SELECT *, NULL as DeliveryID, NULL as DeliveryName FROM dsc
	
	UNION 
	
	SELECT dsc.BrandID, dsc.Brand, dsc.DivisionID, dsc.DivisionName, 
		dsc.StyleTypeID, dsc.StyleTypeDescription, 
		dsc.StyleCategoryID, dsc.StyleCategory, 
		4 AS AttributeLevel, 1 as IsVisible, d.DeliveryID, d.DeliveryName 
	FROM dsc 
	INNER JOIN pDivisionDelivery dd ON dsc.DivisionID = dd.DivisionID
	INNER JOIN pDelivery d ON dd.DeliveryID = d.DeliveryID
	WHERE StyleCategoryID IS NOT NULL AND dd.DivisionActive = 1
	
	ORDER BY Brand, DivisionName, StyleTypeDescription, StyleCategory, DeliveryName
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06313', GetDate())
GO
