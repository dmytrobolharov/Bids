IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT]    Script Date: 09/20/2011 12:37:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE [dbo].[dpx_StyleFolder_WorkflowUserToDoList_SELECT]  
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
  
DECLARE @SERVERURL AS VARCHAR(500)  
BEGIN  
 SET @SERVERURL = (SELECT SettingValue FROM rReportSetting WHERE SettingType = 'plmOnServer')  
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
  SELECT    
   @SERVERURL + '/Style/Style_Redirect.aspx?SID=' + CAST(pStyleHeader.StyleID AS VARCHAR(40)) + '&P=' +   
   CAST(pStyleWorkflow.WorkflowID AS VARCHAR(40)) AS PageUrl ,   
   pStyleHeader.*, pStyleSeasonYear.SeasonYearID, --pStyleWorkflowTemplate.Workflow, pStyleWorkflowTemplate.WorkflowSort,
   pStyleWorkflow.WorkStatus, pWorkflowStatus.WorkflowStatus, pStyleWorkflow.WorkflowID,   
      RTRIM(CAST(DATEDIFF(day, pStyleWorkflow.WorkDue, GETDATE()) AS NVARCHAR(10))) AS DaysLate  
      , RTRIM(CAST(DATEDIFF(day, pStyleWorkflow.WorkStart, GETDATE()) AS NVARCHAR(10))) AS DaysWork  
FROM pStyleHeader INNER JOIN  
      pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID INNER JOIN  
      pStyleWorkflow ON pStyleHeader.StyleID = pStyleWorkflow.StyleID INNER JOIN  
      --pStyleWorkflowTemplate ON pStyleWorkflow.WorkflowID = pStyleWorkflowTemplate.WorkflowID INNER JOIN  
      pWorkflowStatus ON pStyleWorkflow.WorkStatus = pWorkflowStatus.WorkflowStatusID  
WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND pStyleWorkflow.WorkAssignedTo IN (SELECT UserID FROM #tmpUsers)  
  AND pStyleWorkflow.WorkflowID = @WorkflowID   
ORDER BY pStyleSeasonYear.SeasonYearID, DaysLate desc --pStyleWorkflowTemplate.WorkflowSort  
END  
  
DROP TABLE #tmpUsers  
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01956'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01956', GetDate())
END

GO	