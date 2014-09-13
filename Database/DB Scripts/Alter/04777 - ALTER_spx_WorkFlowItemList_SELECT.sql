-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 January 2013                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkFlowItemList_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_WorkFlowItemList_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_WorkFlowItemList_SELECT] 
(
	@WorkflowID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@WorkflowItemID uniqueidentifier = NULL
)
AS
BEGIN

	IF @WorkflowItemID IS NULL
	BEGIN

		IF @WorkflowID='40000000-0000-0000-0000-000000000050' or @WorkflowID='40000000-0000-0000-0000-000000000078' or @WorkflowID='40000000-0000-0000-0000-000000000018' 
		or @WorkflowID='40000000-0000-0000-0000-000000000080' or @WorkflowID='40000000-0000-0000-0000-000000000777' or @WorkflowID='40000000-0000-0000-0000-000000000999' or @WorkflowID='80000000-0000-0000-0000-000000000008'
		BEGIN
			SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfs.WorkflowStatus as Custom, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, 
				wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate,wfi.WorkStatus
			FROM dbo.pWorkFlowItem AS wfi 
				INNER JOIN pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
				LEFT OUTER JOIN pWorkflowStatus AS wfs ON wfi.WorkStatus = wfs.WorkflowStatusID
			WHERE wfi.StyleID = @StyleID 
				AND wfi.StyleSet = @StyleSet 
				AND wfi.WorkflowID = @WorkflowID
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
			ORDER BY wfi.Sort
		END

	END
	ELSE
	BEGIN

		IF @WorkflowID='40000000-0000-0000-0000-000000000050' or @WorkflowID='40000000-0000-0000-0000-000000000078' or @WorkflowID='40000000-0000-0000-0000-000000000018' 
		or @WorkflowID='40000000-0000-0000-0000-000000000080' or @WorkflowID='40000000-0000-0000-0000-000000000777' or @WorkflowID='40000000-0000-0000-0000-000000000999' or @WorkflowID='80000000-0000-0000-0000-000000000008'
		BEGIN
			SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfs.WorkflowStatus as Custom, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, 
				wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate,wfi.WorkStatus
			FROM dbo.pWorkFlowItem AS wfi 
				INNER JOIN pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
				LEFT OUTER JOIN pWorkflowStatus AS wfs ON wfi.WorkStatus = wfs.WorkflowStatusID
			WHERE wfi.StyleID = @StyleID 
				AND wfi.StyleSet = @StyleSet 
				AND wfi.WorkflowID = @WorkflowID
				AND wfi.WorkFlowItemID = @WorkflowItemID
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
			ORDER BY wfi.Sort
		END

	END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04777', GetDate())
GO
