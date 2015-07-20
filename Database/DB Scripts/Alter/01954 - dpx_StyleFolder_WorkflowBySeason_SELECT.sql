IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleFolder_WorkflowBySeason_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[dpx_StyleFolder_WorkflowBySeason_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[dpx_StyleFolder_WorkflowBySeason_SELECT]    Script Date: 09/20/2011 12:20:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[dpx_StyleFolder_WorkflowBySeason_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
)

AS

--DECLARE	@SeasonYearID uniqueidentifier 
--SELECT @SeasonYearID=N'33035e76-b8cd-413e-ba6f-c2a2b2b616d2'

IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN 
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
END


SELECT     TOP (100) PERCENT COUNT(*) AS COUNT, dbo.pStyleSeasonYear.SeasonYearID, 
dbo.pWorkflow.Workflow, dbo.pStyleWorkflow.WorkSort, dbo.pStyleWorkflow.WorkStatus, dbo.pWorkflowStatus.WorkflowStatus
FROM         dbo.pStyleHeader INNER JOIN
      dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID INNER JOIN
      dbo.pStyleWorkflow ON dbo.pStyleHeader.StyleID = dbo.pStyleWorkflow.StyleID INNER JOIN
      --dbo.pStyleWorkflowTemplate ON dbo.pStyleWorkflow.WorkflowID = dbo.pStyleWorkflowTemplate.WorkflowID INNER JOIN
      dbo.pWorkflow ON dbo.pWorkflow.WorkflowID = pStyleWorkflow.WorkflowID INNER JOIN
      dbo.pWorkflowStatus ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID
WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
GROUP BY dbo.pStyleSeasonYear.SeasonYearID, dbo.pWorkflow.Workflow, dbo.pStyleWorkflow.WorkSort, 
      dbo.pStyleWorkflow.WorkStatus, dbo.pWorkflowStatus.WorkflowStatus, pStyleWorkflow.WorkflowID
ORDER BY dbo.pStyleSeasonYear.SeasonYearID, dbo.pStyleWorkflow.WorkSort

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01954'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01954', GetDate())
END

GO	