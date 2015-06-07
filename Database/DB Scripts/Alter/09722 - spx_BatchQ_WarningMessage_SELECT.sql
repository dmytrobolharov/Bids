/****** Object:  StoredProcedure [dbo].[spx_BatchQ_WarningMessage_SELECT]    Script Date: 23.02.2015 15:58:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQ_WarningMessage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQ_WarningMessage_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQ_WarningMessage_SELECT]    Script Date: 23.02.2015 15:58:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQ_WarningMessage_SELECT](
	@BatchQueueJobID UNIQUEIDENTIFIER, 
	@BatchQueuePageTypeID UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@TeamID UNIQUEIDENTIFIER,
	@BatchQueueJobTable NVARCHAR(200),
	@sql NVARCHAR(MAX),
	@Parameters NVARCHAR(200),
	@Count INT 


IF @BatchQueuePageTypeID = 'E1C913C0-7D8C-E011-81E9-005056C00008'
BEGIN

	SELECT @Count = COUNT(*) 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 4
	
	IF @Count > 10
		SELECT 'You have selected more than 10 styles to update, Want to continue?' AS WarningMsg
	ELSE	
		SELECT '' AS WarningMsg		
		
END
ELSE IF @BatchQueuePageTypeID = '44E5E4E3-DD70-E011-9039-8EF3DCCB61B3'
BEGIN
	--** BatchQ 'Mass add materials to Style', Page = 'Select multiple styles'
	SELECT 'You have selected over 50 styles.' AS WarningMsg		

END 
ELSE IF @BatchQueuePageTypeID = '1734DB07-DE70-E011-9039-8EF3DCCB61B6'
BEGIN
	--** Colorways 
	SELECT 'You have selected over 5 colours.' AS WarningMsg		
	
END 
ELSE IF @BatchQueuePageTypeID='d0c913c0-7d8c-e011-81e9-005056c00012'
BEGIN 
	SELECT @Count = COUNT(*) 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 3
	
	IF @Count > 10
		SELECT 'You have selected more than 10 styles to update, Want to continue?' AS WarningMsg
	ELSE	
		SELECT '' AS WarningMsg		

END 




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09722', GetDate())
GO
