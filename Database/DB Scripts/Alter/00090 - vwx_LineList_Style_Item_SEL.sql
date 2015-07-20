
/****** Object:  View [dbo].[vwx_LineList_Style_Item_SEL]    Script Date: 05/03/2010 21:56:07 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineList_Style_Item_SEL]'))
DROP VIEW [dbo].[vwx_LineList_Style_Item_SEL]
GO



/*
Comments:

General - Ryan Cabanas - April 6, 2010
	View to select (schema) fields to show below a style when searching to add styles to a line list.
*/

CREATE VIEW [dbo].[vwx_LineList_Style_Item_SEL]
AS
SELECT
	pStyleHeader.*
	,pStyleSeasonYear.StyleSeason
	,pStyleSeasonYear.StyleYear
	,ISNULL(pStyleDevelopmentItem.StyleDevelopmentName, pStyleDevelopmentItem.Variation) AS Variation
FROM pStyleHeader
	INNER JOIN dbo.pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID
	INNER JOIN pStyleDevelopmentItem ON pStyleHeader.DevelopmentID = pStyleDevelopmentItem.StyleDevelopmentID
										AND pStyleHeader.StyleID = pStyleDevelopmentItem.StyleID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '090', GetDate())
GO
