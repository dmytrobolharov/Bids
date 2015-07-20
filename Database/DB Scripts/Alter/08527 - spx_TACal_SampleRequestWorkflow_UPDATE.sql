IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_SampleRequestWorkflow_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_SampleRequestWorkflow_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_TACal_SampleRequestWorkflow_UPDATE]
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
DECLARE @StyleColorID UNIQUEIDENTIFIER
DECLARE @StyleSet NVARCHAR(10)
DECLARE @Submit INT

SELECT 
@SampleWorkflowID = SampleWorkflowID, 
@SampleRequestTradeID = SampleRequestTradeID, 
@TeamID = TradePartnerVendorID,
@StyleID = StyleID, 
@StyleColorID = StyleColorID, 
@StyleSet = StyleSet, 
@Submit = Submit 
FROM pSampleRequestWorkflow WITH (NOLOCK) WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID)

UPDATE    pSampleRequestWorkflow
SET       AssignedTo = @AssignedTo, ResubmitDays = @ResubmitDays, SampleWorkflowPartnerTypeID = @SampleWorkflowPartnerTypeID
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID)

UPDATE    pSampleRequestSubmit
SET       AssignedTo = @AssignedTo
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
           (Submit = @Submit) AND (StyleID = @StyleID) AND (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet)

-- update RevisedStart and RevisedEnd in calendar references table 
IF @TACalRefTaskId IS NOT NULL
BEGIN
	UPDATE	pTACalReferenceTask 
	SET		TaskRevisedlStart = @RevisedStart, TaskRevisedEnd = @RevisedEnd
	WHERE	TACalRefTaskId = @TACalRefTaskId
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08527', GetDate())
GO
