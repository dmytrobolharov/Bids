IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_BOMMaterialUsage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_BOMMaterialUsage]
GO


CREATE PROCEDURE [dbo].[dpx_BOMMaterialUsage]
AS
BEGIN

	CREATE TABLE #tmpMaterials
	(
		MaterialID UNIQUEIDENTIFIER,
		StyleID UNIQUEIDENTIFIER,
		SeasonYearID UNIQUEIDENTIFIER,
		Qty DECIMAL (18,3),
		MaterialPrice DECIMAL (18,3),
		Cost DECIMAL (18,3),
		Unit DECIMAL (18,3),
		TotalProjAmount DECIMAL (18,3),
		TotalProjCost DECIMAL (18,3)
	)

	INSERT INTO #tmpMaterials (MaterialID, StyleID, SeasonYearID, Unit)
	SELECT DISTINCT pMaterial.MaterialID, pStyleHeader.StyleID, pSeasonYear.SeasonYearID, pStyleCostingHeader.StyleCostingCustomField8
	FROM  pStyleBOM INNER JOIN
			  pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID INNER JOIN
			  pStyleHeader ON pStyleBOM.StyleID = pStyleHeader.StyleID INNER JOIN
			  pStyleCostingHeader ON pStyleHeader.StyleID = pStyleCostingHeader.StyleID INNER JOIN
			  pComponentType ON pMaterial.MaterialType = pComponentType.ComponentTypeID INNER JOIN
			  pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID INNER JOIN
			  pStyleSeasonYear ON pStyleCostingHeader.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID AND pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
			  pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID INNER JOIN
			  iCustom1 ON pStyleHeader.DivisionID = CAST(iCustom1.CustomID AS VARCHAR(40))
	WHERE pWorkFlowItem.WorkStatus <> 101 -- rejected status
	
	
	UPDATE #tmpMaterials
	SET Qty = 
	(
		SELECT AVG(pStyleBOMItem.MaterialQuantity) FROM pStyleBOMItem INNER JOIN 
			pStyleBOM ON pStyleBOMItem.StyleMaterialID = pStyleBOM.StyleMaterialID INNER JOIN
			pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID INNER JOIN
			pStyleSeasonYear ON pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		WHERE pStyleBOM.StyleID = #tmpMaterials.StyleID AND pstylebom.MaterialID = #tmpMaterials.MaterialID
			AND pStyleSeasonYear.SeasonYearID = #tmpMaterials.SeasonYearID
	),
	MaterialPrice = 
	(
		SELECT AVG(pStyleBOMItem.MaterialPrice) FROM pStyleBOMItem INNER JOIN 
			pStyleBOM ON pStyleBOMItem.StyleMaterialID = pStyleBOM.StyleMaterialID INNER JOIN
			pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID INNER JOIN
			pStyleSeasonYear ON pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		WHERE pStyleBOM.StyleID = #tmpMaterials.StyleID AND pstylebom.MaterialID = #tmpMaterials.MaterialID
			AND pStyleSeasonYear.SeasonYearID = #tmpMaterials.SeasonYearID
	)
	
	UPDATE #tmpMaterials SET Qty = 0 WHERE Qty IS NULL
	UPDATE #tmpMaterials SET MaterialPrice = 0 WHERE MaterialPrice IS NULL
	
	UPDATE #tmpMaterials 
	SET Cost = ISNULL(Qty, 0) * ISNULL(MaterialPrice, 0)
	
	UPDATE #tmpMaterials 
	SET TotalProjAmount = ISNULL(Unit, 0) * ISNULL(Qty, 0), 
		TotalProjCost = ISNULL(Unit, 0) * ISNULL(Cost, 0)
	
	/*  select result  */
	SELECT pSeasonYear.Season, pSeasonYear.Year, iCustom1.CustomID AS DivisionID, iCustom1.Custom AS Division, 
			  pComponentType.ComponentDescription, pMaterial.MaterialID, pMaterial.MaterialNo, pMaterial.MaterialName, pStyleHeader.StyleID, pStyleHeader.StyleNo, pStyleHeader.Description,
			  tm.Qty, tm.MaterialPrice, tm.Cost, tm.Unit, tm.TotalProjAmount, tm.TotalProjCost
	FROM #tmpMaterials tm INNER JOIN 
		pMaterial ON tm.MaterialID = pMaterial.MaterialID INNER JOIN
		pComponentType ON pMaterial.MaterialType = pComponentType.ComponentTypeID INNER JOIN
		pSeasonYear ON tm.SeasonYearID = pSeasonYear.SeasonYearID INNER JOIN
		pStyleHeader ON tm.StyleID = pStyleHeader.StyleID INNER JOIN
		iCustom1 ON pStyleHeader.DivisionID = CAST(iCustom1.CustomID AS VARCHAR(40))
	ORDER BY pSeasonYear.Year DESC, pSeasonYear.Season, Division, pComponentType.ComponentDescription, pMaterial.MaterialNo, 
		pStyleHeader.StyleNo
		

	DROP TABLE #tmpMaterials
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05899', GetDate())
GO
