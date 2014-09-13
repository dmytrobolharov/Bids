IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleMaterialSeasonal_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal_SEL]
AS
SELECT DISTINCT 
	  TOP (100) PERCENT pStyleHeader.StyleID, pStyleSeasonYear.SeasonYearID, pStyleHeader.StyleNo, pStyleHeader.Description, 
	  pStyleHeader.StyleCategory, pStyleHeader.SizeClass, pStyleHeader.SizeRange, pStyleHeader.MaterialNo, pStyleHeader.MaterialName, 
	  pStyleHeader.CustomField1, pStyleHeader.CustomField2, pStyleHeader.CustomField3, pStyleHeader.CustomField4, pStyleHeader.CustomField5,
	  pStyleHeader.CustomField6, pStyleHeader.CustomField7, pStyleHeader.CustomField8, pStyleHeader.CustomField15, 
	  pStyleHeader.CustomField14, pStyleHeader.CustomField13, pStyleHeader.CustomField12, pStyleHeader.CustomField11, 
	  pStyleHeader.CustomField10, pStyleHeader.CustomField9, pStyleHeader.CustomField16, pStyleHeader.CustomField30, 
	  pStyleHeader.CustomField29, pStyleHeader.CustomField28, pStyleHeader.CustomField27, pStyleHeader.CustomField26, 
	  pStyleHeader.CustomField25, pStyleHeader.CustomField24, pStyleHeader.CustomField23, pStyleHeader.CustomField22, 
	  pStyleHeader.CustomField21, pStyleHeader.CustomField20, pStyleHeader.CustomField19, pStyleHeader.CustomField18, 
	  pStyleHeader.CustomField17, pStyleHeader.CustomField31, pStyleHeader.CustomField32, pStyleHeader.CustomField33, 
	  pStyleHeader.CustomField34, pStyleHeader.CustomField35, pStyleHeader.CustomField36, pStyleHeader.CustomField37, 
	  pStyleHeader.CustomField38, pStyleHeader.CustomField39, pStyleHeader.CustomField40, pStyleMaterials.StyleMaterialID, 
	  pStyleMaterials.MaterialID
	FROM pStyleHeader INNER JOIN
	  pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID INNER JOIN
	  pStyleColorwaySeasonYear ON pStyleSeasonYear.StyleSeasonYearID = pStyleColorwaySeasonYear.StyleSeasonYearID INNER JOIN
	  pStyleColorway ON pStyleColorwaySeasonYear.StyleColorwayID = pStyleColorway.StyleColorID INNER JOIN
	  pStyleMaterials ON pStyleHeader.StyleID = pStyleMaterials.StyleID
	WHERE (pStyleColorwaySeasonYear.StyleColorStatus = 0) OR (pStyleColorwaySeasonYear.StyleColorStatus = 100)
ORDER BY pStyleHeader.StyleNo
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01572'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01572', GetDate())
END	

GO
