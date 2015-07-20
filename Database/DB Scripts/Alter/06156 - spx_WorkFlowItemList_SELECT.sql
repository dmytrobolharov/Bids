IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkFlowItemList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkFlowItemList_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_WorkFlowItemList_SELECT] 
(
	@WorkflowID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@SeasonYearID uniqueidentifier = NULL,
	@WorkflowItemID uniqueidentifier = NULL,
	@ShowLinked int = 0
)
AS
BEGIN

	DECLARE @IsSeasonal INT = (SELECT IsSeasonal FROM Mapping WHERE Map = @WorkflowID),
			@StyleSeasonYearID uniqueidentifier = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID)

	IF @WorkflowItemID IS NULL
	BEGIN
		IF @WorkflowID='40000000-0000-0000-0000-000000000050' or @WorkflowID='40000000-0000-0000-0000-000000000078' or @WorkflowID='40000000-0000-0000-0000-000000000018' 
		or @WorkflowID='40000000-0000-0000-0000-000000000080' or @WorkflowID='40000000-0000-0000-0000-000000000777' or @WorkflowID='40000000-0000-0000-0000-000000000999' or @WorkflowID='80000000-0000-0000-0000-000000000008'
		BEGIN
			SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfs.WorkflowStatus as Custom, wfit.ItemTypeLabel, wfi.StyleID, wfi.StyleSet, wfi.WorkFlowItemName, wfi.Sort, 
				wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate,wfi.WorkStatus, 0 AS IsLinked, '' AS SourceStyle, ISNULL(sh.StyleNo, '') + ISNULL (' (' + sh.Description, ')') AS CopySourceStyle, sh.DevelopmentID,
				(SELECT CASE WHEN COUNT(*)>0 THEN 1 ELSE 0 END FROM pWorkFlowItemLinked WHERE WorkFlowItemID = wfi.WorkFlowItemID) AS HasLinks
			FROM dbo.pWorkFlowItem AS wfi 
				INNER JOIN pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
				LEFT OUTER JOIN pWorkflowStatus AS wfs ON wfi.WorkStatus = wfs.WorkflowStatusID
				INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
			WHERE wfi.StyleID = @StyleID 
				AND wfi.StyleSet = @StyleSet 
				AND wfi.WorkflowID = @WorkflowID
				AND (@IsSeasonal = 1 AND wfi.StyleSeasonYearID = @StyleSeasonYearID OR @IsSeasonal = 0)
			UNION
			SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfs.WorkflowStatus as Custom, wfit.ItemTypeLabel, wfi.StyleID, wfi.StyleSet, wfi.WorkFlowItemName, wfi.Sort, 
				wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate,wfi.WorkStatus, 1 AS IsLinked, ISNULL(sh.StyleNo, '') + ISNULL (' - ' + sh.Description, '') AS SourceStyle, '' AS CopySourceStyle, sh.DevelopmentID, 0 AS HasLinks
			FROM dbo.pWorkFlowItem AS wfi 
				INNER JOIN pWorkFlowItemLinked wfil ON wfi.WorkFlowItemID = wfil.WorkFlowItemID
				INNER JOIN pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
				INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
				LEFT OUTER JOIN pWorkflowStatus AS wfs ON wfi.WorkStatus = wfs.WorkflowStatusID
			WHERE wfil.StyleID = @StyleID 
				AND wfil.StyleSet = @StyleSet 
				AND wfi.WorkflowID = @WorkflowID
				AND @ShowLinked = 1
			ORDER BY wfi.Sort
		END
		ELSE
		BEGIN
			SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfi.StatusID, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, 
				wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate, wfisl.Custom
			FROM dbo.pWorkFlowItem AS wfi 
				INNER JOIN pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
				LEFT OUTER JOIN xCustom8 AS wfisl ON wfi.StatusID = wfisl.CustomID
			WHERE wfi.StyleID = @StyleID 
				AND wfi.StyleSet = @StyleSet 
				AND wfi.WorkflowID = @WorkflowID
				AND (@IsSeasonal = 1 AND wfi.StyleSeasonYearID = @StyleSeasonYearID OR @IsSeasonal = 0)
			ORDER BY wfi.Sort
		END

	END
	ELSE
	BEGIN

		IF @WorkflowID='40000000-0000-0000-0000-000000000050' or @WorkflowID='40000000-0000-0000-0000-000000000078' or @WorkflowID='40000000-0000-0000-0000-000000000018' 
		or @WorkflowID='40000000-0000-0000-0000-000000000080' or @WorkflowID='40000000-0000-0000-0000-000000000777' or @WorkflowID='40000000-0000-0000-0000-000000000999' or @WorkflowID='80000000-0000-0000-0000-000000000008'
		BEGIN
				SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfs.WorkflowStatus as Custom, wfit.ItemTypeLabel, wfi.StyleID, wfi.StyleSet, wfi.WorkFlowItemName, wfi.Sort, 
					wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate,wfi.WorkStatus, 0 AS IsLinked, '' AS SourceStyle, ISNULL(sh.StyleNo, '') + ISNULL (' (' + sh.Description, ')') AS CopySourceStyle, sh.DevelopmentID, 
					(SELECT CASE WHEN COUNT(*)>0 THEN 1 ELSE 0 END FROM pWorkFlowItemLinked WHERE WorkFlowItemID = wfi.WorkFlowItemID) AS HasLinks
				FROM dbo.pWorkFlowItem AS wfi 
					INNER JOIN pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
					LEFT OUTER JOIN pWorkflowStatus AS wfs ON wfi.WorkStatus = wfs.WorkflowStatusID
					INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
				WHERE wfi.StyleID = @StyleID 
					AND wfi.StyleSet = @StyleSet 
					AND wfi.WorkflowID = @WorkflowID
					AND wfi.WorkFlowItemID = @WorkflowItemID
					AND (@IsSeasonal = 1 AND wfi.StyleSeasonYearID = @StyleSeasonYearID OR @IsSeasonal = 0)
				UNION
				SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfs.WorkflowStatus as Custom, wfit.ItemTypeLabel, wfi.StyleID, wfi.StyleSet, wfi.WorkFlowItemName, wfi.Sort, 
					wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate,wfi.WorkStatus, 1 AS IsLinked, ISNULL(sh.StyleNo, '') + ISNULL (' - ' + sh.Description, '') AS SourceStyle, '' AS CopySourceStyle, sh.DevelopmentID, 0 AS HasLinks
				FROM dbo.pWorkFlowItem AS wfi 
					INNER JOIN pWorkFlowItemLinked wfil ON wfi.WorkFlowItemID = wfil.WorkFlowItemID
					INNER JOIN pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
					INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
					LEFT OUTER JOIN pWorkflowStatus AS wfs ON wfi.WorkStatus = wfs.WorkflowStatusID
				WHERE wfil.StyleID = @StyleID 
					AND wfil.StyleSet = @StyleSet 
					AND wfi.WorkflowID = @WorkflowID
					AND wfi.WorkFlowItemID = @WorkflowItemID
					AND @ShowLinked = 1
				ORDER BY wfi.Sort
		END
		ELSE
		BEGIN
			SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfi.StatusID, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, 
				wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate, wfisl.Custom
			FROM dbo.pWorkFlowItem AS wfi 
				INNER JOIN pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
				LEFT OUTER JOIN xCustom8 AS wfisl ON wfi.StatusID = wfisl.CustomID
			WHERE wfi.StyleID = @StyleID 
				AND wfi.StyleSet = @StyleSet 
				AND wfi.WorkflowID = @WorkflowID
				AND wfi.WorkFlowItemID = @WorkflowItemID
				AND (@IsSeasonal = 1 AND wfi.StyleSeasonYearID = @StyleSeasonYearID OR @IsSeasonal = 0)
			ORDER BY wfi.Sort
		END

	END

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06156', GetDate())
GO
