IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Dashboard_StyleRemoval_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Dashboard_StyleRemoval_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Dashboard_StyleRemoval_SELECT]

AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		sr.StyleNo
		, sr.Description
		, sc.StyleCategory as StyleCategoryName
		, sy.Season
		, sy.Year
		, ISNULL(u.FirstName + ' ', '') + ISNULL(u.MiddleName + ' ', '') + ISNULL(u.LastName, '') AS DelUserName
		, sr.RemovalDate
		, srr.RemovalReason
		, sr.RemovalComment
		, sr.StyleCategory
		, sr.RemovalTeamID
		, sr.RemovalReasonID
		, sr.StyleID
	FROM
		pStyleRemoval sr
		INNER JOIN pStyleRemovalReason srr ON sr.RemovalReasonID = srr.RemovalReasonID
		INNER JOIN pStyleCategory sc ON sr.StyleCategory = sc.StyleCategoryId
		INNER JOIN pSeasonYear sy ON sr.IntroSeasonYearID = sy.SeasonYearID
		INNER JOIN Users u ON sr.RemovalTeamID = u.TeamID

	SET NOCOUNT OFF;
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05093', GetDate())
GO
