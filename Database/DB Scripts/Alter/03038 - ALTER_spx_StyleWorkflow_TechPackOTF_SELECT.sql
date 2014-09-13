-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 26 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleWorkflow_TechPackOTF_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_StyleWorkflow_TechPackOTF_SELECT
GO


CREATE PROCEDURE spx_StyleWorkflow_TechPackOTF_SELECT
(
	@StyleID uniqueidentifier,
	@StyleSet int,
	@ReportMapID uniqueidentifier
)
AS

BEGIN

	DECLARE @StyleWorkflowID as uniqueidentifier  
	SELECT @StyleWorkflowID = StyleWorkflowId FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID


	-- Find out if this Bubble has Sub-Bubbles.
	DECLARE @ResultCount int
	SET @ResultCount = 0

	IF @StyleWorkflowID IS NOT NULL 
	BEGIN 

		SELECT @ResultCount = COUNT(*)
		FROM pStyleWorkflow a WITH (NOLOCK) 
			INNER JOIN Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map 
			INNER JOIN pWorkflowTemplateItem e WITH (NOLOCK) ON e.WorkflowID = b.Map 
			INNER JOIN pWorkflowItemType wfit WITH (NOLOCK) ON b.Map = wfit.MapId
		WHERE a.StyleID = @StyleID
			--AND a.StyleSet = @StyleSet
			AND e.WorkflowTemplateID = @StyleWorkflowID
			AND a.WorkflowID = @ReportMapID

	END 
	ELSE 
	BEGIN 

		SELECT @ResultCount = COUNT(*)
		FROM pStyleWorkflow a WITH (NOLOCK) 
			INNER JOIN Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map 
			INNER JOIN pWorkflowItemType wfit WITH (NOLOCK) ON b.Map = wfit.MapId
		WHERE a.StyleID = @StyleID
			--AND a.StyleSet = @StyleSet
			AND a.WorkflowID = @ReportMapID

	END


	-- Get the list of reports.
	IF @ResultCount > 0
	BEGIN

		SELECT @ResultCount = COUNT(*)
        FROM pWorkFlowItem 
        WHERE WorkflowID = @ReportMapID
			AND StyleID = @StyleID 
			--AND StyleSet = @StyleSet

		IF @ResultCount > 0
		BEGIN

			SELECT a.StyleSet, wfi.WorkFlowItemID, wfi.WorkflowItemTypeId, wfi.WorkFlowItemName, rspi.ReportPageID, rspi.ReportMapID, rspi.ReportPageTypeID, 
				rspi.ReportPageName AS OriginalReportPageName, rspi.ReportPageDescription, rspi.ReportServerType, rspi.ReportPageURL, rspi.ReportPKIField, rspi.ReportPageActive, 
				rspi.ReportPageFormat, '[' + wfi.WorkFlowItemName + '] ' + rspi.ReportPageName AS ReportPageName
			FROM pStyleWorkflow a WITH (NOLOCK) 
				INNER JOIN Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map 
				INNER JOIN pWorkflowTemplateItem e WITH (NOLOCK) ON e.WorkflowID = b.Map 
				INNER JOIN pWorkFlowItem wfi WITH (NOLOCK) ON a.WorkflowID = wfi.WorkflowID AND a.StyleID = wfi.StyleID AND a.StyleSet = wfi.StyleSet
				INNER JOIN rReportStylePageItem rspi WITH (NOLOCK) ON a.WorkflowID = rspi.ReportMapID
			WHERE a.StyleID = @StyleID 
				--AND a.StyleSet = @StyleSet
				AND e.WorkflowTemplateID = @StyleWorkflowID
				AND a.WorkflowID = @ReportMapID
			ORDER BY wfi.Sort

		END
		ELSE
		BEGIN

			SELECT a.StyleSet, wfi.WorkFlowItemID, wfi.WorkflowItemTypeId, wfi.WorkFlowItemName, rspi.ReportPageID, rspi.ReportMapID, rspi.ReportPageTypeID, 
				rspi.ReportPageName AS OriginalReportPageName, rspi.ReportPageDescription, rspi.ReportServerType, rspi.ReportPageURL, rspi.ReportPKIField, rspi.ReportPageActive, 
				rspi.ReportPageFormat, '[' + wfi.WorkFlowItemName + '] ' + rspi.ReportPageName AS ReportPageName
			FROM pStyleWorkflow a WITH (NOLOCK) 
				INNER JOIN Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map 
				INNER JOIN pWorkflowTemplateItem e WITH (NOLOCK) ON e.WorkflowID = b.Map 
				INNER JOIN pWorkFlowItem wfi WITH (NOLOCK) ON a.WorkflowID = wfi.WorkflowID AND a.StyleID = wfi.StyleID AND a.StyleSet = wfi.StyleSet
				INNER JOIN rReportStylePageItem rspi WITH (NOLOCK) ON a.WorkflowID = rspi.ReportMapID
			WHERE a.StyleID = @StyleID 
				--AND a.StyleSet = @StyleSet
				AND e.WorkflowTemplateID = @StyleWorkflowID
				AND a.WorkflowID = @ReportMapID
				AND 1 = 0
			ORDER BY wfi.Sort

		END

	END
	ELSE
	BEGIN

		SELECT 1 AS StyleSet, ReportPageID, ReportMapID, ReportPageTypeID, ReportPageName, ReportPageDescription, ReportServerType, ReportPageURL, 
			ReportPKIField, ReportPageActive, ReportPageFormat
		FROM rReportStylePageItem
		WHERE ReportMapID = @ReportMapID 
			AND ReportPageActive = 1

	END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03038', GetDate())
GO

SET NOCOUNT Off
GO
