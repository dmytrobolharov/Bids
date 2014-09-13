/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_SourcingCommitment_SELECT]    Script Date: 08/11/2014 13:20:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_WorkflowInfo_SourcingCommitment_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_SourcingCommitment_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_SourcingCommitment_SELECT]    Script Date: 08/11/2014 13:20:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_SourcingCommitment_SELECT]
	@TACalReferenceTaskID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cal.SourcingCommitmentItemID, cal.WorkflowId, sci.WorkAssignedTo, sci.StyleQuoteItemStatusId AS WorkStatusID
	FROM vwx_TACalTemplateTask_ReferenceFromSourcingCommitment_SELECT cal
	INNER JOIN pSourcingCommitmentItem sci ON cal.SourcingCommitmentItemID = sci.SourcingCommitmentItemID
	WHERE TACalRefTaskId = @TACalReferenceTaskID

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08732', GetDate())
GO
