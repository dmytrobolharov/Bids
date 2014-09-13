IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowBOM_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowBOM_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowBOM_UPDATE]
(@AssignedTo nvarchar(50),
@DueDate nvarchar(50),
@ResubmitDays int,
@SampleRequestID uniqueidentifier, 
@SampleWorkflowFinalDate DATETIME, 
@SampleWorkflowPartnerTypeID uniqueidentifier
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
SET       AssignedTo = @AssignedTo, DueDate = @DueDate, ResubmitDays = @ResubmitDays, SampleWorkflowFinalDate = @SampleWorkflowFinalDate, SampleWorkflowPartnerTypeID = @SampleWorkflowPartnerTypeID
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID)

UPDATE    pSampleRequestSubmitBOM
SET       AssignedTo = @AssignedTo, DueDate = @DueDate 
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
           (Submit = @Submit) AND (StyleID = @StyleID) AND (ItemDim1Id = @ItemDim1Id) AND (ItemDim2Id = @ItemDim2Id) AND (ItemDim3Id = @ItemDim3Id) AND (StyleSet = @StyleSet)


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04848', GetDate())
GO
