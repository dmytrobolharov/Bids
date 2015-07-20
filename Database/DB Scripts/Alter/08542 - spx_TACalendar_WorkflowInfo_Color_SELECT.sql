/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_Color_SELECT]    Script Date: 08/03/2014 17:25:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_WorkflowInfo_Color_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_Color_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_Color_SELECT]    Script Date: 08/03/2014 17:25:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_Color_SELECT]
	@TACalReferenceTaskID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT cf.ColorFolderID, cf.ColorFolderDescription, cwp.ColorFolderWorkflowPageID, cwp.ColorFolderWorkflowID, cwp.WorkStatus, cwp.WorkAssignedTo
    FROM vwx_TACalTemplateTask_ReferenceFromColor_SELECT cal
    INNER JOIN pColorFolderWorkflowPage cwp ON cwp.ColorFolderWorkflowPageID = cal.ColorFolderWorkflowPageID
    INNER JOIN pColorFolder cf ON cf.ColorFolderID = cwp.ColorFolderID
    WHERE TACalRefTaskId = @TACalReferenceTaskID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08542', GetDate())
GO