
Create PROCEDURE [dbo].[spx_QuickBatchReplace_SELECT] (
@TeamID UNIQUEIDENTIFIER,
@Filter NVARCHAR(4000),
@Sort NVARCHAR(4000)
)
AS 


SELECT * INTO #tmp FROM  pQuickBatchReplaceType
WHERE QuickBRTypeID  in ( 
	SELECT DISTINCT QuickBRTypeID  FROM  dbo.sAccessGroupQuickBatchReplaceFolder
	WHERE (AccessRoleID = 3 OR AccessView = 1  )
	AND GroupID IN (
		SELECT GroupID FROM dbo.uUserGroup WHERE TeamID = @TeamID
	)
)


DECLARE @SQL NVARCHAR(4000) 
SET @SQL  = 'SELECT  * FROM  #tmp '

IF LEN (@Filter)  >  0 
	SET @SQL  = @SQL   + ' WHERE ' + @Filter

IF LEN (@Sort)  >  0 
	SET @SQL  = @SQL   + ' ORDER BY ' + @Sort


EXEC ( @SQL) 

DROP TABLE #tmp 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '151', GetDate())
GO
