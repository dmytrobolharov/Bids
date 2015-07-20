/****** Object:  View [dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]    Script Date: 06/18/2012 11:27:23 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]
GO

/****** Object:  View [dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]    Script Date: 06/18/2012 11:27:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleColorwaySeasonal_SEL]
AS
SELECT     a.StyleID, a.StyleNo, a.Description, a.CustomField14, a.MaterialName, a.CustomField2, a.CustomField3, a.CustomField4, a.StyleType, a.SizeClass, a.SizeRange, 
                      d .Season, d .Year, g.AttributeName, a.StyleCategory, e.StyleCategory AS 'ProductCategoryName', b.StyleSeasonyearID, b.SeasonYearID,
                          (SELECT     dbo.uTradePartner.TradePartnerName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartner ON dbo.pStyleSourcing.TradePartnerID = dbo.uTradePartner.TradePartnerID
                            WHERE      (pSH.StyleID = a.StyleID) FOR XML PATH('')) AS TradePartnerName,
                          (SELECT     dbo.uTradePartnerVendor.VendorName + ', '
                            FROM          dbo.pStyleHeader pSH LEFT OUTER JOIN
                                                   dbo.pStyleSourcing ON pSH.StyleID = dbo.pStyleSourcing.StyleID LEFT OUTER JOIN
                                                   dbo.uTradePartnerVendor ON dbo.pStyleSourcing.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID
                            WHERE      (pSH.StyleID = a.StyleID) FOR XML PATH('')) AS VendorName,
 '<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(dbo.pStyleHeader.DesignSketchVersion AS NVARCHAR(5)) 
                      + '&IID=' + CAST(dbo.pStyleHeader.DesignSketchID AS NVARCHAR(40)) + '" \>' AS ImagePath, 
                      '../System/Control/ImageStream.ashx?S=150&V=' + CAST(dbo.pStyleHeader.DesignSketchVersion AS NVARCHAR(5)) 
                      + '&IID=' + CAST(dbo.pStyleHeader.DesignSketchID AS NVARCHAR(40)) AS DataListImagePath

FROM         pStyleHeader a INNER JOIN
                      pStyleSeasonYear b ON a.StyleID = b.StyleID INNER JOIN
                      pStyleHeader ON a.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
                      pSeasonYear d ON d .SeasonyearID = b.SeasonYearID LEFT OUTER JOIN
                      dbo.pLinePlanItem f ON f.LinePlanItemID = b.LinePlanItemID LEFT OUTER JOIN
                      pLinePlanStyleAttributeItem g ON g.LinePlanStyleAttributeItemID = f.LinePlanStyleAttributeItemID LEFT OUTER JOIN
                      dbo.pStyleCategory e ON e.StyleCategoryId = a.StyleCategory



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03650', GetDate())
GO