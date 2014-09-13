/****** Object:  StoredProcedure [dbo].[spx_LineFolderStyleTypes_SELECT]    Script Date: 03/18/2013 14:08:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderStyleTypes_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderStyleTypes_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderStyleTypes_SELECT]    Script Date: 03/18/2013 14:08:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolderStyleTypes_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @LineFolderDivisionID UNIQUEIDENTIFIER
	SELECT @LineFolderDivisionID = LineFolderDivisionID FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
	SELECT DISTINCT dst.StyleTypeID, StyleTypeDescription, 
	IsChecked = CASE 
	WHEN lfst.StyleTypeID IS NULL 
	THEN 'FALSE' ELSE 'TRUE' 
	END,
	IsEnabled = CASE
	WHEN EXISTS(SELECT * FROM pLineFolderItem lfi INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID 
				WHERE sh.StyleType = dst.StyleTypeID AND lfi.LineFolderID = @LineFolderID) 
	THEN 'FALSE' ELSE 'TRUE' 
	END
	FROM pStyleType st
	INNER JOIN pDivisionStyleType dst ON dst.StyleTypeID = st.StyleTypeID
	LEFT JOIN pLineFolderStyleType lfst ON lfst.StyleTypeID = dst.StyleTypeID AND lfst.LineFolderID = @LineFolderID
	WHERE DivisionID = @LineFolderDivisionID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05327', GetDate())
GO
