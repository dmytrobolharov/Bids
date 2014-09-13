/****** Object:  StoredProcedure [dbo].[spx_ChangeLog_SELECT]    Script Date: 07/16/2012 15:31:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeLog_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeLog_SELECT]    Script Date: 07/16/2012 15:31:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_ChangeLog_SELECT]
	@ChangeTableID UNIQUEIDENTIFIER,
	@ChangeTransTablePKID UNIQUEIDENTIFIER,
	@StartDate DATETIME,
	@EndDate DATETIME,
	@WhereCond NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00008' -- Style full changelog
	BEGIN
		SELECT * INTO #tmpChange FROM (
			-- pStyleHeader -- pStyleMaterial -- pStaleColorwaySeasonYear
			SELECT * FROM vwx_ChangeLogItem_SEL 
			WHERE ChangeTableID IN ('D612FAAE-7ACD-DF11-AF06-005056C00008', 'DD12FAAE-7ACD-DF11-AF06-005056C00008', '036F8B4C-C1CC-DF11-AF06-005056C00008', '00000002-C1CC-DF11-AF06-005056C00008', '00000003-C1CC-DF11-AF06-005056C00008', 'D612FAAE-7ACD-DF11-AF06-005056C00009') 
				AND ChangeTransTablePKID = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate
		    
			UNION ALL
			-- pStyleCare
			SELECT l.* FROM vwx_ChangeLogItem_SEL l INNER JOIN pStyleCare c ON c.StyleCareId = l.ChangeTransTablePKID    
			WHERE ChangeTableID = 'D616FAAE-7ACD-DF11-AF06-005056C00008' AND c.StyleId = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate
		) Change
	    
		EXEC('SELECT * FROM #tmpChange ' + @WhereCond)	    
		DROP TABLE #tmpChange
    END
    ELSE  -- default behaviour
    BEGIN
		SELECT * INTO #tmpChangeDefault FROM (			
			SELECT * FROM vwx_ChangeLogItem_SEL 
			WHERE ChangeTableID = @ChangeTableID AND ChangeTransTablePKID = @ChangeTransTablePKID
				AND ChangeDate BETWEEN @StartDate AND @EndDate			
		) Change

		EXEC('SELECT * FROM #tmpChangeDefault ' + @WhereCond)
		DROP TABLE #tmpChangeDefault
    END
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03706', GetDate())
GO