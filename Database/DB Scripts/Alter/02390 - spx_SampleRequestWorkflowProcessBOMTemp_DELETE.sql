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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowProcessBOMTemp_DELETE]    Script Date: 12/18/2011 18:26:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowProcessBOMTemp_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowProcessBOMTemp_DELETE]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowProcessBOMTemp_DELETE]    Script Date: 12/18/2011 18:26:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestWorkflowProcessBOMTemp_DELETE]
(
@SampleWorkflowID nvarchar(10),
@StyleID nvarchar(50),
@ItemDim1Id  nvarchar(50) = null,
@ItemDim2Id  nvarchar(50) = null,
@ItemDim3Id  nvarchar(50) = null,
@StyleSet nvarchar(10)
)
AS 


DELETE FROM pSampleRequestWorkflowBOMTemp WHERE SampleWorkflowID = @SampleWorkflowID AND 
ItemDim1Id = @ItemDim1Id AND ItemDim2Id = @ItemDim2Id AND ItemDim3Id = @ItemDim3Id AND
StyleID = @StyleID AND StyleSet = @StyleSet 

DELETE FROM pSampleRequestSubmitBOMTemp WHERE SampleWorkflowID = @SampleWorkflowID AND 
ItemDim1Id = @ItemDim1Id AND ItemDim2Id = @ItemDim2Id AND ItemDim3Id = @ItemDim3Id AND
StyleID = @StyleID AND StyleSet = @StyleSet 

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02390'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02390', GetDate())

END

GO 

