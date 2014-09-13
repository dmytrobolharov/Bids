IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialGroupWhere_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_MaterialGroupWhere_SEL]
GO


CREATE VIEW dbo.vwx_MaterialGroupWhere_SEL  
AS

	SELECT  a.StyleID, a.StyleSeasonYearID , a.StyleSeason, a.StyleYear, FOO.MaterialCoreID,
	b.StyleNo, b.Description, b.CustomField14, b.MaterialName, b.SizeRange,
	b.SizeClass,b.CustomField15, b.CustomField4, a.StyleSeason AS Season,
	a.StyleYear AS Year
	FROM ( 	

		SELECT  StyleID, a.MaterialCoreID
		FROM dbo.pMaterialCoreItem a
			INNER JOIN dbo.pStyleMaterials b ON a.MaterialCoreItemID =  b.MaterialCoreItemID
	UNION 
		SELECT  b.StyleID, a.MaterialCoreID
		FROM dbo.pMaterialCoreItem a
			INNER JOIN dbo.pStyleMaterials b ON b.StyleMaterialLinkID = a.MaterialCoreItemID 
	) AS FOO 
		INNER JOIN pStyleHeader b On foo.StyleID = b.StyleID
		INNER JOIN pStyleSeasonYear a ON a.StyleID = b.StyleID
	
	
	
GO