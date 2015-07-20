/****** Object:  View [dbo].[vwx_Division_StyleType_StyleCategory_SELECT]    Script Date: 03/19/2013 14:21:28 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Division_StyleType_StyleCategory_SELECT]'))
DROP VIEW [dbo].[vwx_Division_StyleType_StyleCategory_SELECT]
GO

/****** Object:  View [dbo].[vwx_Division_StyleType_StyleCategory_SELECT]    Script Date: 03/19/2013 14:21:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Division_StyleType_StyleCategory_SELECT]
AS
SELECT d.CustomID AS DivisionID, d.Custom AS DivisionName, 
		NULL AS StyleTypeID, NULL AS StyleTypeDescription, 
		NULL AS StyleCategoryID, NULL AS StyleCategory,
		1 AS AttributeLevel
FROM iCustom1 d
UNION
SELECT d.CustomID AS DivisionID, d.Custom AS DivisionName, 
		st.StyleTypeID AS StyleTypeID, st.StyleTypeDescription AS StyleTypeDescription, 
		NULL AS StyleCategoryID, NULL AS StyleCategory,
		2 AS AttributeLevel
FROM iCustom1 d
INNER JOIN pDivisionStyleType dst ON d.CustomID = dst.DivisionID
INNER JOIN pStyleType st ON st.StyleTypeID = dst.StyleTypeID
UNION
SELECT d.CustomID AS DivisionID, d.Custom AS DivisionName, 
		st.StyleTypeID AS StyleTypeID, st.StyleTypeDescription AS StyleTypeDescription, 
		sc.StyleCategoryId AS StyleCategoryID, sc.StyleCategory AS StyleCategory,
		3 AS AttributeLevel
FROM iCustom1 d
INNER JOIN pDivisionStyleType dst ON d.CustomID = dst.DivisionID
INNER JOIN pStyleType st ON st.StyleTypeID = dst.StyleTypeID
INNER JOIN pStyleCategoryStyleType scst ON scst.StyleTypeID = st.StyleTypeID
INNER JOIN pStyleCategory sc ON scst.StyleCategoryID = sc.StyleCategoryId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05347', GetDate())
GO
