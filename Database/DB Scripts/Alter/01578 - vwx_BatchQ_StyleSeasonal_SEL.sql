IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleSeasonal_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_StyleSeasonal_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleSeasonal_SEL]
AS
SELECT DISTINCT 
                      TOP (100) PERCENT dbo.pStyleHeader.StyleID, dbo.pStyleSeasonYear.SeasonYearID, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.Description, 
                      dbo.pStyleHeader.StyleCategory, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.MaterialNo, dbo.pStyleHeader.MaterialName, 
                      dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField4, dbo.pStyleHeader.CustomField5,
                       dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField8, dbo.pStyleHeader.CustomField15, 
                      dbo.pStyleHeader.CustomField14, dbo.pStyleHeader.CustomField13, dbo.pStyleHeader.CustomField12, dbo.pStyleHeader.CustomField11, 
                      dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.CustomField9, dbo.pStyleHeader.CustomField16, dbo.pStyleHeader.CustomField30, 
                      dbo.pStyleHeader.CustomField29, dbo.pStyleHeader.CustomField28, dbo.pStyleHeader.CustomField27, dbo.pStyleHeader.CustomField26, 
                      dbo.pStyleHeader.CustomField25, dbo.pStyleHeader.CustomField24, dbo.pStyleHeader.CustomField23, dbo.pStyleHeader.CustomField22, 
                      dbo.pStyleHeader.CustomField21, dbo.pStyleHeader.CustomField20, dbo.pStyleHeader.CustomField19, dbo.pStyleHeader.CustomField18, 
                      dbo.pStyleHeader.CustomField17, dbo.pStyleHeader.CustomField31, dbo.pStyleHeader.CustomField32, dbo.pStyleHeader.CustomField33, 
                      dbo.pStyleHeader.CustomField34, dbo.pStyleHeader.CustomField35, dbo.pStyleHeader.CustomField36, dbo.pStyleHeader.CustomField37, 
                      dbo.pStyleHeader.CustomField38, dbo.pStyleHeader.CustomField39, dbo.pStyleHeader.CustomField40
FROM         dbo.pStyleHeader INNER JOIN
                      dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID INNER JOIN
                      dbo.pStyleColorwaySeasonYear ON dbo.pStyleSeasonYear.StyleSeasonYearID = dbo.pStyleColorwaySeasonYear.StyleSeasonYearID INNER JOIN
                      dbo.pStyleColorway ON dbo.pStyleColorwaySeasonYear.StyleColorwayID = dbo.pStyleColorway.StyleColorID
WHERE     (dbo.pStyleColorwaySeasonYear.StyleColorStatus = 0) OR
                      (dbo.pStyleColorwaySeasonYear.StyleColorStatus = 100)
ORDER BY dbo.pStyleHeader.StyleNo
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01578'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01578', GetDate())
END	

GO
