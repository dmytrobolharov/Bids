IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_SampleRequestWorkflowBOM_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_SampleRequestWorkflowBOM_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_TACal_SampleRequestWorkflowBOM_UPDATE]
(@AssignedTo nvarchar(50),
@ResubmitDays int,
@SampleRequestWorkflowID uniqueidentifier, 
@SampleWorkflowPartnerTypeID uniqueidentifier,
@TACalRefTaskId uniqueidentifier, 
@RevisedStart datetime,
@RevisedEnd datetime
)
AS 

DECLARE @SampleWorkflowID NVARCHAR(10)
DECLARE @SampleRequestTradeID UNIQUEIDENTIFIER
DECLARE @TeamID UNIQUEIDENTIFIER
DECLARE @StyleID UNIQUEIDENTIFIER
DECLARE @ItemDim1Id UNIQUEIDENTIFIER 
DECLARE @ItemDim2Id UNIQUEIDENTIFIER 
DECLARE @ItemDim3Id UNIQUEIDENTIFIER 
DECLARE @StyleSet NVARCHAR(10)
DECLARE @Submit INT

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
FROM pSampleRequestWorkflowBOM WITH (NOLOCK) WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) 

UPDATE    pSampleRequestWorkflowBOM
SET       AssignedTo = @AssignedTo, ResubmitDays = @ResubmitDays, SampleWorkflowPartnerTypeID = @SampleWorkflowPartnerTypeID
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID)

UPDATE    pSampleRequestSubmitBOM
SET       AssignedTo = @AssignedTo
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
           (Submit = @Submit) AND (StyleID = @StyleID) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet)

-- update RevisedStart and RevisedEnd in calendar references table 
IF @TACalRefTaskId IS NOT NULL
BEGIN
	UPDATE	pTACalReferenceTask 
	SET		TaskRevisedlStart = @RevisedStart, TaskRevisedEnd = @RevisedEnd
	WHERE	TACalRefTaskId = @TACalRefTaskId
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08528', GetDate())
GO
