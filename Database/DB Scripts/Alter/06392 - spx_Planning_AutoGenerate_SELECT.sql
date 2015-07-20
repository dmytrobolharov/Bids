IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_AutoGenerate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_AutoGenerate_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Planning_AutoGenerate_SELECT]
	@PlanningID UNIQUEIDENTIFIER
AS
BEGIN

	CREATE TABLE #tmpAttributeList (DivisionID UNIQUEIDENTIFIER, 
								DivisionName NVARCHAR(200) COLLATE database_default, 
								StyleTypeID INT, 
								StyleTypeDescription NVARCHAR(200) COLLATE database_default,
								StyleCategoryID UNIQUEIDENTIFIER,
								StyleCategory NVARCHAR(200) COLLATE database_default,
								AttributeLevel INT, 
								IsVisible INT)

	CREATE TABLE #tmpAttrbuteNoOfStyles (DivisionID UNIQUEIDENTIFIER, 
								StyleTypeID INT, 
								StyleCategoryID UNIQUEIDENTIFIER,
								PlanningPlanningCh DECIMAL(18,5),
								PlanningDIPCh DECIMAL(18,5),
								PlanningActualCh DECIMAL(18,5))

	CREATE TABLE #tmpAttrbuteCarryOverStyles (DivisionID UNIQUEIDENTIFIER, 
								StyleTypeID INT, 
								StyleCategoryID UNIQUEIDENTIFIER,
								PlanningPlanningCh DECIMAL(18,5),
								PlanningDIPCh DECIMAL(18,5),
								PlanningActualCh DECIMAL(18,5))


	INSERT INTO #tmpAttrbuteNoOfStyles
	SELECT vw.DivisionID,  vw.StyleTypeID, vw.StyleCategoryID,
		pb.PlanningPlanningCh, pb.PlanningDIPCh, pb.PlanningActualCh
	FROM vwx_Division_StyleType_StyleCategory_SELECT vw
		INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID
		INNER JOIN pPlanningBusiness pb ON vw.DivisionID = pb.PlanningDivisionID 
			AND vw.StyleTypeID = pb.PlanningStyleTypeID
			AND vw.StyleCategoryID = pb.PlanningStyleCategoryID
			AND pb.PlanningID = @PlanningID
			AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000000' -- Number of Styles

	INSERT INTO #tmpAttrbuteCarryOverStyles
	SELECT vw.DivisionID,  vw.StyleTypeID, vw.StyleCategoryID,
		pb.PlanningPlanningCh, pb.PlanningDIPCh, pb.PlanningActualCh
	FROM vwx_Division_StyleType_StyleCategory_SELECT vw
		INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID
		INNER JOIN pPlanningBusiness pb ON vw.DivisionID = pb.PlanningDivisionID 
			AND vw.StyleTypeID = pb.PlanningStyleTypeID
			AND vw.StyleCategoryID = pb.PlanningStyleCategoryID
			AND pb.PlanningID = @PlanningID
			AND pb.PlanningFinancialID = '10000000-0000-0000-0000-000000000001' -- Number of Carry Over Styles
	

	INSERT INTO #tmpAttributeList
	EXEC spx_Planning_LinePlanningAttribute_SELECT @PlanningID
	
	SELECT pc.PlanningConfigID, pc.WorkflowTemplateID,
		CASE WHEN pc.PlanningConfigID IS NULL THEN 0 ELSE 1 END as ConfigExists,
		((tmp1.PlanningPlanningCh - tmp2.PlanningPlanningCh) - (tmp1.PlanningDIPCh - tmp2.PlanningDIPCh) - (tmp1.PlanningActualCh - tmp2.PlanningActualCh)) as NoOfStyles
	FROM #tmpAttributeList attr
		LEFT JOIN pPlanningConfig pc ON attr.DivisionID = pc.DivisionID 
			AND attr.StyleTypeID = pc.StyleTypeID
			AND attr.StyleCategoryID = pc.StyleCategoryID
			AND pc.PlanningID = @PlanningID
		INNER JOIN #tmpAttrbuteNoOfStyles tmp1 ON attr.DivisionID = tmp1.DivisionID 
			AND attr.StyleTypeID = tmp1.StyleTypeID
			AND attr.StyleCategoryID = tmp1.StyleCategoryID
		INNER JOIN #tmpAttrbuteCarryOverStyles tmp2 ON attr.DivisionID = tmp2.DivisionID 
			AND attr.StyleTypeID = tmp2.StyleTypeID
			AND attr.StyleCategoryID = tmp2.StyleCategoryID
	WHERE attr.DivisionID IS NOT NULL AND attr.StyleTypeID IS NOT NULL AND attr.StyleCategoryID IS NOT NULL
	ORDER BY DivisionName, StyleTypeDescription, StyleCategory


	
	DROP TABLE #tmpAttributeList
	DROP TABLE #tmpAttrbuteNoOfStyles
	DROP TABLE #tmpAttrbuteCarryOverStyles
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06392', GetDate())
GO
