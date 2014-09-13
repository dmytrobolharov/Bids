

/****** Object:  StoredProcedure [dbo].[spx_BatchQueueMaterialFindReplaceStyle_INSERT]    Script Date: 01/16/2011 11:38:11 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[spx_BatchQueueMaterialFindReplaceStyle_INSERT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplaceStyle_INSERT]

GO


CREATE PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplaceStyle_INSERT]
( 
	@BatchQueueMaterialReplaceID uniqueidentifier,
	@StyleID uniqueidentifier, 
	@SeasonYearID uniqueidentifier,
	@CreatedBy NVarChar(200),
	@CreatedDate datetime
) 
AS

IF (SELECT COUNT(*) FROM bBatchQueueMaterialReplaceStyle WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID AND StyleID = @StyleID) = 0
	BEGIN
		INSERT INTO bBatchQueueMaterialReplaceStyle(BatchQueueMaterialReplaceID, StyleID, SeasonYearID, CUser, CDate)
		VALUES (@BatchQueueMaterialReplaceID, @StyleID, @SeasonYearID, @CreatedBy, @CreatedDate)
	END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01014', GetDate())
GO


