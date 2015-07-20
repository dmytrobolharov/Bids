-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 August 2011                                                                             */
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
/****** Object:  StoredProcedure [dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECT]    Script Date: 08/25/2011 20:06:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECT]		
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECT]  
(@TeamId uniqueidentifier) 
AS

SELECT MaterialRequestWorkflowID, MaterialRequestWorkflow 
FROM pMaterialRequestWorkflow WITH(NOLOCK)
WHERE 
(
	MaterialRequestWorkflowID NOT IN 
	(
		SELECT SampleWorkflowId FROM  pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId 
	)
) 
AND Active = 1
ORDER BY MaterialRequestWorkflowSort

Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01781'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01781', GetDate())
END
GO
	
	