/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_Style_SELECT]    Script Date: 08/04/2014 15:19:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_WorkflowInfo_Style_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_Style_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_Style_SELECT]    Script Date: 08/04/2014 15:19:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_Style_SELECT]
	@TACalReferenceTaskID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
	SELECT sw.StyleID, sw.StyleSet, sw.WorkflowID, sw.StyleSeasonYearID, sw.WorkStart, sw.WorkDue, sw.WorkAssignedTo, sw.WorkEscalateTo,
			sw.WorkStatus, sw.WorkComments,	cal.SeasonYearId, sh.StyleNo
	FROM vwx_TACalTemplateTask_ReferenceFromStyle_SELECT cal
	INNER JOIN pStyleWorkflow sw ON sw.StyleWorkflowID = cal.StyleWorkflowID
	INNER JOIN pStyleHeader sh ON sw.StyleID = sh.StyleID
	WHERE TACalRefTaskId = @TACalReferenceTaskID
    
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08559', GetDate())
GO
