IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleFolder_WorkflowBySeasonAndStyleType_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[dpx_StyleFolder_WorkflowBySeasonAndStyleType_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[dpx_StyleFolder_WorkflowBySeasonAndStyleType_SELECT]    Script Date: 09/20/2011 12:36:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE [dbo].[dpx_StyleFolder_WorkflowBySeasonAndStyleType_SELECT]  
(  
 @SeasonYearID uniqueidentifier = NULL,  
 @UserGroupID uniqueidentifier = NULL,  
 @WorkflowID uniqueidentifier = NULL  
)  
  
AS  
    
BEGIN   
CREATE TABLE #tmpUsers(  
 [UserId] [int] NULL,  
 [TeamID] [uniqueidentifier] NULL  
 )  
END  
    
IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'  
BEGIN   
 SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1  
END  
  
IF (SELECT COUNT(*) FROM uGroup WHERE GroupID = @UserGroupID) = 0   
 BEGIN  
  INSERT INTO #tmpUsers (UserId, TeamID)  
  SELECT UserID, TeamID FROM Users WHERE TeamID = @UserGroupID   
 END  
ELSE  
 BEGIN  
  INSERT INTO #tmpUsers (UserId, TeamID)  
  SELECT Users.UserId, Users.TeamID  
  FROM Users INNER JOIN  
  uUserGroup ON Users.TeamID = uUserGroup.TeamID WHERE uUserGroup.GroupID = @UserGroupID   
 END  
  
BEGIN  
SELECT COUNT(*) AS COUNT, dbo.pStyleSeasonYear.SeasonYearID, dbo.pWorkflow.Workflow,   
      dbo.pStyleWorkflow.WorkSort, dbo.pStyleWorkflow.WorkStatus, dbo.pWorkflowStatus.WorkflowStatus, pStyleWorkflow.WorkflowID    
FROM dbo.pStyleHeader INNER JOIN  
      dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID INNER JOIN  
      dbo.pStyleWorkflow ON dbo.pStyleHeader.StyleID = dbo.pStyleWorkflow.StyleID INNER JOIN  
      --dbo.pStyleWorkflowTemplate ON dbo.pStyleWorkflow.WorkflowID = dbo.pStyleWorkflowTemplate.WorkflowID INNER JOIN  
      dbo.pWorkflow ON dbo.pWorkflow.WorkflowID = pStyleWorkflow.WorkflowID INNER JOIN
      dbo.pWorkflowStatus ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID  
WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND pStyleWorkflow.WorkAssignedTo IN (SELECT UserID FROM #tmpUsers)  
  AND pStyleWorkflow.WorkflowID = @WorkflowID   
GROUP BY dbo.pStyleSeasonYear.SeasonYearID, dbo.pWorkflow.Workflow, dbo.pStyleWorkflow.WorkSort,   
      dbo.pStyleWorkflow.WorkStatus, dbo.pWorkflowStatus.WorkflowStatus, pStyleWorkflow.WorkflowID   
ORDER BY dbo.pStyleSeasonYear.SeasonYearID, dbo.pStyleWorkflow.WorkSort  
END
  
DROP TABLE #tmpUsers  
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01955'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01955', GetDate())
END

GO	