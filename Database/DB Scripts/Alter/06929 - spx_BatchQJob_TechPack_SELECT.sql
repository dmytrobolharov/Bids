IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_TechPack_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_TechPack_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJob_TechPack_SELECT]
	@BatchQueueJobID [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
DECLARE 
	@SeasonYear NVARCHAR(200),
	@SeasonTable NVARCHAR(200),
	@TechpackTable NVARCHAR(200), 
	@TechPackName NVARCHAR(200), 
	@SQL NVARCHAR(MAX),
	@SeasonYearID UNIQUEIDENTIFIER,
	@TechPackID UNIQUEIDENTIFIER,
	@ParmDefinition NVARCHAR(500),
	@BatchQueueID UNIQUEIDENTIFIER

BEGIN
	SELECT @BatchQueueID = BatchQueueID FROM dbo.pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID
END

BEGIN
	-- ** SeasonYear selected
	SELECT @SeasonTable =  BatchQueueJobTable 
	FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID  
	WHERE a.BatchQueueJobID = @BatchQueueJobID  AND b.BatchQueuePageOrder = '0000'

	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID
END

BEGIN
	-- ** Tech Pack selected
	SELECT @TechPackTable =  BatchQueueJobTable 
	FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID  
	WHERE a.BatchQueueJobID = @BatchQueueJobID  AND b.BatchQueuePageOrder = '0003'

	SET @SQL = 'SELECT @pTechPackID = ReportTechPackFolderID  FROM ' + @TechPackTable 
	SET @ParmDefinition = '@pTechPackID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pTechPackID = @TechPackID OUTPUT

	SELECT @TechPackName = ReportTechPackFolderName FROM  rReportTechPackFolder WITH(NOLOCK) WHERE ReportTechPackFolderID = @TechPackID
END

BEGIN
	SELECT @SeasonYearID AS SeasonYearID, @SeasonYear  AS SeasonYear, @TechPackID AS TechPackID, @TechPackName AS TechPackName
END	



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06929', GetDate())
GO
