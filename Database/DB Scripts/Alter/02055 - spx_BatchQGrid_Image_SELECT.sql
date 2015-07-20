IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_Image_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_BatchQGrid_Image_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQGrid_Image_SELECT](
	@BatchQueueJobItemId UNIQUEIDENTIFIER
)
AS 

DECLARE @BatchQueueJobTable VARCHAR(200)
SELECT @BatchQueueJobTable = BatchQueueJobTable FROM pBatchQueueJobItem WHERE BatchQueueJobItemID = @BatchQueueJobItemId 

BEGIN	
	DECLARE @SQLString NVARCHAR(MAX)
	SET @SQLString = 'SELECT * FROM (SELECT ImageID, Version, ImageTypeID, ImageSubFolder1  FROM pImage) AS SqlBatchQ WHERE EXISTS (SELECT ImageID FROM ' +  @BatchQueueJobTable + ' WHERE ImageID = SqlBatchQ.ImageID)'	
END	
	
BEGIN						
	EXEC (@SQLString) 					
END

go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02055'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02055', GetDate())
END	
GO