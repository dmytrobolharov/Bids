/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_TechPack_SELECT]    Script Date: 08/04/2014 15:31:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalendar_WorkflowInfo_TechPack_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_TechPack_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalendar_WorkflowInfo_TechPack_SELECT]    Script Date: 08/04/2014 15:31:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TACalendar_WorkflowInfo_TechPack_SELECT]
	@TACalReferenceTaskID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
	SELECT stps.StyleID, stps.StyleSeasonYearID, stps.WorkStart, stps.WorkDue, stps.WorkAssignedTo,
			stps.WorkStatus, cal.SeasonYearId, sh.StyleNo, stps.StyleTechPackStatusID
	FROM vwx_TACalTemplateTask_ReferenceFromStyleTechPack_SELECT cal
	INNER JOIN pStyleTechPackStatus stps ON cal.StyleTechPackStatusID = stps.StyleTechPackStatusID
	INNER JOIN pStyleHeader sh ON stps.StyleID = sh.StyleID
	WHERE TACalRefTaskId = @TACalReferenceTaskID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08560', GetDate())
GO
