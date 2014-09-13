IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflow_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflow_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflow_UPDATE]
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
declare @StyleColorID uniqueidentifier
declare @StyleSet nvarchar(10)
declare @Submit int

SELECT 
@SampleRequestWorkflowID = SampleRequestWorkflowID, 
@SampleWorkflowID = SampleWorkflowID, 
@SampleRequestTradeID = SampleRequestTradeID, 
@TeamID = TradePartnerVendorID,
@StyleID = StyleID, 
@StyleColorID = StyleColorID, 
@StyleSet = StyleSet, 
@Submit = Submit 
FROM pSampleRequestWorkflow WITH (NOLOCK) WHERE (SampleRequestWorkflowID = @SampleRequestID) --@SampleRequestWorkflowID)

UPDATE    pSampleRequestWorkflow
SET       AssignedTo = @AssignedTo, DueDate = @DueDate, ResubmitDays = @ResubmitDays, SampleWorkflowFinalDate = @SampleWorkflowFinalDate, SampleWorkflowPartnerTypeID = @SampleWorkflowPartnerTypeID
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID)

UPDATE    pSampleRequestSubmit
SET       AssignedTo = @AssignedTo, DueDate = @DueDate 
WHERE     (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (SampleRequestTradeID = @SampleRequestTradeID) AND 
           (Submit = @Submit) AND (StyleID = @StyleID) AND (StyleColorID = @StyleColorID) AND (StyleSet = @StyleSet)


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04847', GetDate())
GO
