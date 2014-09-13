-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 8 July 2011                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SampleWorkflowViewSubmitAvailable_SELECTED')
   DROP PROCEDURE spx_SampleWorkflowViewSubmitAvailable_SELECTED
GO

CREATE PROCEDURE spx_SampleWorkflowViewSubmitAvailable_SELECTED
(@TeamId uniqueidentifier)
AS 

SELECT SampleWorkflowID, SampleWorkflow, WorkflowID, GroupID, GroupName, Active 
FROM pSampleWorkflow WITH (NOLOCK) 
WHERE SampleWorkflowID IN (SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) WHERE TeamId = @TeamId AND (AccessRoleId=3 OR AccessView=1 )) 
	-- AND (SampleWorkflowID IN (SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId ))
	AND pSampleWorkflow.Active = 'Yes' 
ORDER BY SampleWorkflowID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01524', GetDate())
GO
