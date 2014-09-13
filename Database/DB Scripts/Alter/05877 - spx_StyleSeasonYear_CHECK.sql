IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYear_CHECK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYear_CHECK]
GO

CREATE PROCEDURE [dbo].[spx_StyleSeasonYear_CHECK](@StyleId uniqueidentifier)
AS 

/*
It will select the IntroSeasonYearID from pStyleHeader and create an 
entry on pStyleSeasonYear and pStyleColorwaySeasonYear for seasonality.
Daniel Pak 2/17/01
*/

IF (SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID) = 0
BEGIN
	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
	SET @StyleSeasonYearID = newid()

	INSERT INTO pStyleSeasonYear (StyleSeasonYearID, StyleID, SeasonYearID, StyleSeason, StyleYear)
	SELECT @StyleSeasonYearID, @StyleID, SeasonYearID, Season, [Year] 
	FROM pSeasonYear INNER JOIN
	  pStyleHeader ON pSeasonYear.SeasonYearID = pStyleHeader.IntroSeasonYearID
	WHERE StyleID = @StyleID
	
	
	/*** insert to pStyleWorkflow records for seasonal workflows after Style Season Year is added ***/
	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleWorkflow' AND COLUMN_NAME = 'StyleSeasonYearID')
	BEGIN
		;WITH StyleSets(StyleSet) as (
			-- is used to get all combination with style sets up to a number of style sets in style
			SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
		)
		INSERT INTO pStyleWorkflow(
			StyleID, StyleSet, WorkflowID, WorkflowType, WorkDate, WorkStart, 
			WorkDue, WorkAssignedTo,  WorkStatus, 
			WorkVersion, WorkComments, WorkSort, CUser, CDate, MUser, MDate, 
			WorkDay, StyleSeasonYearID)	
		SELECT sh.StyleID, ss.StyleSet, wti.WorkflowID, NULL, GETDATE(), GETDATE(), 
			DATEADD(DAY, CASE WHEN ISNUMERIC(wti.WorkflowDays) = 1 THEN -wti.WorkflowDays ELSE 0 END, sh.DueDate), wti.WorkflowAssignedTo, 6,
			NULL, NULL, wti.WorkflowSort, sh.CUser, sh.CDate, sh.CUser, sh.CDate, 
			CASE WHEN ISNUMERIC(wti.WorkflowDays) = 1 THEN wti.WorkflowDays ELSE 0 END, ssy.StyleSeasonYearID 
		FROM pStyleHeader sh 
		LEFT JOIN StyleSets ss ON sh.StyleSet >= ss.StyleSet
		INNER JOIN pWorkflowTemplateItem wti ON sh.StyleWorkflowID = wti.WorkflowTemplateID
		INNER JOIN Mapping m ON wti.WorkflowID = m.Map
		INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
		WHERE sh.StyleID = @StyleID AND m.IsSeasonal = 1
			AND NOT EXISTS(SELECT * FROM pStyleWorkflow sw WHERE sw.StyleID = sh.StyleID AND sw.WorkflowID = wti.WorkflowID AND sw.StyleSeasonYearID = ssy.StyleSeasonYearID)
	END
	/**********************************************************************************************/


	INSERT INTO pStyleColorwaySeasonYear(StyleSeasonYearID, StyleColorwayID, StyleID)
	SELECT @StyleSeasonYearID, StyleColorID, @StyleID FROM pStyleColorway 
	WHERE StyleID = @StyleID
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05877', GetDate())
GO
