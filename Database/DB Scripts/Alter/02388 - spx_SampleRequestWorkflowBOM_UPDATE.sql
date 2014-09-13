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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOM_UPDATE]    Script Date: 12/18/2011 18:25:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowBOM_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowBOM_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOM_UPDATE]    Script Date: 12/18/2011 18:25:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestWorkflowBOM_UPDATE]
(@AssignedTo nvarchar(50),
@DueDate nvarchar(50),
@ResubmitDays int,
@SampleRequestID uniqueidentifier, 
@SampleWorkflowFinalDate DATETIME 
)
AS 

declare @SampleRequestWorkflowID uniqueidentifier
declare @SampleWorkflowID as nvarchar(10)
declare @SampleRequestTradeID uniqueidentifier
declare @TeamID uniqueidentifier
declare @StyleID uniqueidentifier
DECLARE @ItemDim1Id UNIQUEIDENTIFIER 
DECLARE @ItemDim2Id UNIQUEIDENTIFIER 
DECLARE @ItemDim3Id UNIQUEIDENTIFIER 
declare @StyleSet nvarchar(10)
declare @Submit int

SELECT 
@SampleRequestWorkflowID = SampleRequestWorkflowID, 
@SampleWorkflowID = SampleWorkflowID, 
@SampleRequestTradeID = SampleRequestTradeID, 
@TeamID = TradePartnerVendorID,
@StyleID = StyleID, 
@ItemDim1Id = ItemDim1Id,
@ItemDim2Id = ItemDim2Id,
@ItemDim3Id = ItemDim3Id,
@StyleSet = StyleSet, 
@Submit = Submit 
FROM pSampleRequestWorkflowBOM WITH (NOLOCK) WHERE (SampleRequestWorkflowID = @SampleRequestID) --@SampleRequestWorkflowID)

UPDATE    pSampleRequestWorkflowBOM
SET       AssignedTo = @AssignedTo, DueDate = @DueDate, ResubmitDays = @ResubmitDays, SampleWorkflowFinalDate = @SampleWorkflowFinalDate
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID)

UPDATE    pSampleRequestSubmitBOM
SET       AssignedTo = @AssignedTo, DueDate = @DueDate 
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
           (Submit = @Submit) AND (StyleID = @StyleID) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet)







set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02388'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02388', GetDate())

END

GO

