/****** Object:  StoredProcedure [dbo].[spx_LineList_BurnData_SELECT]    Script Date: 16.03.2015 18:07:30 ******/
IF OBJECT_ID(N'[dbo].[spx_LineList_BurnData_SELECT]') IS NOT NULL
DROP PROCEDURE [dbo].[spx_LineList_BurnData_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineList_BurnData_SELECT]    Script Date: 16.03.2015 18:07:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineList_BurnData_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT pLineFolderItem.LineFolderItemID, pLineFolderItem.LineFolderID, pLineFolderItem.StyleID, 
		pStyleHeader.StyleNo, pStyleHeader.DesignSketchID, pStyleHeader.DesignSketchVersion
	FROM pStyleHeader 
	INNER JOIN pLineFolderItem ON pStyleHeader.StyleID = pLineFolderItem.StyleID
	WHERE pLineFolderItem.LineFolderID = @LineFolderID
	ORDER BY pLineFolderItem.LineFolderItemSort 
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10025', GetUTCDate())
GO
