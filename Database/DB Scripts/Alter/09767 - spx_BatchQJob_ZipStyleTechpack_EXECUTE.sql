/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_ZipStyleTechpack_EXECUTE]    Script Date: 26.02.2015 14:40:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_ZipStyleTechpack_EXECUTE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_ZipStyleTechpack_EXECUTE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_ZipStyleTechpack_EXECUTE]    Script Date: 26.02.2015 14:40:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_BatchQJob_ZipStyleTechpack_EXECUTE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS
	UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
	WHERE BatchQueueJobID = @BatchQueueJobID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09767', GetDate())
GO
