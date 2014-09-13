IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_QuoteToDoSourcingFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_QuoteToDoSourcingFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_QuoteToDoSourcingFolder_SELECT]
	@SeasonYearId UNIQUEIDENTIFIER = NULL
AS
BEGIN
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	SELECT
		'00000000-0000-0000-0000-000000000000' AS SourcingHeaderID
		, 'N/A' AS SourcingName
	UNION
	SELECT
		SourcingHeaderID
		, SourcingName
	FROM pSourcingHeader
	WHERE
		Active = 1
		AND seasonYearId = @SeasonYearId
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05160', GetDate())
GO
