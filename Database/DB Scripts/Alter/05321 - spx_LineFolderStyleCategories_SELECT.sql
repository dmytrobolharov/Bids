/****** Object:  StoredProcedure [dbo].[spx_LineFolderStyleCategories_SELECT]    Script Date: 03/16/2013 15:51:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderStyleCategories_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderStyleCategories_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_LineFolderStyleCategories_SELECT]    Script Date: 03/16/2013 15:51:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolderStyleCategories_SELECT]
	@LineFolderID UNIQUEIDENTIFIER,
	@SelectedStyleTypes VARCHAR(MAX) = ''
AS
BEGIN
	
	SELECT sc.StyleCategoryID, sc.StyleCategory,
	IsChecked = CASE
	WHEN lfsc.StyleCategoryID IS NULL THEN 'FALSE'
	ELSE 'TRUE'
	END,
	IsEnabled = CASE
	WHEN EXISTS(SELECT * FROM pLineFolderItem lfi INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID 
				WHERE sh.StyleCategory = sc.StyleCategoryID AND lfi.LineFolderID = @LineFolderID) 
	THEN 'FALSE' ELSE 'TRUE' 
	END
    FROM pStyleCategory sc INNER JOIN pStyleCategoryStyleType scst ON sc.StyleCategoryId = scst.StyleCategoryID
	LEFT JOIN pLineFolderStyleCategory lfsc ON lfsc.StyleCategoryID = sc.StyleCategoryId AND lfsc.LineFolderID = @LineFolderID
    WHERE scst.StyleTypeID IN (SELECT LTRIM(RTRIM(value)) FROM dbo.fnx_Split(@SelectedStyleTypes, ','))
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05321', GetDate())
GO
