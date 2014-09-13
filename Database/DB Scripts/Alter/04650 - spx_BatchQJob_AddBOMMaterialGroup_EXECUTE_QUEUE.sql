
/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_AddBOMMaterialGroup_EXECUTE_QUEUE]    Script Date: 12/18/2012 14:00:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQJob_AddBOMMaterialGroup_EXECUTE_QUEUE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQJob_AddBOMMaterialGroup_EXECUTE_QUEUE]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQJob_AddBOMMaterialGroup_EXECUTE_QUEUE]    Script Date: 12/18/2012 14:00:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_BatchQJob_AddBOMMaterialGroup_EXECUTE_QUEUE](
	@BatchQueueJobID  UNIQUEIDENTIFIER,
	@MDate DATETIME
)
AS
	
DECLARE 	
	@BatchQueueJobTable	NVARCHAR(200),
	@BatchQueueJobTable2	NVARCHAR(200),
	@SQL NVARCHAR(MAX),
	@ParmDefinition NVARCHAR(200),
	@OldMaterialID  UNIQUEIDENTIFIER,
	@TOTAL INT, 
	@ROWID INT, 
	@tmpStyleMaterialID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@WorkflowItemID UNIQUEIDENTIFIER,
	@WorkflowID UNIQUEIDENTIFIER,
	@tmpMaterialID UNIQUEIDENTIFIER,
	@tmpStyleBOMDimensionID UNIQUEIDENTIFIER,
	@StyleMaterialToReplaceID UNIQUEIDENTIFIER ,
	@MUser NVARCHAR(200),
	@NewMaterialID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
	
	
SELECT @TeamID = BatchQueueJobTeamID FROM pBatchQueueJob WHERE BatchQueueJobID = @BatchQueueJobID


SELECT @MUser = ISNULL(b.FirstName,'') + ' ' + ISNULL(b.LastName,'')
FROM dbo.pBatchQueueJob a WITH(NOLOCK)
	INNER JOIN dbo.Users b ON a.BatchQueueJobTeamID =  b.TeamID
WHERE BatchQueueJobID = @BatchQueueJobID



--** Material and dimension table for insert

CREATE TABLE #mitt(
	ROWID INT IDENTITY(1,1),
	MaterialID UNIQUEIDENTIFIER,
	StyleBOMDimensionID UNIQUEIDENTIFIER
	
)

SELECT @BatchQueueJobTable = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 3

SELECT @BatchQueueJobTable2 = BatchQueueJobTable  
FROM pBatchQueueJobItem WITH(NOLOCK)
WHERE BatchQueueJobId = @BatchQueueJobId
	AND BatchQueueJobSeq = 4
	
	
	--SELECT * FROM (SELECT DISTINCT MaterialCoreItemID, MaterialID, MaterialNo, MaterialName, MaterialCode, MaterialType FROM ) AS SqlBatchQ  WHERE EXISTS (SELECT * FROM __525CD0C760B0409EABC56DD2FD40AA88_93FD6F413F48E211A6D354E4F30B820C WHERE MaterialCoreItemID = SqlBatchQ.MaterialCoreItemID) 
	
	SET @SQL = 'INSERT INTO #mitt ( MaterialID, StyleBOMDimensionID) 
	 SELECT DISTINCT b.MaterialID, a.StyleBOMDimensionID FROM ' + @BatchQueueJobTable2 + ' a,  vwx_BatchQ_MaterialCoreItem_SEL b'+
	 ' WHERE EXISTS (SELECT * FROM '+ @BatchQueueJobTable + ' WHERE MaterialCoreItemID = b.MaterialCoreItemID) '
		
EXECUTE	sp_executesql @SQL

-- insert material to Dimension BOM

SELECT @TOTAL = COUNT(*) FROM #mitt
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL
BEGIN 

SELECT @tmpMaterialID = MaterialID,
 @tmpStyleBOMDimensionID = StyleBOMDimensionID
 FROM #mitt
 WHERE ROWID = @ROWID

 SELECT @WorkflowItemID = wi.WorkFlowItemID, @WorkflowID = wi.WorkflowID,
 @StyleID = wi.StyleID
 FROM pStyleBOMDimension bomdim
 INNER JOIN pWorkFlowItem wi ON wi.WorkFlowItemID = bomdim.WorkFlowItemID
 WHERE bomdim.StyleBOMDimensionID = @tmpStyleBOMDimensionID

set @tmpStyleMaterialID = NEWID()
 EXEC spx_StyleBOMTemp_INSERT
 @MainMaterial = 0, 
 @StyleID = @StyleID, 
 @StyleMaterialID = @tmpStyleMaterialID, 
 @StyleSet = 1, 
 @MaterialID = @tmpMaterialID, 
 @CreatedBy = @MUser, 
 @CreatedDate = @MDate,
 @TradePartnerVendorID = NULL,
 @StyleBOMDimensionID = @tmpStyleBOMDimensionID,
 @WorkflowID = @WorkflowID,
 @WorkflowItemID = @WorkflowItemID

 


 EXECUTE spx_StyleBOMPending_INSERT
 @StyleMaterialID = @tmpStyleMaterialID, 
 @StyleID = @StyleID, 
 @StyleSet = 1, 
 @CreatedDate = @MDate, 
 @CreatedBy = @MUser,
 @WorkflowItemID = @WorkflowItemID,
 @WorkflowID = @WorkflowID,
 @StyleBOMDimensionID = @tmpStyleBOMDimensionID

 SET @ROWID = @ROWID + 1

END 





DROP TABLE #mitt


UPDATE pBatchQueueJob SET BatchQueueJobStatusID = '20000000-0000-0000-0000-000000000000'
WHERE BatchQueueJobID = @BatchQueueJobID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04650', GetDate())
GO
