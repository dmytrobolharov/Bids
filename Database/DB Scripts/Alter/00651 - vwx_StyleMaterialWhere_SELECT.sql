
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleMaterialWhere_SELECT]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_StyleMaterialWhere_SELECT]
GO


CREATE VIEW [dbo].[vwx_StyleMaterialWhere_SELECT]
AS 

SELECT a.StyleSeasonYearID, b.StyleNo, b.Description, b.SizeClass, b.SizeRange, a.StyleSeason, a.StyleYear   
FROM pStyleSeasonYear a WITH (NOLOCK)
	INNER JOIN  pStyleHeader b WITH (NOLOCK) ON a.StyleID  = b.StyleID 


GO