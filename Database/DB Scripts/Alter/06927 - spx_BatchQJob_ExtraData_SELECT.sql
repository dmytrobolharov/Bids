IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_ExtraData_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_ExtraData_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQJob_ExtraData_SELECT](
	@BatchQueueJobID UNIQUEIDENTIFIER
)
AS


DECLARE 
	@SeasonYear NVARCHAR(200),
	@SeasonTable NVARCHAR(200),
	@MaterialGroupTable NVARCHAR(200),
	@MaterialTable NVARCHAR(200), 
	@MaterialReplaceWithTable NVARCHAR(200), 
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
	
	
	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'

	SELECT @MaterialTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0001'


	-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- ** Material selected
	SET @SQL = 'SELECT @pMaterialID = MaterialID FROM ' + @MaterialTable
	SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialID = @MaterialID OUTPUT


	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, a.MaterialID
	FROM dbo.pMaterial a WITH(NOLOCK)
	WHERE MaterialID = @MaterialID

END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000012' --** Material Replace batch queue
		OR @BatchQueueID = '90000000-0000-0000-0000-000000000015'
BEGIN 
	
	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'


	SELECT @MaterialTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0001'

	SELECT @MaterialReplaceWithTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0003'

	
	-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- ** Material 
	SET @SQL = 'SELECT @pMaterialID = MaterialID FROM ' + @MaterialTable
	SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialID = @MaterialID OUTPUT


	-- ** Material to replace with 
	SET @SQL = 'SELECT @pMaterialID = MaterialID FROM ' + @MaterialReplaceWithTable
	SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialID = @MaterialReplaceWithID OUTPUT


	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, a.MaterialID, 
	@MaterialReplaceWithID AS MaterialReplaceWithID
	FROM dbo.pMaterial a WITH(NOLOCK)
	WHERE MaterialID = @MaterialID
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000010' --** Material Group batch queue
BEGIN 


	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'

	SELECT @MaterialGroupTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0001'
	
	
		-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID
	
	-- ** Material Group
	SET @SQL = 'SELECT @pMaterialCoreID = MaterialCoreID FROM ' + @MaterialGroupTable
	SET @ParmDefinition = '@pMaterialCoreID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialCoreID = @MaterialCoreID OUTPUT

		
	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, MaterialCoreID
	FROM dbo.pMaterialCore a WITH(NOLOCK)
	WHERE MaterialCoreID = @MaterialCoreID
			
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000017' --** Material Group batch queue to DBOM
BEGIN 


	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'

	SELECT @MaterialGroupTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0001'
	
	
		-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID
	
	-- ** Material Group
	SET @SQL = 'SELECT @pMaterialCoreID = MaterialCoreID FROM ' + @MaterialGroupTable
	SET @ParmDefinition = '@pMaterialCoreID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialCoreID = @MaterialCoreID OUTPUT

		
	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID, MaterialCoreID
	FROM dbo.pMaterialCore a WITH(NOLOCK)
	WHERE MaterialCoreID = @MaterialCoreID
			
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000011' --** StyleColorway batch queue
BEGIN 

	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'



	-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID
	
	SELECT @SeasonYear  AS SeasonYear, @SeasonYearID AS SeasonYearID
	
	
END 
ELSE IF @BatchQueueID = '90000000-0000-0000-0000-000000000013' --** Add Material Batchqueue
BEGIN 
	
	
	SELECT @SeasonTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'

	SELECT @MaterialTable =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0001'


	-- ** SeasonYear selected
	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @SeasonTable 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + Year  FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID

	-- ** Material selected
	SET @SQL = 'SELECT @pMaterialID = MaterialID FROM ' + @MaterialTable
	SET @ParmDefinition = '@pMaterialID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pMaterialID = @MaterialID OUTPUT


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
		@TableName NVARCHAR(200),
		@ReportTechPackFolderID UNIQUEIDENTIFIER,
		@ReportTechPackFolderName NVARCHAR(200)

	-- ** SeasonYear selected		
	SELECT @TableName =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0000'

	SET @SQL = 'SELECT @pSeasonYearID = SeasonYearID  FROM ' + @TableName 
	SET @ParmDefinition = '@pSeasonYearID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pSeasonYearID = @SeasonYearID OUTPUT

	SELECT @SeasonYear = Season + ' / ' + [Year] FROM dbo.pSeasonYear WITH(NOLOCK) WHERE SeasonYearID = @SeasonYearID


	--** Get Tech pack selected
	SELECT @TableName =  BatchQueueJobTable FROM dbo.pBatchQueueJobItem a WITH(NOLOCK)
		INNER JOIN dbo.pBatchQueuePage b  WITH(NOLOCK) ON a.BatchQueuePageID = b.BatchQueuePageID 
	WHERE a.BatchQueueJobID = @BatchQueueJobID AND 	b.BatchQueuePageOrder = '0002'

	SET @SQL = 'SELECT @pReportTechPackFolderID = ReportTechPackFolderID FROM ' + @TableName 
	SET @ParmDefinition = '@pReportTechPackFolderID UNIQUEIDENTIFIER OUTPUT'
	EXEC sp_executesql @SQL, @ParmDefinition, 
		@pReportTechPackFolderID = @ReportTechPackFolderID OUTPUT
		
	SELECT @ReportTechPackFolderName = ReportTechPackFolderName FROM dbo.rReportTechPackFolder WITH(NOLOCK)  WHERE ReportTechPackFolderID = @ReportTechPackFolderID
	

	--** Output
	SELECT @SeasonYear AS SeasonYear, @SeasonYearID  AS SeasonYearID, @ReportTechPackFolderName AS ReportTechPackFolderName
END 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06927', GetDate())
GO
