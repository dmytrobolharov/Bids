-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 30 January 2012                                                                            */
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

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'vwx_StyleVariation_PageList'))
DROP VIEW vwx_StyleVariation_PageList
GO


CREATE VIEW vwx_StyleVariation_PageList
AS
	SELECT w.Workflow, sw.StyleWorkflowID, sw.WorkflowID, wfi.WorkFlowItemName, wfi.WorkFlowItemID, wfi.WorkflowItemTypeId, 
		sw.StyleWorkflowMasterID, sw.StyleID, sw.StyleSet, sw.WorkflowType, sw.WorkflowOrder, sw.WorkDay, sw.WorkDate, 
		sw.WorkStart, sw.WorkDue, sw.WorkAssignedTo, sw.WorkComplete, sw.WorkStatus, sw.WorkStatusDate, sw.WorkStatusBy, 
		sw.WorkVersion, sw.WorkComments, sw.WorkSort, sw.CUser, sw.CDate, sw.MUser, sw.MDate
	FROM pStyleWorkflow sw
	INNER JOIN pWorkflow w ON sw.WorkflowID = w.WorkflowID
	LEFT OUTER JOIN pWorkFlowItem wfi ON sw.WorkflowID = wfi.WorkflowID AND sw.StyleID = wfi.StyleID AND sw.StyleSet = wfi.StyleSet
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '03072', GetDate())
GO

SET NOCOUNT Off
GO
