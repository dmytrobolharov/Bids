IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleColorway_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_StyleColorway_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_StyleColorway_SEL]
AS
SELECT     StyleColorID, StyleID, StyleColorNo, StyleColorName
FROM         dbo.pStyleColorway

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ChangeLogItem_StyleQuote_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_ChangeLogItem_StyleQuote_SEL]
GO

CREATE VIEW [dbo].[vwx_ChangeLogItem_StyleQuote_SEL]
AS
SELECT     b.ChangeTableID, b.ChangeTablePKID, b.ChangeUserName, b.ChangeDate, a.ChangeLogItemID, a.ChangeTransID, a.ChangeLogID, 
                      a.ChangeFieldName, a.ChangeFieldAlias, a.ChangeBeforeValue, a.ChangeAfterValue, a.ChangeBeforeText, a.ChangeAfterText, a.ChangeSort, 
                      a.Custom_SMat_Name, a.Custom_SMat_Type, a.Custom_SMat_No, c.ChangeTransTablePKID, e.StyleNo, e.Description, f.StyleColorNo, 
                      f.StyleColorName
FROM         dbo.pChangeLogItem AS a INNER JOIN
                      dbo.pChangeLog AS b ON a.ChangeLogID = b.ChangeLogID INNER JOIN
                      dbo.pChangeTransaction AS c ON c.ChangeTransID = a.ChangeTransID INNER JOIN
                      dbo.pStyleQuoteItem AS d WITH (NOLOCK) ON d.StyleQuoteItemID = b.ChangeTablePKID INNER JOIN
                      dbo.pStyleHeader AS e WITH (NOLOCK) ON e.StyleID = d.StyleID INNER JOIN
                      dbo.pStyleColorway AS f WITH (NOLOCK) ON f.StyleColorID = d.StyleColorID
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]
AS
SELECT DISTINCT 
                      TOP (100) PERCENT dbo.pStyleHeader.StyleID, dbo.pStyleSeasonYear.SeasonYearID, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.Description, 
                      dbo.pStyleHeader.StyleCategory, dbo.pStyleCategory.StyleCategory AS 'ProductCategoryName',
                       dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.MaterialNo, dbo.pStyleHeader.MaterialName, 
                      dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField4, dbo.pStyleHeader.CustomField5,
                       dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField8, dbo.pStyleHeader.CustomField15, 
                      dbo.pStyleHeader.CustomField14, dbo.pStyleHeader.CustomField13, dbo.pStyleHeader.CustomField12, dbo.pStyleHeader.CustomField11, 
                      dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.CustomField9, dbo.pStyleHeader.CustomField16, dbo.pStyleHeader.CustomField30, 
                      dbo.pStyleHeader.CustomField29, dbo.pStyleHeader.CustomField28, dbo.pStyleHeader.CustomField27, dbo.pStyleHeader.CustomField26, 
                      dbo.pStyleHeader.CustomField25, dbo.pStyleHeader.CustomField24, dbo.pStyleHeader.CustomField23, dbo.pStyleHeader.CustomField22, 
                      dbo.pStyleHeader.CustomField21, dbo.pStyleHeader.CustomField20, dbo.pStyleHeader.CustomField19, dbo.pStyleHeader.CustomField18, 
                      dbo.pStyleHeader.CustomField17, dbo.pStyleHeader.CustomField31, dbo.pStyleHeader.CustomField32, dbo.pStyleHeader.CustomField33, 
                      dbo.pStyleHeader.CustomField34, dbo.pStyleHeader.CustomField35, dbo.pStyleHeader.CustomField36, dbo.pStyleHeader.CustomField37, 
                      dbo.pStyleHeader.CustomField38, dbo.pStyleHeader.CustomField39, dbo.pStyleHeader.CustomField40, dbo.pStyleHeader.StyleType, 
                      '<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(dbo.pStyleHeader.DesignSketchVersion AS NVARCHAR(5)) 
                      + '&IID=' + CAST(dbo.pStyleHeader.DesignSketchID AS NVARCHAR(40)) + '" \>' AS ImagePath, 
                      '../System/Control/ImageStream.ashx?S=150&V=' + CAST(dbo.pStyleHeader.DesignSketchVersion AS NVARCHAR(5)) 
                      + '&IID=' + CAST(dbo.pStyleHeader.DesignSketchID AS NVARCHAR(40)) AS DataListImagePath,
                          --(SELECT     dbo.pStyleColorway.SAPCODE + ', '
                          --  FROM          dbo.pStyleHeader pSH(NOLOCK) LEFT OUTER JOIN
                          --                         dbo.pStyleColorway(NOLOCK) ON pSH.StyleID = dbo.pStyleColorway.StyleID
                          --  WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) SAPCode,
                          (SELECT     dbo.uTradePartner.TradePartnerName + ', '
                            FROM          dbo.pStyleHeader pSH(NOLOCK) LEFT OUTER JOIN
                                                   dbo.pStyleSourcing(NOLOCK) ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartner(NOLOCK) ON dbo.pStyleSourcing.TradePartnerID = dbo.uTradePartner.TradePartnerID
                            WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) TradePartnerName,
                          (SELECT     dbo.uTradePartnerVendor.VendorName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing(NOLOCK) ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartnerVendor(NOLOCK) ON dbo.pStyleSourcing.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID
                            WHERE      (pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')) VendorName, /*dbo.pStyleColorway.SAPCODE, */ dbo.pSeasonYear.Season, 
                      dbo.pSeasonYear.Year, dbo.pLinePlanStyleAttributeItem.AttributeName
FROM         dbo.pStyleHeader(NOLOCK) INNER JOIN
                      dbo.pStyleSeasonYear(NOLOCK) ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID LEFT OUTER JOIN
                      dbo.pStyleColorwaySeasonYear(NOLOCK) ON dbo.pStyleSeasonYear.StyleSeasonYearID = dbo.pStyleColorwaySeasonYear.StyleSeasonYearID LEFT OUTER JOIN
                      dbo.pStyleCategory(NOLOCK) ON dbo.pStyleCategory.StyleCategoryId = dbo.pStyleHeader.StyleCategory LEFT OUTER JOIN
                      --dbo.pStyleColorway(NOLOCK) ON dbo.pStyleColorwaySeasonyear.StyleColorWayID = dbo.pStyleColorway.StyleColorID INNER JOIN
                      dbo.pSeasonyear(NOLOCK) ON dbo.pStyleSeasonyear.SeasonYearID = dbo.pSeasonyear.SeasonYearID LEFT OUTER JOIN
                      dbo.pLinePlanItem(NOLOCK) ON dbo.pLinePlanItem.LinePlanItemID = pStyleSeasonYear.LinePlanITEMID LEFT OUTER JOIN
                      dbo.pLinePlanStyleAttributeItem(NOLOCK) ON dbo.pLinePlanStyleAttributeItem.LinePlanStyleAttributeItemID = pLinePlanItem.LinePlanStyleAttributeItemID
WHERE     EXISTS
                          (SELECT     StyleID
                            FROM          dbo.pStyleSeasonYear AS pStyleSeasonYear_1
                            GROUP BY StyleID
                            HAVING      (COUNT(*) = 1) AND (StyleID = dbo.pStyleHeader.StyleID))
ORDER BY dbo.pStyleHeader.StyleNo
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]
AS
/* styles with 1 season/year*/ SELECT DISTINCT 
                      a.StyleID, a.StyleNo, a.Description, a.CustomField14, a.MaterialName, a.CustomField2, a.CustomField3, a.CustomField4, a.StyleType, a.SizeClass, a.SizeRange, 
                      /*c.SAPCode, */ d .Season, d .Year, g.AttributeName, a.StyleCategory, e.StyleCategory AS 'ProductCategoryName',
                          (SELECT     dbo.pStyleColorway.SAPCODE + ', '
                            FROM          dbo.pStyleHeader pSH (NOLOCK) LEFT OUTER JOIN
                                                   dbo.pStyleColorway (NOLOCK) ON pSH.StyleID = dbo.pStyleColorway.StyleID 
                            WHERE      (pSH.StyleID = a.StyleID) FOR XML PATH('')) SAPCode,
                          (SELECT     dbo.uTradePartner.TradePartnerName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartner ON dbo.pStyleSourcing.TradePartnerID = dbo.uTradePartner.TradePartnerID
                            WHERE      (pSH.StyleID = a.StyleID) FOR XML PATH('')) AS TradePartnerName,
                          (SELECT     dbo.uTradePartnerVendor.VendorName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartnerVendor ON dbo.pStyleSourcing.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID
                            WHERE      (pSH.StyleID = a.StyleID) FOR XML PATH('')) AS VendorName
FROM         pStyleHeader a INNER JOIN
                      pStyleSeasonYear b ON a.StyleID = b.StyleID INNER JOIN
                      pSeasonYear d ON d .SeasonyearID = b.SeasonYearID LEFT OUTER JOIN
                      /*pStyleColorway c ON c.StyleID = a.StyleID LEFT OUTER JOIN*/ dbo.pLinePlanItem f ON f.LinePlanItemID = b.LinePlanItemID LEFT OUTER JOIN
                      pLinePlanStyleAttributeItem g ON g.LinePlanStyleAttributeItemID = f.LinePlanStyleAttributeItemID LEFT OUTER JOIN
                      dbo.pStyleCategory e ON e.StyleCategoryId = a.StyleCategory
                      WHERE     EXISTS
                          (SELECT     StyleID
                            FROM          dbo.pStyleSeasonYear AS pStyleSeasonYear_1
                            GROUP BY StyleID
                            HAVING      (COUNT(*) = 1) AND (StyleID = a.StyleID))
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01585'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01585', GetDate())
END	

GO


