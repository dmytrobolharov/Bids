IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_BOMManager_Items_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_BOMManager_Items_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_BOMManager_Items_SELECT]
(
	@SearchCond NVARCHAR(MAX)
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
		, '<a href="Planning_StyleProperty.aspx?SID=' + CAST(pli.StyleID AS NVARCHAR(50)) + '&SYID=' + CAST(pli.SeasonYearID AS NVARCHAR(50)) + '&PIID=' + CAST(pli.PlanningItemID AS NVARCHAR(50)) + '&RT=BOMMP">' + pli.StyleNo + '</a>' AS StylePropertyLink
		, pli.SubCategoryName
		, pli.DevelopmentID
		, SUBSTRING(CASE WHEN sbd.ItemDim1TypeId != '00000000-0000-0000-0000-000000000000' THEN ', ' + sbd.ItemDim1TypeName ELSE '' END + 
					CASE WHEN sbd.ItemDim2TypeId != '00000000-0000-0000-0000-000000000000' THEN ', ' + sbd.ItemDim2TypeName ELSE '' END +
					CASE WHEN sbd.ItemDim3TypeId != '00000000-0000-0000-0000-000000000000' THEN ', ' + sbd.ItemDim3TypeName ELSE '' END, 2, 2000)
		  AS Dimensions
		, CASE 
			WHEN pli.PlanningItemDrop = 'Yes'
				THEN '<img src="../System/Icons/icon_drop.gif" />'
			ELSE ''
			END AS PlanningItemDropIcon
		, CASE WHEN wfi.WorkFlowItemID IS NULL THEN 1 ELSE 0 END AS MissingBOM
		, wfi.WorkFlowItemName
		, ws.WorkflowStatusRepId		
		, ws.WorkflowStatusID
		, CASE WHEN sw.StyleWorkflowID IS NULL THEN 1 ELSE 0 END AS MissingBOMWorkflow
		, '<img src="../System/Icons/' + ws.WorkflowStatusImage + '"><a href="../Style/Style_Frame.aspx?P=' + CAST(wfi.WorkFlowID AS nVARCHAR(50)) + '&WFIID=' + CAST(wfi.WorkFlowItemID AS nVARCHAR(50)) + '&SID=' + CAST(pli.StyleID AS nVARCHAR(50)) + '&SYID=' + CAST(ssy.SeasonYearID AS nVARCHAR(50)) + '" target="_blank">' + ws.WorkflowStatus + '</a>' AS StatusLink
	INTO #tmpItems
	FROM vwx_PlanningItem_SELECT pli
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	LEFT JOIN pStyleBOMDimension sbd
		INNER JOIN pWorkFlowItem wfi ON sbd.WorkflowItemId = wfi.WorkFlowItemID
		INNER JOIN pWorkflowStatus ws ON wfi.WorkStatus = ws.WorkflowStatusID
	ON pli.StyleBOMDimensionID = sbd.StyleBOMDimensionID
	LEFT JOIN pStyleWorkflow sw ON pli.StyleSeasonYearID = sw.StyleSeasonYearID AND sw.WorkflowID = '40000000-0000-0000-0000-000000000080'
	LEFT JOIN @tmpPlanningItem tpi ON pli.PlanningItemID = tpi.PlanningItemID
	LEFT JOIN @SelDims sd ON sd.DimTypeID IN (sbd.ItemDim1TypeID, sbd.ItemDim2TypeID, sbd.ItemDim3TypeID)
	WHERE (pli.TeamId = @TeamID)
		AND (@SelectedDimensions = '' OR sd.DimTypeID IS NOT NULL)
		AND (@PlanningItems = '' OR tpi.PlanningItemID IS NOT NULL)

	EXEC ('SELECT * FROM #tmpItems ' + @SearchCond)

	DROP TABLE #tmpItems
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08360', GetDate())
GO
