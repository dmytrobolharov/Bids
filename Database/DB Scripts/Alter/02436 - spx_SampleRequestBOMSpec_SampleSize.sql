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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpec_SampleSize]    Script Date: 12/18/2011 18:54:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpec_SampleSize]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpec_SampleSize]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpec_SampleSize]    Script Date: 12/18/2011 18:54:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMSpec_SampleSize]
(@StyleID uniqueidentifier,
@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@SampleRequestTradeID uniqueidentifier,
@ItemDim1Id UNIQUEIDENTIFIER = null,
@ItemDim2Id UNIQUEIDENTIFIER = null,
@ItemDim3Id UNIQUEIDENTIFIER = null)
AS 

SELECT     StyleID, SizeRange, 
                      CASE WHEN Sel0 = 1 THEN Size0 WHEN Sel1 = 1 THEN Size1 WHEN Sel2 = 1 THEN Size2 WHEN Sel3 = 1 THEN Size3 WHEN Sel4 = 1 THEN Size4 WHEN
                       Sel5 = 1 THEN Size5 WHEN Sel6 = 1 THEN Size6 WHEN Sel7 = 1 THEN Size7 WHEN Sel8 = 1 THEN Size8 WHEN Sel9 = 1 THEN Size9 WHEN Sel10 =
                       1 THEN Size10 WHEN Sel11 = 1 THEN Size11 END AS SampleSize FROM  pSampleRequestSpecSizeBOM WITH (NOLOCK)
WHERE     (StyleID = @StyleID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND 
                      (SampleRequestTradeID = @SampleRequestTradeID) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id)

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02436'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02436', GetDate())

END

GO
