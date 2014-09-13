/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_SampleRequest_SELECT]    Script Date: 08/03/2014 18:15:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_WorkflowInfo_SampleRequest_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_SampleRequest_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_SampleRequest_SELECT]    Script Date: 08/03/2014 18:15:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_SampleRequest_SELECT]
	@TACalReferenceTaskID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @IsBOM INT = 0
	
    SELECT @IsBOM = FlagBOM
    FROM vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT cal
    WHERE TACalRefTaskId = @TACalReferenceTaskID
    
    IF @IsBOM > 0
    BEGIN
		SELECT cal.SampleRequestTradeID, cal.SampleRequestWorkflowID, cal.WorkflowId, srw.AssignedTo, srw.Status, cal.FlagBOM
		FROM vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT cal
		INNER JOIN pSampleRequestWorkflowBOM srw ON cal.SampleRequestWorkflowID = srw.SampleRequestWorkflowID
		WHERE TACalRefTaskId = @TACalReferenceTaskID
    END
    ELSE
    BEGIN
		SELECT cal.SampleRequestTradeID, cal.SampleRequestWorkflowID, cal.WorkflowId, srw.AssignedTo, srw.Status, cal.FlagBOM
		FROM vwx_TACalTemplateTask_ReferenceFromSampleRequest_SELECT cal
		INNER JOIN pSampleRequestWorkflow srw ON cal.SampleRequestWorkflowID = srw.SampleRequestWorkflowID
		WHERE TACalRefTaskId = @TACalReferenceTaskID
    END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08545', GetDate())
GO