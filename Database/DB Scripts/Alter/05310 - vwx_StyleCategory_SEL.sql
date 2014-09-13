IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleCategory_SEL]'))
DROP VIEW [dbo].[vwx_StyleCategory_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_StyleCategory_SEL]
AS
SELECT     dbo.pStyleCategory.*, 
	STUFF(
		(SELECT ', ' + pStyleType.StyleTypeDescription
		FROM pStyleCategoryStyleType LEFT JOIN pStyleType ON pStyleCategoryStyleType.StyleTypeID = pStyleType.StyleTypeID
		WHERE pStyleCategoryStyleType.StyleCategoryID = pStyleCategory.StyleCategoryId
		FOR XML PATH('')), 1, 2, '') AS StyleTypes
FROM         dbo.pStyleCategory

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05310', GetDate())
GO
