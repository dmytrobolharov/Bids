
/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningAttribute_SELECT]    Script Date: 03/22/2013 15:09:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_LinePlanningAttribute_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_LinePlanningAttribute_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_LinePlanningAttribute_SELECT]    Script Date: 03/22/2013 15:09:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LineFolder_LinePlanningAttribute_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT vw.* FROM vwx_Division_StyleType_StyleCategory_SELECT vw
	INNER JOIN pLineFolder lf ON vw.DivisionID = lf.LineFolderDivisionID AND lf.LineFolderID = @LineFolderID
	WHERE (StyleTypeID IS NULL OR StyleTypeID IN (SELECT StyleTypeID FROM pLineFolderStyleType WHERE LineFolderID = @LineFolderID))
	AND (StyleCategoryID IS NULL OR StyleCategoryID IN (SELECT StyleCategoryID FROM pLineFolderStyleCategory WHERE LineFolderID = @LineFolderID))
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05391', GetDate())
GO
