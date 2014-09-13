/****** Object:  StoredProcedure [dbo].[spx_SourcingHeaders_QuoteToDo_SELECT]    Script Date: 02/19/2013 12:02:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingHeaders_QuoteToDo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingHeaders_QuoteToDo_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingHeaders_QuoteToDo_SELECT]    Script Date: 02/19/2013 12:02:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SourcingHeaders_QuoteToDo_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@WhereSQL NVARCHAR(MAX)
AS
BEGIN

	SELECT sh.*, StyleAvailable = 
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
	WHERE sh.seasonYearId = @SeasonYearID
	
	DECLARE @strSql NVARCHAR(MAX)
	SET @strSql = 'SELECT * FROM #tmpSourcingHeader ' + @WhereSQL
	EXEC sp_executesql @strSql
	
	DROP TABLE #tmpSourcingHeader

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05063', GetDate())
GO
