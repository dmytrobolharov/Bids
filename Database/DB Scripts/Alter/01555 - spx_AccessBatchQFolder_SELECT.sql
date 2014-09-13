IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_AccessBatchQFolder_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_AccessBatchQFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_AccessBatchQFolder_SELECT] (     
@GroupID uniqueidentifier    
)    
AS     
    
    
SELECT *    
FROM  sAccessBatchQFolder    
WHERE sAccessBatchQFolder.GroupID = @GroupID    
ORDER BY sAccessBatchQFolder.BatchQTypeDesc  

GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01555'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01555', GetDate())
END	

GO

