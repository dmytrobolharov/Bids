/****** Object:  StoredProcedure [dbo].[spx_FlashEditFolderItem_SELECT]    Script Date: 06/05/2014 11:52:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_FlashEditFolderItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_FlashEditFolderItem_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_FlashEditFolderItem_SELECT]    Script Date: 06/05/2014 11:52:20 ******/
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

SELECT * INTO #tmp FROM  pFlashEditFolderItem efi
INNER JOIN fnx_Permissions_GetGuidProductTypePermissions('203517C2-2BD4-4ED3-9EF7-AC37DE447321', 15) access ON access.ProductTypeId = efi.FlashEditFolderItemId
WHERE efi.Active =1 and (access.PermissionView = 1 OR access.PermissionRoleId = 3)

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
VALUES ('DB_Version', '0.5.0000', '07905', GetDate())
GO
