IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SampleRequestWorkflow_ToDoList_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[dpx_SampleRequestWorkflow_ToDoList_SELECT]
GO


CREATE PROCEDURE [dbo].[dpx_SampleRequestWorkflow_ToDoList_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL,
	@UserGroupID uniqueidentifier = NULL
)

AS


BEGIN 
CREATE TABLE #tmpUsers(
	[UserId] [int] NULL,
	[TeamID] [uniqueidentifier] NULL
	)
END

IF (SELECT COUNT(*) FROM uGroup WHERE GroupID = @UserGroupID) = 0 
	BEGIN
		INSERT INTO #tmpUsers (UserId, TeamID)
		SELECT	UserID, TeamID FROM Users WHERE TeamID = @UserGroupID 
	END
ELSE
	BEGIN
		INSERT INTO #tmpUsers (UserId, TeamID)
		SELECT	Users.UserId, Users.TeamID
		FROM Users INNER JOIN
		uUserGroup ON Users.TeamID = uUserGroup.TeamID WHERE uUserGroup.GroupID = @UserGroupID 
	END



IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN 
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
END

CREATE TABLE #tempStyleSeasonYear(
	StyleID uniqueidentifier,
	SeasonYearID uniqueidentifier
)

INSERT INTO #tempStyleSeasonYear (StyleID, SeasonYearID)
SELECT StyleID, SeasonYearID FROM pStyleSeasonYear 
WHERE SeasonYearID = @SeasonYearID

SELECT COUNT(*) AS COUNT, dbo.pSampleWorkflow.SampleWorkflow, 
	CASE WHEN pSampleRequestSubmitStatus.StatusID = 0 AND pSampleRequestWorkflow.Submit <> 1 THEN 1
	ELSE pSampleRequestSubmitStatus.StatusID
	END AS StatusID, 
	CASE WHEN pSampleRequestSubmitStatus.StatusID = 0 AND pSampleRequestWorkflow.Submit <> 1 THEN 'Resubmit'
	ELSE pSampleRequestSubmitStatus.Status
	END AS Status
	,pSampleWorkflow.SampleWorkflowSort
	,pSampleWorkflow.SampleWorkflowId
FROM         dbo.pSampleRequestWorkflow INNER JOIN
                      dbo.pSampleWorkflow ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
                      dbo.pSampleRequestSubmitStatus ON dbo.pSampleRequestWorkflow.Status = dbo.pSampleRequestSubmitStatus.StatusID
WHERE pSampleRequestWorkflow.StyleId IN (SELECT StyleID FROM #tempStyleSeasonYear) 
	AND  (dbo.pSampleRequestWorkflow.AssignedTo IN (SELECT UserID FROm #tmpUsers))
GROUP BY dbo.pSampleWorkflow.SampleWorkflow, dbo.pSampleRequestSubmitStatus.Status, dbo.pSampleRequestSubmitStatus.StatusID, 
                      dbo.pSampleRequestWorkflow.TradePartnerID, pSampleRequestWorkflow.Submit
                      ,pSampleWorkflow.SampleWorkflowSort
                      ,pSampleWorkflow.SampleWorkflowId
ORDER BY dbo.pSampleRequestSubmitStatus.StatusID


DROP TABLE #tempStyleSeasonYear
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01452', GetDate())
GO