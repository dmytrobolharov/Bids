/****** Object:  StoredProcedure [dbo].[spx_BatchQ_StyleColor_SELECT]    Script Date: 23.02.2015 17:49:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQ_StyleColor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQ_StyleColor_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQ_StyleColor_SELECT]    Script Date: 23.02.2015 17:49:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


	
CREATE PROCEDURE [dbo].[spx_BatchQ_StyleColor_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER
)
AS 

BEGIN

	SELECT color.ColorPaletteID, color.ColorCode, color.ColorName as ColorHeader
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	INNER JOIN pColorPalette color ON color.ColorPaletteID =  rec.BatchQueuePagePki 
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 3

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09721', GetDate())
GO
