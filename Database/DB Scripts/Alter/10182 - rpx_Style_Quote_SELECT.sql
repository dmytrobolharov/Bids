IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Quote_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Quote_SELECT]
GO

CREATE      procedure [dbo].[rpx_Style_Quote_SELECT]
    @StyleType int = null,
    @Season nvarchar(200) = null,
    @Year nvarchar(10) = null,
    @ProductCategory nvarchar(50) = null
as


select 
sh.StyleNo,
sh.[Description],
sh.SizeClass,
sh.SizeRange,
sc.StyleCostingCustomField2 as Weight,
sc.StyleCostingCustomField1 as TargetRetail,
sc.StyleCostingCustomField3 as TargetMargin,
sc.StyleCostingCustomField8 as Royalty,
sc.StyleCostingCustomField4 as MiscCost,
sc.StyleCostingCustomField18 as Units,
sct.StyleCostingType as CostingType,
sc.StyleCostingCustomField14 as TargetFirstCost,
sc.StyleCostingCustomField15 as FirstCost,
sc.StyleCostingCustomField11 as DutyPct,
scd.DutyCategory as QuotaCategory,
sc.StyleCostingCustomField9 as Commission,
dbo.fnx_GetStreamingImagePath(i.ImageID, i.[Version], 2000) AS FilePath	--Comment #01
from pStyleHeader sh WITH (NOLOCK)
join pStyleCosting sc on sh.StyleID = sc.StyleID
join pStyleCostingType sct on sc.StyleCostingTypeID = sct.StyleCostingTypeID
join pStyleCostingDuty scd on sc.StyleQuotaDutyId = scd.CustomID
left outer join hImage i on sh.DesignSketchID = i.ImageID and sh.DesignSketchVersion = i.Version
where (@StyleType is null or sh.StyleType = @StyleType)
and (@Season is null or sh.CustomField2 = @Season)
and (@Year is null or sh.CustomField4 = @Year)
and (@ProductCategory is null or sh.CustomField5 = @ProductCategory)



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10182', GetUTCDate())
GO