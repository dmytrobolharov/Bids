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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_BOMSpecPage_SELECT]    Script Date: 12/18/2011 18:44:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_BOMSpecPage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_BOMSpecPage_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_BOMSpecPage_SELECT]    Script Date: 12/18/2011 18:44:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[spx_SampleRequest_BOMSpecPage_SELECT]
(
@SampleRequestWorkflowID nvarchar(50),
@SampleRequestTradeID nvarchar(50),
@StyleID nvarchar(50),
@StyleSet nvarchar(5),
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null

)
AS SELECT     '{00000000-0000-0000-0000-000000000000}' AS ID, '0' AS Status, '0' As Submit, 'Development Spec' AS SpecPage, '{00000000-0000-0000-0000-000000000000}' AS SampleWorkflowID
UNION
SELECT     pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.Status, pSampleRequestWorkflow.Submit, 
                      pSampleWorkflow.GroupName, pSampleRequestWorkflow.SampleWorkflowID
FROM         pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
                      pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
WHERE     (pSampleWorkflow.GroupID = N'S' 
AND pSampleRequestWorkflow.SampleRequestWorkflowID <> @SampleRequestWorkflowID 
AND pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID
AND pSampleRequestWorkflow.StyleID = @StyleID
AND pSampleRequestWorkflow.StyleSet = @StyleSet
AND pSampleRequestWorkflow.ItemDim1Id = @ItemDim1Id
AND pSampleRequestWorkflow.ItemDim2Id = @ItemDim2Id
AND pSampleRequestWorkflow.ItemDim3Id = @ItemDim3Id)   
ORDER BY SampleWorkflowID


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02423'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02423', GetDate())

END

GO
