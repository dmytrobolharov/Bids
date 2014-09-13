IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleMaterialSeasonal]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal]
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal]
AS 

SELECT a.MaterialID , b.StyleID, c.SeasonYearID, b.StyleNo, b.Description, b.SizeClass, b.SizeRange
FROM dbo.pMaterial a
	CROSS JOIN dbo.pStyleHeader b
	CROSS JOIN dbo.pSeasonYear c
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01583'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01583', GetDate())
END	

GO
