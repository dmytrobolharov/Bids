-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 24 August 2011                                                                             */
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
GO
/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECT]    Script Date: 08/25/2011 20:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECT]		
GO

CREATE PROCEDURE [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECT]  
(@TeamId uniqueidentifier)  
AS   
  
	SELECT SampleWorkflowID, SampleWorkflow, WorkflowID, GroupID, GroupName, Active  
	FROM  pSampleWorkflow WITH (NOLOCK)   
	WHERE 
	(
	SampleWorkflowID NOT IN   
	(
		SELECT SampleWorkflowId FROM  pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId  
	)
	)  
	--AND SampleWorkflowID IN  (SELECT SampleTypeId from sAccessSampleFolder WITH (NOLOCK) WHERE TeamId = @TeamId  AND (AccessRoleId=3 OR AccessView=1 )  )  
	AND  pSampleWorkflow.Active='Yes'
	ORDER BY SampleWorkflowID  

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01784'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01784', GetDate())
END
GO