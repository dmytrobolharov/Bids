IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleOneSeasonal_SEL]
AS
SELECT DISTINCT
	TOP (100) PERCENT dbo.pStyleHeader.StyleID
	, dbo.pStyleSeasonYear.SeasonYearID
	, dbo.pStyleHeader.StyleNo
	, dbo.pStyleHeader.Description
	, dbo.pStyleHeader.StyleCategory
	, dbo.pStyleCategory.StyleCategory AS 'ProductCategoryName'
	, dbo.pStyleHeader.SizeClass
	, dbo.pStyleHeader.SizeRange
	, dbo.pStyleHeader.MaterialNo
	, dbo.pStyleHeader.MaterialName
	, dbo.pStyleHeader.CustomField1
	, dbo.pStyleHeader.CustomField2
	, dbo.pStyleHeader.CustomField3
	, dbo.pStyleHeader.CustomField4
	, dbo.pStyleHeader.CustomField5
	, dbo.pStyleHeader.CustomField6
	, dbo.pStyleHeader.CustomField7
	, dbo.pStyleHeader.CustomField8
	, dbo.pStyleHeader.CustomField15
	, dbo.pStyleHeader.CustomField14
	, dbo.pStyleHeader.CustomField13
	, dbo.pStyleHeader.CustomField12
	, dbo.pStyleHeader.CustomField11
	, dbo.pStyleHeader.CustomField10
	, dbo.pStyleHeader.CustomField9
	, dbo.pStyleHeader.CustomField16
	, dbo.pStyleHeader.CustomField30
	, dbo.pStyleHeader.CustomField29
	, dbo.pStyleHeader.CustomField28
	, dbo.pStyleHeader.CustomField27
	, dbo.pStyleHeader.CustomField26
	, dbo.pStyleHeader.CustomField25
	, dbo.pStyleHeader.CustomField24
	, dbo.pStyleHeader.CustomField23
	, dbo.pStyleHeader.CustomField22
	, dbo.pStyleHeader.CustomField21
	, dbo.pStyleHeader.CustomField20
	, dbo.pStyleHeader.CustomField19
	, dbo.pStyleHeader.CustomField18
	, dbo.pStyleHeader.CustomField17
	, dbo.pStyleHeader.CustomField31
	, dbo.pStyleHeader.CustomField32
	, dbo.pStyleHeader.CustomField33
	, dbo.pStyleHeader.CustomField34
	, dbo.pStyleHeader.CustomField35
	, dbo.pStyleHeader.CustomField36
	, dbo.pStyleHeader.CustomField37
	, dbo.pStyleHeader.CustomField38
	, dbo.pStyleHeader.CustomField39
	, dbo.pStyleHeader.CustomField40
	, dbo.pStyleHeader.StyleType
	, '<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(dbo.pStyleHeader.DesignSketchVersion AS NVARCHAR(5)) + '&IID=' + CAST(dbo.pStyleHeader.DesignSketchID AS NVARCHAR(40)) + '" \>' AS ImagePath
	, '../System/Control/ImageStream.ashx?S=150&V=' + CAST(dbo.pStyleHeader.DesignSketchVersion AS NVARCHAR(5)) + '&IID=' + CAST(dbo.pStyleHeader.DesignSketchID AS NVARCHAR(40)) AS DataListImagePath
	, (SELECT dbo.uTradePartner.TradePartnerName + ', '
		FROM
			dbo.pStyleHeader pSH(NOLOCK)
			LEFT OUTER JOIN dbo.pStyleSourcing(NOLOCK) ON pSH.StyleID = dbo.pStyleSourcing.StyleID
			LEFT OUTER JOIN dbo.uTradePartner(NOLOCK) ON dbo.pStyleSourcing.TradePartnerID = dbo.uTradePartner.TradePartnerID
		WHERE
			(pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')
	) TradePartnerName
	, (SELECT dbo.uTradePartnerVendor.VendorName + ', '
		FROM
			dbo.pStyleHeader pSH
			LEFT OUTER JOIN dbo.pStyleSourcing(NOLOCK) ON pSH.StyleID = dbo.pStyleSourcing.StyleID
			LEFT OUTER JOIN dbo.uTradePartnerVendor(NOLOCK) ON dbo.pStyleSourcing.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID
		WHERE
			(pSH.StyleID = dbo.pStyleHeader.StyleID) FOR XML PATH('')
	) VendorName
	, dbo.pSeasonYear.Season
	, dbo.pSeasonYear.Year
	, dbo.pLinePlanStyleAttributeItem.AttributeName
FROM
	dbo.pStyleHeader(NOLOCK)
	INNER JOIN dbo.pStyleSeasonYear(NOLOCK) ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
	LEFT OUTER JOIN dbo.pStyleColorwaySeasonYear(NOLOCK) ON dbo.pStyleSeasonYear.StyleSeasonYearID = dbo.pStyleColorwaySeasonYear.StyleSeasonYearID
	LEFT OUTER JOIN dbo.pStyleCategory(NOLOCK) ON dbo.pStyleCategory.StyleCategoryId = dbo.pStyleHeader.StyleCategory 
	LEFT OUTER JOIN dbo.pSizeClass(NOLOCK) ON dbo.pSizeClass.Custom = dbo.pStyleHeader.SizeClass 
	LEFT OUTER JOIN dbo.pSeasonyear(NOLOCK) ON dbo.pStyleSeasonyear.SeasonYearID = dbo.pSeasonyear.SeasonYearID
	LEFT OUTER JOIN dbo.pLinePlanItem(NOLOCK) ON dbo.pLinePlanItem.LinePlanItemID = pStyleSeasonYear.LinePlanITEMID
	LEFT OUTER JOIN dbo.pLinePlanStyleAttributeItem(NOLOCK) ON dbo.pLinePlanStyleAttributeItem.LinePlanStyleAttributeItemID = pLinePlanItem.LinePlanStyleAttributeItemID
WHERE
	EXISTS
		(SELECT
			StyleID
		 FROM
			dbo.pStyleSeasonYear AS pStyleSeasonYear_1
		 GROUP BY
			StyleID
		 HAVING
			(COUNT(*) = 1) AND (StyleID = dbo.pStyleHeader.StyleID)
		)
	AND pStyleCategory.Active = 1 AND pSizeClass.Active = 1
ORDER BY
	dbo.pStyleHeader.StyleNo

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '5.0.0000', '04524', GetDate())
GO
