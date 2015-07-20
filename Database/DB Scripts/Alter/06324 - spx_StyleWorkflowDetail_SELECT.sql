IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowDetail_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowDetail_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowDetail_SELECT](
@StyleID uniqueidentifier,
@StyleSet int,
@WorkflowID uniqueidentifier,
@SeasonYearID uniqueidentifier)
AS 

declare @StyleSeasonYearID uniqueidentifier
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

SELECT dbo.pStyleWorkflow.StyleWorkflowID, dbo.pStyleWorkflow.StyleID, dbo.pStyleWorkflow.StyleSet, dbo.pStyleWorkflow.WorkflowID, 
    dbo.pStyleWorkflow.WorkflowType, dbo.pStyleWorkflow.WorkflowOrder, dbo.pStyleWorkflow.WorkDate, dbo.pStyleWorkflow.WorkStart, 
    dbo.pStyleWorkflow.WorkDue, dbo.pStyleWorkflow.WorkAssignedTo, dbo.pStyleWorkflow.WorkComplete, dbo.pStyleWorkflow.WorkStatus, 
    dbo.pStyleWorkflow.WorkStatusDate, dbo.pStyleWorkflow.WorkStatusBy, dbo.pStyleWorkflow.WorkVersion, dbo.pStyleWorkflow.WorkComments, 
    dbo.pStyleWorkflow.CUser, dbo.pStyleWorkflow.CDate, dbo.pStyleWorkflow.MUser, dbo.pStyleWorkflow.MDate, dbo.pWorkflowStatus.WorkflowStatus, 
    dbo.pWorkflowStatus.WorkflowStatusImage, dbo.Users.UserCode, dbo.Users.TeamID, 
    CASE WHEN dbo.pStyleWorkflow.WorkAssignedTo >= 9000 THEN dbo.uGroup.GroupName ELSE dbo.Users.FirstName END AS FirstName,
    CASE WHEN dbo.pStyleWorkflow.WorkAssignedTo >= 9000 THEN '(' + dbo.uGroup.GroupDescription + ')' ELSE dbo.Users.LastName END AS LastName,
    dbo.Users.MiddleName, dbo.Users.Email, dbo.Mapping.MapDetail, dbo.pStyleWorkflow.WorkSort
FROM dbo.pStyleWorkflow WITH (NOLOCK) INNER JOIN
    dbo.Mapping WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map LEFT OUTER JOIN
    dbo.Users WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkAssignedTo = dbo.Users.UserId LEFT OUTER JOIN
    dbo.uGroup WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkAssignedTo = dbo.uGroup.WorkflowGroupID LEFT OUTER JOIN
    dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID
WHERE (dbo.pStyleWorkflow.StyleID = @StyleID) AND (dbo.pStyleWorkflow.StyleSet = @StyleSet) AND (dbo.pStyleWorkflow.WorkflowID = @WorkflowID)
	AND (Mapping.IsSeasonal = 1 AND pStyleWorkflow.StyleSeasonYearID = @StyleSeasonYearID OR Mapping.IsSeasonal <> 1)
ORDER BY dbo.pStyleWorkflow.StyleID, dbo.pStyleWorkflow.WorkSort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06324', GetDate())
GO
