IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUPlan_Items_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUPlan_Items_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUPlan_Items_SELECT]
(
	@PlanningSKUHeaderID UNIQUEIDENTIFIER
	, @SearchCond NVARCHAR(MAX)
	, @SelectedDimensions nVARCHAR(MAX)
	, @TeamID UNIQUEIDENTIFIER
	, @PlanningItems nVARCHAR(MAX) = ''
)
AS
BEGIN
	DECLARE @SelDims TABLE (DimTypeID UNIQUEIDENTIFIER)

	INSERT INTO @SelDims (DimTypeID)
	SELECT value
	FROM dbo.fnx_Split(@SelectedDimensions, ',')
	
	DECLARE @tmpPlanningItem TABLE (PlanningItemID UNIQUEIDENTIFIER)

	INSERT INTO @tmpPlanningItem (PlanningItemID)
	SELECT value
	FROM dbo.fnx_Split(@PlanningItems, ',')

	SELECT DISTINCT pli.PlanningID
		, pli.PlanningItemID
		, pli.PlanningItemDrop
		, pli.PlanningItemDropUser
		, pli.PlanningItemDropDate
		, pli.PlanningImageID
		, pli.PlanningImageVersion
		, pli.CUser
		, pli.CDate
		, pli.MUser
		, pli.MDate
		, pli.MChange
		, pli.StyleID
		, pli.ConceptNo
		, pli.DevelopmentNo
		, pli.StyleNo
		, pli.CustomField1
		, pli.PatternRef
		, pli.Description
		, pli.DMCStyleType
		, pli.FabricYarnType
		, pli.MainMaterial
		, pli.[Content]
		, pli.FabricWeight
		, pli.SizeRange
		, pli.SizeClass
		, pli.DesignSketchID
		, pli.DesignSketchVersion
		, pli.PlanningItemSort
		, pli.StyleCategoryId
		, pli.StyleType
		, pli.WorkflowType
		, pli.DueDate
		, pli.RecDate
		, pli.TradePartnerID
		, pli.IntroSeasonYearID
		, pli.StyleSeasonYearID
		, pli.ColorwaySeasonYearID
		, pli.DivisionID
		, pli.StyleCategory
		, pli.TeamId
		, pli.AccessRoleId
		, pli.AccessModify
		, pli.CustomField3
		, pli.SeasonYearID
		, pli.StyleBOMDimensionID
		, pli.SubCategoryId
		, pli.[Image]
		, pli.DivisionName
		, pli.StyleTypeDescription
		, pli.StyleCategoryName
		, pli.IntroSeasonYear
		, '<a href="Planning_StyleProperty.aspx?SID=' + CAST(pli.StyleID AS NVARCHAR(50)) + '&SYID=' + CAST(pli.SeasonYearID AS NVARCHAR(50)) + '&PIID=' + CAST(pli.PlanningItemID AS NVARCHAR(50)) + '&SHID=' + CAST(@PlanningSKUHeaderID AS NVARCHAR(50)) + '&RT=SKUP">' + pli.StyleNo + '</a>' AS StylePropertyLink
		, pli.SubCategoryName
		, pli.DevelopmentID
		, wfi.WorkFlowItemName + CASE WHEN pli.StyleBOMDimensionID != ssh.StyleBOMDimensionID THEN '&nbsp;<img style="vertical-align:middle;" src="../System/Icons/icon_info.gif">' ELSE '' END AS BOMName
		, ssh.StyleSKUItemID
		, ssh.Dimensions
		, psh.PlanningSKUHeaderID
		, CASE 
			WHEN pli.PlanningItemDrop = 'Yes'
				THEN '<img src="../System/Icons/icon_drop.gif" />'
			ELSE ''
			END AS PlanningItemDropIcon
		, ws.WorkflowStatusRepId
		, '<img src="../System/Icons/' + ssh.WorkflowStatusImage + '"> 
		<a href="../Style/Style_Frame.aspx?P=40000000-0000-0000-0000-000000000090&WFIID=' + CAST(ssh.WorkFlowItemID AS nVARCHAR(50)) + '&SID=' + CAST(pli.StyleID AS nVARCHAR(50)) + '&SYID=' + CAST(ssy.SeasonYearID AS nVARCHAR(50)) + '" target="_blank">' + ssh.WorkflowStatus + '</a>' AS StatusLink
		, CASE 
			WHEN sw.StyleWorkflowID IS NULL
				THEN 0
			ELSE 1
			END AS HasSKUWorkflow
		, CASE WHEN pli.StyleBOMDimensionID != ssh.StyleBOMDimensionID THEN 1 ELSE 0 END AS HasMismatchingBOM
	INTO #tmpItems
	FROM vwx_PlanningItem_SELECT pli
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pPlanningSKUHeader psh ON pli.PlanningID = psh.PlanningID
		AND ssy.SeasonYearID = psh.SeasonYearID
	LEFT JOIN pWorkflowStatus ws ON psh.WorkStatus = ws.WorkflowStatusID
	LEFT JOIN pStyleBOMDimension sbd ON pli.StyleBOMDimensionID = sbd.StyleBOMDimensionID
	LEFT JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID
	LEFT JOIN vwx_StyleSKU_Header_SEL ssh ON pli.StyleID = ssh.StyleID
		AND ssh.PlanningSKUHeaderID = @PlanningSKUHeaderID
	LEFT JOIN @SelDims sd ON sd.DimTypeID IN (ssh.ItemDim1TypeID, ssh.ItemDim2TypeID, ssh.ItemDim3TypeID)
	LEFT JOIN @tmpPlanningItem tpi ON pli.PlanningItemID = tpi.PlanningItemID
	LEFT JOIN pStyleWorkflow sw ON pli.StyleID = sw.StyleID
		AND sw.WorkflowID = '40000000-0000-0000-0000-000000000090'
		AND sw.StyleSet = 1
	WHERE psh.PlanningSKUHeaderID = @PlanningSKUHeaderID
		AND pli.TeamId = @TeamID
		AND (@SelectedDimensions = '' OR sd.DimTypeID IS NOT NULL)
		AND (@PlanningItems = '' OR tpi.PlanningItemID IS NOT NULL)

	EXEC ('SELECT * FROM #tmpItems ' + @SearchCond)

	DROP TABLE #tmpItems
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08290', GetDate())
GO

