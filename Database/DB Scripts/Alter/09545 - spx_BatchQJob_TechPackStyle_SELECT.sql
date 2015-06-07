/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_TechPackStyle_SELECT]    Script Date: 21.02.2015 17:57:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_TechPackStyle_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_TechPackStyle_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_TechPackStyle_SELECT]    Script Date: 21.02.2015 17:57:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_TechPackStyle_SELECT]
	@BatchQueueJobID [uniqueidentifier],
	@BatchQueueJobSql [nvarchar](max)
WITH EXECUTE AS CALLER
AS
DECLARE 
	@StyleID UNIQUEIDENTIFIER,
	@StyleTable NVARCHAR(200), 
	@SQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(500),
	@BatchQueueID UNIQUEIDENTIFIER

BEGIN
	SELECT @BatchQueueID = BatchQueueID FROM dbo.pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID
END

BEGIN
	-- ** Style selected
	SELECT @StyleTable =  BatchQueueJobTable 
	FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID  
	WHERE a.BatchQueueJobID = @BatchQueueJobID  AND b.BatchQueuePageOrder = '0004'

	SET @SQL = '
		SELECT DISTINCT BatchQJob.*, pTechPack.TechPackNo FROM (' + @BatchQueueJobSql + ') AS BatchQJob 
		INNER JOIN ' + @StyleTable + ' AS Styles ON Styles.StyleID = BatchQJob.StyleID
		LEFT OUTER JOIN rReportStylePageItemTemp 
			INNER JOIN pTechPack ON pTechPack.TechPackID = rReportStylePageItemTemp.ReportTechpackID
		ON rReportStylePageItemTemp.StyleID = Styles.StyleID AND rReportStylePageItemTemp.ReportBatchQueueID = ''' + CAST(@BatchQueueJobID AS NVARCHAR(40)) + '''
	'
	EXEC sp_executesql @SQL


END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09545', GetDate())
GO