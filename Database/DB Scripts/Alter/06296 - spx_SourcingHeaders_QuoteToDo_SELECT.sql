IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingHeaders_QuoteToDo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingHeaders_QuoteToDo_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_SourcingHeaders_QuoteToDo_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@WhereSQL NVARCHAR(MAX)
AS
BEGIN
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
		
	DECLARE @StyleCategoryId UNIQUEIDENTIFIER
	SELECT @StyleCategoryId = StyleCategory FROM pStyleHeader WHERE StyleID = @StyleID

	SELECT sh.*, 
	STUFF ((SELECT     ', ' + dbo.pStyleCategory.StyleCategory
		FROM dbo.pSourcingHeaderToStyleCategory 
		LEFT JOIN dbo.pStyleCategory ON dbo.pSourcingHeaderToStyleCategory.StyleCategoryID = dbo.pStyleCategory.StyleCategoryId
        WHERE dbo.pSourcingHeaderToStyleCategory.SourcingHeaderID = sh.SourcingHeaderID
        ORDER BY dbo.pStyleCategory.StyleCategory FOR XML PATH('')), 1, 2, '') AS StyleCategories,
    STUFF
          ((SELECT     ', ' + dbo.pStyleType.StyleTypeDescription
          FROM         dbo.pSourcingHeaderToStyleType
          LEFT JOIN dbo.pStyleType ON dbo.pSourcingHeaderToStyleType.StyleTypeID = dbo.pStyleType.StyleTypeID
		  WHERE dbo.pSourcingHeaderToStyleType.SourcingHeaderID = sh.SourcingHeaderID
		  ORDER BY dbo.pStyleType.StyleTypeDescription FOR XML PATH('')), 1, 2, '') AS StyleTypes,
	StyleAvailable = 
	CASE 
		WHEN 
			EXISTS(SELECT * FROM pSourcingStyle ss 
			WHERE ss.SourcingHeaderID = sh.SourcingHeaderID 
			AND ss.StyleID = @StyleID)
		THEN 1 
		ELSE 0
	END
	INTO #tmpSourcingHeader
	FROM pSourcingHeader sh
	WHERE sh.seasonYearId = @SeasonYearID AND (sh.StyleCategoryID IS NULL OR sh.StyleCategoryID = @StyleCategoryId)
	
	DECLARE @strSql NVARCHAR(MAX)
	SET @strSql = 'SELECT * FROM #tmpSourcingHeader ' + @WhereSQL
	EXEC sp_executesql @strSql
	
	DROP TABLE #tmpSourcingHeader

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06296', GetDate())
GO
