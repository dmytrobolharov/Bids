/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_ExtraData_SELECT]    Script Date: 26.02.2015 14:36:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_ExtraData_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_ExtraData_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_ExtraData_SELECT]    Script Date: 26.02.2015 14:36:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_ExtraData_SELECT](
	@BatchQueueJobID UNIQUEIDENTIFIER
)
AS


DECLARE 
	@SeasonYear NVARCHAR(200),
	@SQL NVARCHAR(MAX),
	@SeasonYearID UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialReplaceWithID UNIQUEIDENTIFIER,
	@ParmDefinition NVARCHAR(500),
	@BatchQueueID UNIQUEIDENTIFIER,
	@MaterialCoreID UNIQUEIDENTIFIER

SELECT @BatchQueueID = BatchQueueID FROM dbo.pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID

	
IF @BatchQueueID = '90000000-0000-0000-0000-000000000003' OR @BatchQueueID = '90000000-0000-0000-0000-000000000016'
 --** Add Material Batchqueue
BEGIN 
	
	-- Selected season/year
	SELECT @SeasonYearID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0000'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- Selected material
	SELECT @MaterialID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0001'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, a.MaterialID
	FROM dbo.pMaterial a WITH(NOLOCK)
	WHERE MaterialID = @MaterialID

END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000012' --** Material Replace batch queue
		OR @BatchQueueID = '90000000-0000-0000-0000-000000000015'
BEGIN 

	-- Selected season/year
	SELECT @SeasonYearID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0000'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- Selected material
	SELECT @MaterialID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0001'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	-- Selected material to replace with
	SELECT @MaterialReplaceWithID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0003'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, a.MaterialID, 
	@MaterialReplaceWithID AS MaterialReplaceWithID
	FROM dbo.pMaterial a WITH(NOLOCK)
	WHERE MaterialID = @MaterialID
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000010' --** Material Group batch queue
BEGIN 

	-- Selected season/year
	SELECT @SeasonYearID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0000'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID
	
	-- Selected material group
	SELECT @MaterialCoreID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0001'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, MaterialCoreID
	FROM dbo.pMaterialCore a WITH(NOLOCK)
	WHERE MaterialCoreID = @MaterialCoreID
			
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000017' --** Material Group batch queue to DBOM
BEGIN 
	-- Selected season/year
	SELECT @SeasonYearID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0000'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID
	
	-- Selected material group
	SELECT @MaterialCoreID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0001'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

		
	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, MaterialCoreID
	FROM dbo.pMaterialCore a WITH(NOLOCK)
	WHERE MaterialCoreID = @MaterialCoreID
			
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000011' --** StyleColorway batch queue
BEGIN 

	-- Selected season/year
	SELECT @SeasonYearID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0000'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID
	
	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID
	
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000013' --** Add Material Batchqueue
BEGIN 
	
	-- Selected season/year
	SELECT @SeasonYearID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0000'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- Selected material
	SELECT @MaterialID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0001'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, a.MaterialID
	FROM dbo.pMaterial a WITH(NOLOCK)
	WHERE MaterialID = @MaterialID

END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000014' --Add Image
BEGIN

	DECLARE @ImageJobItemID nVARCHAR(40)
	DECLARE @StyleJobItemID nVARCHAR(40)
	DECLARE @PageJobItemID nVARCHAR(40)

	SELECT @PageJobItemID =  BatchQueueJobItemID FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'	
	
	SELECT @ImageJobItemID =  BatchQueueJobItemID FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0001'	
	
	SELECT @StyleJobItemID =  BatchQueueJobItemID FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0002'	

	SELECT @StyleJobItemID AS StyleJobItemID, @ImageJobItemID AS ImageJobItemID, @PageJobItemID AS PageJobItemID

END
ELSE IF @BatchQueueID = '50000000-0000-0000-0000-000000000001' -- Comment #01 - Zip Tech packs
BEGIN 

	DECLARE 
		@ReportTechPackFolderID UNIQUEIDENTIFIER,
		@ReportTechPackFolderName NVARCHAR(200)

	-- Selected season/year
	SELECT @SeasonYearID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0000'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId

	SELECT @SeasonYear = Season + ' / ' + [Year] FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- Selected Tech Pack
	SELECT @ReportTechPackFolderID = rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID AND pg.BatchQueuePageOrder='0002'
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId
		
	SELECT @ReportTechPackFolderName = ReportTechPackFolderName 
	FROM dbo.rReportTechPackFolder WITH(NOLOCK)
	WHERE ReportTechPackFolderID = @ReportTechPackFolderID
	
	--** Output
	SELECT @SeasonYear AS SeasonYear, @SeasonYearID  AS SeasonYearID, @ReportTechPackFolderName AS ReportTechPackFolderName
END 




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09757', GetDate())
GO
