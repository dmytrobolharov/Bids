-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMTemp_SELECT]    Script Date: 12/18/2011 18:02:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowBOMTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMTemp_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMTemp_SELECT]    Script Date: 12/18/2011 18:02:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMTemp_SELECT](@StyleID uniqueidentifier,
@StyleSet nvarchar(10),
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@SampleRequestGroupID uniqueidentifier)
AS 

SELECT     a.SampleRequestWorkflowID, a.SampleWorkflowID, a.SampleRequestGroupID, a.StyleID, 
           a.ItemDim1Id,a.ItemDim2Id,a.ItemDim3Id, a.StyleSet, a.Status, a.Submit, a.TechPackID, a.StartDate, 
           a.DueDate, a.EndDate, 
		   b.SampleWorkflow, b.SampleWorkflowSort, b.GroupName, 
		   a.AssignedTo,  a.SubmitDays, a.ResubmitDays , a.SampleWorkflowFinalDate
FROM         dbo.pSampleRequestWorkflowBOMTemp a WITH (NOLOCK) INNER JOIN
                      dbo.pSampleWorkflow b WITH (NOLOCK) ON a.SampleWorkflowID = b.SampleWorkflowID
WHERE   a.StyleID = @StyleID  
AND a.StyleSet = @StyleSet
AND a.ItemDim1Id = @ItemDim1Id
AND a.ItemDim2Id = @ItemDim2Id
AND a.ItemDim3Id = @ItemDim3Id
AND a.SampleRequestGroupID = @SampleRequestGroupID
ORDER BY b.SampleWorkflowSort




set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02369'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02369', GetDate())

END

GO
