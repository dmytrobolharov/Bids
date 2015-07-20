/****** Object:  View [dbo].[vwx_StyleCategory_SEL]    Script Date: 11/05/2014 15:03:01 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleCategory_SEL]'))
DROP VIEW [dbo].[vwx_StyleCategory_SEL]
GO

/****** Object:  View [dbo].[vwx_StyleCategory_SEL]    Script Date: 11/05/2014 15:03:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_StyleCategory_SEL]
AS
SELECT     dbo.pStyleCategory.*, STUFF
                          ((SELECT     ', ' + pStyleType.StyleTypeDescription
                              FROM         pStyleCategoryStyleType LEFT JOIN
                                                    pStyleType ON pStyleCategoryStyleType.StyleTypeID = pStyleType.StyleTypeID
                              WHERE   pStyleType.Active = 1 and  pStyleCategoryStyleType.StyleCategoryID = pStyleCategory.StyleCategoryId FOR XML PATH('')), 1, 2, '') AS StyleTypes
FROM         dbo.pStyleCategory

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09169', GetDate())
GO
