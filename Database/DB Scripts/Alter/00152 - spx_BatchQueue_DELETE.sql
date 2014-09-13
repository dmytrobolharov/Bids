/****** Object:  StoredProcedure [dbo].[spx_BatchQueue_DELETE]    Script Date: 06/07/2010 08:46:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_BatchQueue_DELETE]
(
	@BatchQueueID uniqueidentifier
)
AS 

DELETE FROM bBatchQueue
WHERE BatchQueueID = @BatchQueueID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '152', GetDate())
GO
