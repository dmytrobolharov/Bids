/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_TechPack_CreateZip_Review_SELECT]    Script Date: 26.02.2015 14:29:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_TechPack_CreateZip_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_TechPack_CreateZip_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_TechPack_CreateZip_Review_SELECT]    Script Date: 26.02.2015 14:29:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQGrid_TechPack_CreateZip_Review_SELECT](
	@BatchQueuePagePkName nvarchar(200),
	@BatchQueuePageID uniqueidentifier,
	@BatchQueueJobId uniqueidentifier,
	@BatchQueueJobItemId uniqueidentifier,
	@BatchQueueJobTable nvarchar(400),
	@BatchQueueId uniqueidentifier,
	@BatchQueueGridSql nvarchar(MAX),
	@CUser NVarChar(200),
	@CDate DATETIME
)
AS 
BEGIN

	SELECT tps.* FROM vwx_BatchQ_TechPackStyle_SEL tps
	INNER JOIN pBatchQueueJobItemRecord rec ON tps.StyleID = rec.BatchQueuePagePki
	INNER JOIN pBatchQueueJobItem job ON job.BatchQueueJobItemID = rec.BatchQueueJobItemID
	INNER JOIN pBatchQueuePage jobpage ON jobpage.BatchQueuePageID = job.BatchQueuePageID AND jobpage.BatchQueuePageOrder = '0001'
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09753', GetDate())
GO
