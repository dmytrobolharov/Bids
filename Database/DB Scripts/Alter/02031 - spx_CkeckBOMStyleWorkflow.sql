-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                               */
-- * Database:                                                                                  */
-- * 9 June 2011                                                                                */
-- * WorkItem#2850                                                                                          */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_CkeckBOMStyleWorkflow]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CkeckBOMStyleWorkflow]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CkeckBOMStyleWorkflow]
GO

/****** Object:  StoredProcedure [dbo].[spx_CkeckBOMStyleWorkflow]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_CkeckBOMStyleWorkflow]
(
@StyleID uniqueidentifier,
@StyleSet int,
@WorkflowID uniqueidentifier
)
AS 

DECLARE @StyleWorkflowID as uniqueidentifier  

SELECT @StyleWorkflowID = StyleWorkflowId  FROM pStyleHeader WITH (NOLOCK) where StyleID = @StyleID


IF @StyleWorkflowID IS NOT NULL 
BEGIN 
	SELECT COUNT(b.Map)
	FROM dbo.pStyleWorkflow a WITH (NOLOCK) INNER JOIN dbo.Mapping  b WITH (NOLOCK) ON a.WorkflowID = b.Map INNER JOIN
	                      dbo.pWorkflowStatus  c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID INNER JOIN
	                      dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID
		         INNER JOIN dbo.pWorkflowTemplateItem e WITH (NOLOCK) ON  e.WorkflowID  = b.Map 
	WHERE a.StyleID = @StyleID AND  a.StyleSet  =  @StyleSet 
	AND e.WorkflowTemplateID = @StyleWorkflowID and b.Map = @WorkflowID
	
END 
ELSE 
BEGIN 


	SELECT     count(dbo.Mapping.Map)
	FROM         dbo.pStyleWorkflow WITH (NOLOCK) INNER JOIN
	                      dbo.Mapping WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map INNER JOIN
	                      dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID INNER JOIN
	                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleWorkflow.StyleID = dbo.pStyleHeader.StyleID
	WHERE     (dbo.pStyleWorkflow.StyleID = @StyleID) AND (dbo.pStyleWorkflow.StyleSet = @StyleSet) and Mapping.Map = @WorkflowID

END


Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02031'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02031', GetDate())
END
GO