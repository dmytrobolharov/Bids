
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[spx_BatchQueueMaterialFindReplace_UPDATE]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE spx_BatchQueueMaterialFindReplace_UPDATE
END
GO

CREATE PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplace_UPDATE]
( 
	@BatchQueueTypeID uniqueidentifier, 
	@BatchQueueMaterialReplaceID uniqueidentifier,
	@SeasonYearID uniqueidentifier,
	@MaterialID uniqueidentifier, 
	@MaterialFindReplace varchar(1), 
	@TeamID uniqueidentifier,
	@CreatedBy NVarChar(200),
	@CreatedDate datetime
) 
AS

--Create record a batch queue
IF (SELECT COUNT(*) FROM bBatchQueueMaterialReplace WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID) = 0
BEGIN
	INSERT INTO bBatchQueueMaterialReplace(BatchQueueMaterialReplaceID, BatchQueueTypeID, SeasonYearID, CUser, CDate, TeamID)
	VALUES (@BatchQueueMaterialReplaceID, @BatchQueueTypeID, @SeasonYearID, @CreatedBy, @CreatedDate, @TeamID)
END


IF @MaterialFindReplace = 'F'
BEGIN
	UPDATE bBatchQueueMaterialReplace SET
		MaterialFindID = @MaterialID, 
		MUser = @CreatedBy, 
		MDate = @CreatedDate  
	WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID

END
ELSE IF @MaterialFindReplace = 'R'
BEGIN
	UPDATE bBatchQueueMaterialReplace SET
		MaterialReplaceID = @MaterialID, 
		MUser = @CreatedBy , 
		MDate = @CreatedDate  
	WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01011', GetDate())
GO
