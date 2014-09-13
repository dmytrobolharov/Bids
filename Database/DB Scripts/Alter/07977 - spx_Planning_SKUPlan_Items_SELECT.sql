IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUPlan_Items_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUPlan_Items_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUPlan_Items_SELECT]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX),
	@SelectedDimensions nVARCHAR(MAX),
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN	

	DECLARE @SelDims TABLE(DimTypeID UNIQUEIDENTIFIER)
	INSERT INTO @SelDims(DimTypeID)
	SELECT value FROM dbo.fnx_Split(@SelectedDimensions, ',')
	
	SELECT DISTINCT pli.*, wfi.WorkFlowItemName AS BOMName, ssh.StyleSKUItemID, ssh.Dimensions, psh.PlanningSKUHeaderID,
		CASE WHEN pli.PlanningItemDrop = 'Yes' THEN '<img src="../System/Icons/icon_drop.gif" />'
		ELSE '' END AS PlanningItemDropIcon,
		ws.WorkflowStatusRepId,
		'<img src="../System/Icons/' + ssh.WorkflowStatusImage + '"> 
		<a href="../Style/Style_Frame.aspx?P=40000000-0000-0000-0000-000000000090&WFIID=' + CAST(ssh.WorkFlowItemID AS nVARCHAR(50)) + '&SID=' + CAST(pli.StyleID AS nVARCHAR(50)) + '&SYID=' + CAST(ssy.SeasonYearID AS nVARCHAR(50)) + '" target="_blank">' + ssh.WorkflowStatus + '</a>' AS StatusLink
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
	WHERE psh.PlanningSKUHeaderID = @PlanningSKUHeaderID
		AND pli.TeamId = @TeamID AND (@SelectedDimensions = '' OR sd.DimTypeID IS NOT NULL)
		
	EXEC('SELECT * FROM #tmpItems ' + @SearchCond)
		
	DROP TABLE #tmpItems
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07977', GetDate())
GO
