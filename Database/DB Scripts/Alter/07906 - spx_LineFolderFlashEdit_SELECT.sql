/****** Object:  StoredProcedure [dbo].[spx_LineFolderFlashEdit_SELECT]    Script Date: 06/05/2014 14:27:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderFlashEdit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderFlashEdit_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderFlashEdit_SELECT]    Script Date: 06/05/2014 14:27:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LineFolderFlashEdit_SELECT]
(
@LineFolderID UNIQUEIDENTIFIER,
@LineFolderFlashEditActive INT,
@TeamID UNIQUEIDENTIFIER
)
AS 

DECLARE @LineListTypeID UNIQUEIDENTIFIER
SELECT @LineListTypeID = LineListTypeID FROM pLineFolder WHERE LineFolderID = @LineFolderID

SELECT LineFolderFlashEditId, LineFolderFlashEditTableName, LineFolderFlashEditTablePKI, LineFolderFlashEditFormName, LineFolderFlashEditDescription, 
  LineFolderFlashEditSort, LineFolderFlashEditURL, LineFolderFlashEditXML, LineFolderFlashEditSearchXML, LineFolderFlashEditBatchXML, 
  LineFolderFlashEditBatchGridXML, LineFolderFlashEditActive,flash.CUser, flash.CDate, flash.MUser, flash.MDate
FROM pLineFolderFlashEdit flash INNER JOIN fnx_Permissions_GetGuidProductType_WorkflowPermissions(@TeamID, 3, @LineListTypeID) access
ON access.WorkflowId = flash.LineFolderFlashEditId 
WHERE LineFolderFlashEditActive = @LineFolderFlashEditActive AND (access.PermissionView = 1 OR access.PermissionRoleId = 3)
ORDER BY LineFolderFlashEditSort ASC

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07906', GetDate())
GO
