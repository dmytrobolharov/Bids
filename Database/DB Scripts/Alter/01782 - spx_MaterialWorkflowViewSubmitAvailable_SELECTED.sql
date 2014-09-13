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
/****** Object:  StoredProcedure [dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECTED]    Script Date: 08/25/2011 20:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECTED]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECTED]		
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECTED]
(@TeamId uniqueidentifier)
AS

SELECT MaterialRequestWorkflowID, MaterialRequestWorkflow 
FROM pMaterialRequestWorkflow WITH(NOLOCK)
WHERE 
(
	MaterialRequestWorkflowID  IN 
	(
		SELECT SampleWorkflowId FROM  pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId =@TeamId
	)
)
AND Active = 1
ORDER BY MaterialRequestWorkflowSort

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01782'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01782', GetDate())
END
GO




