IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleToDo_PieChart_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleToDo_PieChart_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleToDo_PieChart_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER
	, @DivisionID UNIQUEIDENTIFIER
	, @StyleTypeID INT = NULL
	, @StyleCategoryID UNIQUEIDENTIFIER = NULL
	, @StyleStatusID NVARCHAR(5) = NULL
)
AS
BEGIN

	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	IF @StyleStatusID IS NOT NULL
		SELECT COUNT (sh.StyleID) AS CNT, ISNULL(xc.Custom, 'N/A') AS TXT, @StyleTypeID AS StyleTypeID, @StyleCategoryID AS StyleCategoryID, ISNULL(xc.CustomKey, '-1') AS StyleStatusID
		FROM pStyleHeader sh INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID AND ssy.SeasonYearID = @SeasonYearID LEFT JOIN xCustom8 xc ON sh.CustomField3 = xc.Custom
		WHERE sh.DivisionID = @DivisionID AND sh.StyleType = @StyleTypeID AND sh.StyleCategory = @StyleCategoryID AND sh.StyleCategory = @StyleCategoryID AND xc.CustomKey = @StyleStatusID
		GROUP BY xc.CustomKey, xc.Custom
	ELSE IF @StyleCategoryID IS NOT NULL
		SELECT COUNT (sh.StyleID) AS CNT, ISNULL(xc.Custom, 'N/A') AS TXT, @StyleTypeID AS StyleTypeID, @StyleCategoryID AS StyleCategoryID, ISNULL(xc.CustomKey, '-1') AS StyleStatusID
		FROM pStyleHeader sh INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID AND ssy.SeasonYearID = @SeasonYearID LEFT JOIN xCustom8 xc ON sh.CustomField3 = xc.Custom
		WHERE sh.DivisionID = @DivisionID AND sh.StyleType = @StyleTypeID AND sh.StyleCategory = @StyleCategoryID AND sh.StyleCategory = @StyleCategoryID
		GROUP BY xc.CustomKey, xc.Custom
	ELSE IF @StyleTypeID IS NOT NULL
		SELECT COUNT (sh.StyleID) AS CNT, sc.StyleCategory AS TXT, @StyleTypeID AS StyleTypeID, sc.StyleCategoryId AS StyleCategoryID, @StyleStatusID AS StyleStatusID
		FROM pStyleHeader sh INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID AND ssy.SeasonYearID = @SeasonYearID INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
		WHERE sh.DivisionID = @DivisionID AND sh.StyleType = @StyleTypeID
		GROUP BY sc.StyleCategoryId, sc.StyleCategory
	ELSE
		SELECT COUNT (sh.StyleID) AS CNT, st.StyleTypeDescription AS TXT, st.StyleTypeID AS StyleTypeID, @StyleCategoryID AS StyleCategoryID, @StyleStatusID AS StyleStatusID
		FROM pStyleHeader sh INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID AND ssy.SeasonYearID = @SeasonYearID INNER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
		WHERE sh.DivisionID = @DivisionID
		GROUP BY st.StyleTypeID, st.StyleTypeDescription
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08831', GetDate())
GO
