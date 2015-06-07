/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_Image_SELECT]    Script Date: 2/13/2015 4:36:14 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_Image_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_Image_SELECT]    Script Date: 2/13/2015 4:36:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQGrid_Image_SELECT](
	@BatchQueueJobItemId UNIQUEIDENTIFIER
)
AS 

DECLARE @BatchQueueJobTable nVARCHAR(200)
SELECT @BatchQueueJobTable = BatchQueueJobTable FROM pBatchQueueJobItem WHERE BatchQueueJobItemID = @BatchQueueJobItemId 

BEGIN	
	DECLARE @SQLString NVARCHAR(MAX)
	SET @SQLString = 'SELECT * FROM (SELECT ImageID, Version, ImageTypeID, ImageSubFolder1  FROM pImage) AS SqlBatchQ WHERE EXISTS (SELECT BatchQueuePagePki FROM pBatchQueueJobItemRecord WHERE BatchQueuePagePki = SqlBatchQ.ImageID AND BatchQueueJobItemId = ''' + CAST(@BatchQueueJobItemID AS NVARCHAR(50)) + ''')'	
END	
	
BEGIN						
	EXEC (@SQLString) 					
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09727', GetDate())
GO
