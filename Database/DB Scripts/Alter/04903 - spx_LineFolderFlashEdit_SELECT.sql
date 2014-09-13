/****** Object:  StoredProcedure [dbo].[spx_LineFolderFlashEdit_SELECT]    Script Date: 01/28/2013 12:55:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderFlashEdit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderFlashEdit_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderFlashEdit_SELECT]    Script Date: 01/28/2013 12:55:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LineFolderFlashEdit_SELECT]
(
@LineFolderFlashEditActive int
)
AS 

SELECT LineFolderFlashEditId, LineFolderFlashEditTableName, LineFolderFlashEditTablePKI, LineFolderFlashEditFormName, LineFolderFlashEditDescription, 
  LineFolderFlashEditSort, LineFolderFlashEditURL, LineFolderFlashEditXML, LineFolderFlashEditSearchXML, LineFolderFlashEditBatchXML, 
  LineFolderFlashEditBatchGridXML, LineFolderFlashEditActive, CUser, CDate, MUser, MDate
FROM pLineFolderFlashEdit
WHERE LineFolderFlashEditActive = @LineFolderFlashEditActive
ORDER BY LineFolderFlashEditSort ASC

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04903', GetDate())
GO
