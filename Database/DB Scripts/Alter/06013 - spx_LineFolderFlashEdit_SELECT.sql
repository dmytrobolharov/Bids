/****** Object:  StoredProcedure [dbo].[spx_LineFolderFlashEdit_SELECT]    Script Date: 07/10/2013 10:20:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderFlashEdit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderFlashEdit_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderFlashEdit_SELECT]    Script Date: 07/10/2013 10:20:31 ******/
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
FROM pLineFolderFlashEdit flash INNER JOIN sAccessLineFolderPalette access
ON access.LinePaletteID = flash.LineFolderFlashEditId AND access.TeamID = @TeamID AND access.LineTypeID = @LineListTypeID
WHERE LineFolderFlashEditActive = @LineFolderFlashEditActive AND (access.AccessView = 1 OR access.AccessRoleId = 3)
ORDER BY LineFolderFlashEditSort ASC
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06013', GetDate())
GO
