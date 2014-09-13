/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningAttribute_Full_SELECT]    Script Date: 07/07/2014 12:20:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_LinePlanningAttribute_Full_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_LinePlanningAttribute_Full_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningAttribute_Full_SELECT]    Script Date: 07/07/2014 12:20:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_LineFolder_LinePlanningAttribute_Full_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @LineFolderDivisionID UNIQUEIDENTIFIER
	SELECT @LineFolderDivisionID = LineFolderDivisionID FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
	;WITH dsc as (
		SELECT b.CustomID as BrandID, b.Custom as Brand,
		vw.DivisionID, vw.DivisionName, vw.StyleTypeID, vw.StyleTypeDescription, vw.StyleCategoryID, vw.StyleCategory, 
		CASE 
			WHEN pb.PlanningSubCategoryID IS NOT NULL THEN 4 ELSE vw.AttributeLevel END as AttributeLevel,
		CASE 
			WHEN vw.AttributeLevel = 1 THEN 1 -- divisions level
			WHEN vw.AttributeLevel IN (2,3) AND (pb.PlanningPlanningCh > 0 OR pb.PlanningDIPCh > 0 OR pb.PlanningActualCh > 0) THEN 1 
		ELSE 0 
		END IsVisible, 
		pb.PlanningSubCategoryID, pb.PlanningSubCategory, 
		(
			SELECT COUNT(*) FROM pPlanningStyleCategoryToSubCategory psctsc
			WHERE psctsc.PlanningID = pb.PlanningID
				AND psctsc.PlanningBrandID = pb.PlanningBrandID
				AND psctsc.PlanningDivisionID = pb.PlanningDivisionID
				AND psctsc.PlanningStyleTypeID = pb.PlanningStyleTypeID 
				AND psctsc.PlanningStyleCategoryID = pb.PlanningStyleCategoryID
				AND psctsc.SeasonYearID = pb.SeasonYearID
		) AS SubCategoriesCount
		FROM vwx_Division_StyleType_StyleCategory_SELECT vw
			INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID	
			INNER JOIN vwx_Division_SEL d ON pd.DivisionID = d.CustomID
			INNER JOIN pBrand b ON d.BrandID = b.CustomID	
			LEFT JOIN pPlanningBusiness pb ON vw.DivisionID = pb.PlanningDivisionID 
				AND SeasonYearID = @SeasonYearID
				AND ISNULL(vw.StyleTypeID,'0') = ISNULL(pb.PlanningStyleTypeID, '0')
				AND ISNULL(vw.StyleCategoryID,'00000000-0000-0000-0000-000000000000') = ISNULL(pb.PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000')
				AND pb.PlanningID = @PlanningID
				AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000000'
		WHERE vw.DivisionID = @LineFolderDivisionID
		AND (vw.StyleCategoryID IS NULL OR vw.StyleCategoryID IN (SELECT StyleCategoryID FROM pLineFolderStyleCategory WHERE LineFolderID = @LineFolderID))
		AND (vw.StyleTypeID IS NULL OR vw.StyleTypeID IN (SELECT StyleTypeID FROM pLineFolderStyleType WHERE LineFolderID = @LineFolderID))
	) -- Number of Styles
				
	SELECT DISTINCT b.CustomID AS BrandID, b.Custom AS Brand, NULL AS DivisionID, NULL AS DivisionName, 
		NULL AS StyleTypeID, NULL AS StyleTypeDescription, 
		NULL AS StyleCategoryID, NULL AS StyleCategory, 
		0 AS AttributeLevel, 1 as IsVisible,
		NULL as PlanningSubCategoryID, NULL as PlanningSubCategory, 0 as SubCategoriesCount 
		--,NULL as DeliveryID, NULL as DeliveryName
	FROM pPlanningDivision pd
	INNER JOIN vwx_Division_SEL d ON pd.DivisionID = d.CustomID
	INNER JOIN pBrand b ON d.BrandID = b.CustomID
	WHERE pd.PlanningID = @PlanningID
	
	UNION 
	
	SELECT *--, NULL as DeliveryID, NULL as DeliveryName
	FROM dsc
	
	--UNION 
	
	--SELECT dsc.BrandID, dsc.Brand, dsc.DivisionID, dsc.DivisionName, 
	--	dsc.StyleTypeID, dsc.StyleTypeDescription, 
	--	dsc.StyleCategoryID, dsc.StyleCategory, 
	--	5 AS AttributeLevel, 1 as IsVisible, 
	--	dsc.PlanningSubCategoryID, dsc.PlanningSubCategory, dsc.SubCategoriesCount,
	--	d.DeliveryID, d.DeliveryName 
	--FROM dsc 
	--INNER JOIN pDivisionDelivery dd ON dsc.DivisionID = dd.DivisionID
	--INNER JOIN pDelivery d ON dd.DeliveryID = d.DeliveryID
	--WHERE StyleCategoryID IS NOT NULL AND dd.DivisionActive = 1
	--AND (PlanningSubCategoryID IS NOT NULL OR (PlanningSubCategoryID IS NULL AND SubCategoriesCount = 0))
	
	ORDER BY Brand, DivisionName, StyleTypeDescription, StyleCategory, PlanningSubCategory--, DeliveryName
	
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08235', GetDate())
GO
