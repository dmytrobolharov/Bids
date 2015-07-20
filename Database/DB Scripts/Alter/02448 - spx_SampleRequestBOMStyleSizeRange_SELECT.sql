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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMStyleSizeRange_SELECT]    Script Date: 12/18/2011 19:01:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMStyleSizeRange_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMStyleSizeRange_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMStyleSizeRange_SELECT]    Script Date: 12/18/2011 19:01:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMStyleSizeRange_SELECT]
(
@SampleRequestWorkflowID nvarchar(50),
@SampleRequestTradeID nvarchar(50),
@SampleWorkflowID nvarchar(50),
@StyleID nvarchar(50),
@StyleSet nvarchar(5),
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null
)
AS 

BEGIN
	SELECT '00' AS 'ID', Size0 AS 'Size', Sel0 AS Sample, Col0 AS Col FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col0 = 1 AND  SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION
	SELECT '01' AS 'ID', Size1 AS 'Size', Sel1 AS Sample, Col1 AS Col   FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col1 = 1 AND  SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION
	SELECT '02' AS 'ID', Size2 AS 'Size', Sel2 AS Sample, Col2 AS Col   FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col2 = 1 AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION
	SELECT '03' AS 'ID', Size3 AS 'Size', Sel3 AS Sample, Col3 AS Col   FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col3 = 1 AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION
	SELECT '04' AS 'ID', Size4 AS 'Size', Sel4 AS Sample, Col4 AS Col   FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col4 = 1 AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION 
	SELECT '05' AS 'ID', Size5 AS 'Size', Sel5 AS Sample, Col5 AS Col  FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col5 = 1 AND SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION
	SELECT '06' AS 'ID', Size6 AS 'Size', Sel6 AS Sample, Col6 AS Col   FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col6 = 1 AND  SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION
	SELECT '07' AS 'ID', Size7 AS 'Size', Sel7 AS Sample, Col7 AS Col   FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col7 = 1 AND  SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION
	SELECT '08' AS 'ID', Size8 AS 'Size', Sel8 AS Sample, Col8 AS Col   FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col8 = 1 AND  SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION
	SELECT '09' AS 'ID', Size9 AS 'Size', Sel9 AS Sample, Col9 AS Col   FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col9 = 1 AND  SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION
	SELECT '10' AS 'ID', Size10 AS 'Size', Sel10 AS Sample, Col10 AS Col   FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col10 = 1 AND  SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
		UNION
	SELECT '11' AS 'ID', Size11 AS 'Size', Sel11 AS Sample, Col11 AS Col   FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK) 
	WHERE Col11 = 1 AND  SampleRequestWorkflowID = @SampleRequestWorkflowID 
	AND SampleWorkflowID = @SampleWorkflowID 
	AND SampleRequestTradeID = @SampleRequestTradeID 
	AND @ItemDim1Id = ItemDim1Id AND @ItemDim2Id = ItemDim2Id AND @ItemDim3Id = ItemDim3Id
	AND StyleID = @StyleID 
	AND StyleSet = @StyleSet
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02448'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02448', GetDate())

END

GO