/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_SourcingQuote_SELECT]    Script Date: 08/11/2014 12:22:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_WorkflowInfo_SourcingQuote_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_SourcingQuote_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_SourcingQuote_SELECT]    Script Date: 08/11/2014 12:22:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_SourcingQuote_SELECT]
	@TACalReferenceTaskID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT cal.StyleQuoteItemID, cal.WorkflowId, sqi.WorkAssignedTo, sqi.StyleQuoteItemStatusId AS WorkStatusID
	FROM vwx_TACalTemplateTask_ReferenceFromSourcingQuote_SELECT cal
	INNER JOIN pStyleQuoteItem sqi ON cal.StyleQuoteItemID = sqi.StyleQuoteItemID
	WHERE TACalRefTaskId = @TACalReferenceTaskID

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08733', GetDate())
GO
