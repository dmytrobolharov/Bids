IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_PreCosting_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_PreCosting_SELECT]
GO

CREATE  procedure [dbo].[rpx_Style_PreCosting_SELECT]
    @StyleType int = null,
    @Season nvarchar(200) = null,
    @Year nvarchar(10) = null,
    @ProductCategory nvarchar(50) = null
as

SELECT sh.StyleNo, sh.Description, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, 
       COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sc.StyleCostingCustomField2 AS Weight, 
	   sc.StyleCostingCustomField1 AS TargetRetail, sc.StyleCostingCustomField3 AS TargetMargin, 
	   sc.StyleCostingCustomField8 AS Royalty, sc.StyleCostingCustomField4 AS MiscCost, 
       sc.StyleCostingCustomField18 AS Units, sct.StyleCostingType AS CostingType, sc.StyleCostingCustomField14 AS TargetFirstCost, 
       sc.StyleCostingCustomField15 AS FirstCost, sc.StyleCostingCustomField11 AS DutyPct, scd.DutyCategory AS QuotaCategory, 
       sc.StyleCostingCustomField9 AS Commission, sh.StyleType, sc.StyleCostingTypeID, sh.CustomField5 AS StyleCategory,
       dbo.fnx_GetStreamingImagePath(i.ImageID, i.[Version], 2000) AS FilePath
FROM pStyleCostingDuty AS scd 
RIGHT OUTER JOIN pStyleCostingType AS sct 
INNER JOIN pStyleCosting AS sc ON sct.StyleCostingTypeID = sc.StyleCostingTypeID 
INNER JOIN pStyleHeader AS sh ON sc.StyleID = sh.StyleID ON scd.Custom = sc.StyleCostingHTS 
LEFT OUTER JOIN hImage AS i ON sh.DesignSketchID = i.ImageID AND sh.DesignSketchVersion = i.Version
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
where (@StyleType is null or sh.StyleType = @StyleType)
and (@Season is null or sh.CustomField2 = @Season)
and (@Year is null or sh.CustomField4 = @Year)
and (@ProductCategory is null or sh.CustomField5 = @ProductCategory)
ORDER BY sh.CustomField5


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10181', GetUTCDate())
GO