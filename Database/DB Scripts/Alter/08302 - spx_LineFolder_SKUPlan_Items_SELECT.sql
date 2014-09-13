IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUPlan_Items_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUPlan_Items_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKUPlan_Items_SELECT]
	@LineFolderSKUHeaderID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX),
	@SelectedDimensions nVARCHAR(MAX),
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN	

	DECLARE @SelDims TABLE(DimTypeID UNIQUEIDENTIFIER)
	INSERT INTO @SelDims(DimTypeID)
	SELECT value FROM dbo.fnx_Split(@SelectedDimensions, ',')
	
	SELECT DISTINCT lfi.*, 
		ssh.StyleSKUItemID, ssh.Dimensions, lfsh.LineFolderSKUHeaderID,
		CASE WHEN lfi.LineFolderItemDrop = 'Yes' THEN '<img src="../System/Icons/icon_drop.gif" />'
		ELSE '' END AS LineFolderItemDropIcon,
		ws.WorkflowStatusRepId,
		'<img src="../System/Icons/' + ssh.WorkflowStatusImage + '"> 
		<a href="../Style/Style_Frame.aspx?P=40000000-0000-0000-0000-000000000090&WFIID=' + CAST(ssh.WorkFlowItemID AS nVARCHAR(50)) + '&SID=' + CAST(lfi.StyleID AS nVARCHAR(50)) + '&SYID=' + CAST(ssy.SeasonYearID AS nVARCHAR(50)) + '" target="_blank">' + ssh.WorkflowStatus + '</a>' AS StatusLink,
		CASE WHEN sw.StyleWorkflowID IS NULL THEN 0 ELSE 1 END AS HasSKUWorkflow
	INTO #tmpItems
	FROM vwx_LineFolderItem_SELECT lfi
	INNER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pLineFolderSKUHeader lfsh ON lfi.LineFolderID = lfsh.LineFolderID		
	LEFT JOIN pWorkflowStatus ws ON lfsh.WorkStatus = ws.WorkflowStatusID
	LEFT JOIN pStyleBOMDimension sbd ON lfi.StyleBOMDimensionID = sbd.StyleBOMDimensionID
	LEFT JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID
	LEFT JOIN vwx_StyleSKU_Header_SEL ssh ON lfi.StyleID = ssh.StyleID 
		AND ssh.LineFolderSKUHeaderID = @LineFolderSKUHeaderID
	LEFT JOIN @SelDims sd ON sd.DimTypeID IN (ssh.ItemDim1TypeID, ssh.ItemDim2TypeID, ssh.ItemDim3TypeID)
	LEFT JOIN pStyleWorkflow sw ON lfi.StyleID = sw.StyleID AND sw.WorkflowID = '40000000-0000-0000-0000-000000000090' AND sw.StyleSet = 1
	WHERE lfsh.LineFolderSKUHeaderID = @LineFolderSKUHeaderID
		AND lfi.TeamId = @TeamID AND (@SelectedDimensions = '' OR sd.DimTypeID IS NOT NULL)
		
	EXEC('SELECT * FROM #tmpItems ' + @SearchCond)
		
	DROP TABLE #tmpItems
	
END





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08302', GetDate())
GO
