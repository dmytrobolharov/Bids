/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_TechPackStyle_SELECT]    Script Date: 25.02.2015 17:46:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_TechPackStyle_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_TechPackStyle_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_TechPackStyle_SELECT]    Script Date: 25.02.2015 17:46:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQJob_TechPackStyle_SELECT]
	@BatchQueueJobID [uniqueidentifier],
	@BatchQueueJobSql [nvarchar](max)
WITH EXECUTE AS CALLER
AS
BEGIN
	DECLARE 
		@StyleID UNIQUEIDENTIFIER,
		@SQL NVARCHAR(MAX),
		@BatchQueueID UNIQUEIDENTIFIER

	SELECT @BatchQueueID = BatchQueueID FROM dbo.pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID
	-- ** Style selected
	SET @SQL = '
		SELECT DISTINCT BatchQJob.*, pTechPack.TechPackNo FROM (' + @BatchQueueJobSql + ') AS BatchQJob 
		INNER JOIN pBatchQueueJobItemRecord AS Styles ON Styles.BatchQueuePagePki = BatchQJob.StyleID
		INNER JOIN pBatchQueueJobItem AS job ON job.BatchQueueJobItemID = Styles.BatchQueueJobItemID 
			AND job.BatchQueueJobID =  ''' + CAST(@BatchQueueJobID AS NVARCHAR(40)) + '''
		INNER JOIN pBatchQueuePage page ON job.BatchQueuePageID = page.BatchQueuePageID AND page.BatchQueuePageOrder = ''0004''
		LEFT OUTER JOIN rReportStylePageItemTemp 
			INNER JOIN pTechPack ON pTechPack.TechPackID = rReportStylePageItemTemp.ReportTechpackID
		ON rReportStylePageItemTemp.StyleID = BatchQJob.StyleID AND rReportStylePageItemTemp.ReportBatchQueueID = ''' + CAST(@BatchQueueJobID AS NVARCHAR(40)) + '''
	'
	EXEC sp_executesql @SQL
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09766', GetDate())
GO
