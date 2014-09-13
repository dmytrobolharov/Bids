/****** Object:  StoredProcedure [dbo].[spx_BatchQueue_INSERT]    Script Date: 06/07/2010 08:46:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_BatchQueue_INSERT]
(
	@TeamID uniqueidentifier,
	@BatchQueueTypeID uniqueidentifier,
	@ItemID uniqueidentifier,
	@ItemDescription NVarChar(200),
	@BatchQueueXMLData Text,
	@BatchQueueStatusID uniqueidentifier,
	@BatchQueueComments NVarChar(200), 
	@CUser NVarChar(25),
	@CDate datetime
)
AS 

INSERT INTO bBatchQueue  (TeamID, BatchQueueTypeID, ItemID, ItemDescription, BatchQueueXMLData, BatchQueueStatusID, BatchQueueComments, CUser, CDate) 
                 VALUES  (@TeamID, @BatchQueueTypeID, @ItemID, @ItemDescription, @BatchQueueXMLData, @BatchQueueStatusID, @BatchQueueComments, @CUser, @CDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '145', GetDate())
GO
