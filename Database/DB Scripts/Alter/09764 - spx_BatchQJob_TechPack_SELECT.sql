/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_TechPack_SELECT]    Script Date: 25.02.2015 17:40:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_TechPack_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_TechPack_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_TechPack_SELECT]    Script Date: 25.02.2015 17:40:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_TechPack_SELECT]
	@BatchQueueJobID [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
BEGIN

	DECLARE 
		@SeasonYear NVARCHAR(200),
		@TechPackName NVARCHAR(200), 
		@SQL NVARCHAR(MAX),
		@SeasonYearID UNIQUEIDENTIFIER,
		@TechPackID UNIQUEIDENTIFIER,
		@ParmDefinition NVARCHAR(500),
		@BatchQueueID UNIQUEIDENTIFIER

	SELECT @BatchQueueID = BatchQueueID FROM dbo.pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID

	-- ** SeasonYear selected
	SELECT @SeasonYearID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND pg.BatchQueuePageOrder='0000'

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- ** Tech Pack selected
	SELECT @TechPackID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND pg.BatchQueuePageOrder='0005'

	SELECT @TechPackName = ReportTechPackFolderName FROM  rReportTechPackFolder WITH(NOLOCK) WHERE ReportTechPackFolderID = @TechPackID

	SELECT @SeasonYearID AS SeasonYearID, @SeasonYear  AS SeasonYear, @TechPackID AS TechPackID, @TechPackName AS TechPackName	

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09764', GetDate())
GO
