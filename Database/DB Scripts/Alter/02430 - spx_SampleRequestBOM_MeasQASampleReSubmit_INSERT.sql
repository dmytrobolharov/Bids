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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOM_MeasQASampleReSubmit_Insert]    Script Date: 12/18/2011 18:51:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOM_MeasQASampleReSubmit_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOM_MeasQASampleReSubmit_Insert]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOM_MeasQASampleReSubmit_Insert]    Script Date: 12/18/2011 18:51:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create  PROCEDURE [dbo].[spx_SampleRequestBOM_MeasQASampleReSubmit_Insert] (
	@SampleRequestSubmitId uniqueidentifier,
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleWorkflowID nvarchar(5),
	@SampleRequestTradeID uniqueidentifier,
	@SampleRequestHeaderId uniqueidentifier,
	@StyleID uniqueidentifier,
	@ItemDim1Id UNIQUEIDENTIFIER = null,
	@ItemDim2Id UNIQUEIDENTIFIER = null,
	@ItemDim3Id UNIQUEIDENTIFIER = null,
	@StyleSet int,
	@CreatedDate nvarchar(50),
	@CreatedBy nvarchar(50),
	@Submit int,
	@NewSubmit nvarchar(50)	
)

AS 
	SET NOCOUNT ON
	
	DECLARE @ResubmitDays int

	insert into pqasampMeas (SampleRequestHeaderId , AMLMeasHdrId, AmlMeaspomid, AMLMeasLblId, AmlMeasIGCid, SamplepomId, SampleLabelId, POMRow , 
	sizecol, sampleno, submit ,MeasValue, SampMeasValue )
	select  @SampleRequestHeaderId, AMLMeasHdrId, AmlMeaspomid, AMLMeasLblId, AmlMeasIGCid, SamplepomId, SampleLabelId, POMRow, 
	sizecol, sampleno, @NewSubmit , MeasValue, 0
	from pqasampMeas 
	where  SampleRequestHeaderId=@SampleRequestHeaderId and submit=@Submit 
	 
	update pqaHeader set submit=@NewSubmit where SampleRequestHeaderId=@SampleRequestHeaderId
	 
	SELECT @ResubmitDays = ResubmitDays FROM pSampleRequestWorkflow WITH (NOLOCK) WHERE SampleRequestWorkflowID = @SampleRequestWorkflowID
		
	INSERT INTO pSampleRequestSubmitBOM
	(SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, Submit, Status, StartDate, DueDate, 
	CUser, CDate, MUser, MDate)
	SELECT @SampleRequestSubmitId, SampleRequestWorkflowID, SampleWorkflowID, SampleRequestTradeID, StyleID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleSet, WorkflowID, TradePartnerVendorID, TradePartnerId, @NewSubmit, 0, StartDate, CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112), 
	@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pSampleRequestSubmitBOM WITH (NOLOCK)
	WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleWorkflowID = @SampleWorkflowID) AND (StyleID = @StyleID) AND 
	(ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet) AND (SampleRequestTradeID = @SampleRequestTradeID) AND (Submit = @Submit) 
    
    
	UPDATE pSampleRequestWorkflowBOM
	SET Status = '0', Submit = @NewSubmit, DueDate = CONVERT(CHAR(8), GETDATE() + ISNULL(@ResubmitDays,1), 112),   MUser = @CreatedBy, MDate = @CreatedDate
	WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
	
	SET NOCOUNT OFF

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02430'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02430', GetDate())

END

GO 