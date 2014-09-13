
/****** Object:  StoredProcedure [dbo].[spx_FlashEditFolderItem_SELECT]    Script Date: 03/21/2013 12:47:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_FlashEditFolderItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_FlashEditFolderItem_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_FlashEditFolderItem_SELECT]    Script Date: 03/21/2013 12:47:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_FlashEditFolderItem_SELECT] (
@TeamID UNIQUEIDENTIFIER,
@Filter NVARCHAR(4000),
@Sort NVARCHAR(4000)
)
AS 


SELECT * INTO #tmp FROM  pFlashEditFolderItem
WHERE Active=1 and FlashEditFolderItemID  in ( 
	SELECT DISTINCT FlashEditFolderItemId  FROM  dbo.sAccessGroupFlashEditFolder
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
VALUES ('DB_Version', '0.5.0000', '05380', GetDate())
GO
