IF OBJECT_ID(N'[dbo].[rpx_Quotation_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Quotation_SELECT]
GO

CREATE procedure [dbo].[rpx_Quotation_SELECT]
    @AgentVendor nvarchar(200) = null,
    @Season nvarchar(200) = null,
    @Year nvarchar(10) = null,
    @ProductCategory nvarchar(50) = null,
    @Status nvarchar(50) = null
as

select tp.TradePartnerName,
sh.CustomField5 as ProductCategory,
qs.Custom as [Status],
sqv.StyleNo,
sh.[Description],
sqv.SizeClass,
COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
sqv.MaterialNo as FabricCode,
sqv.StyleQuoteItemCustomField5 as COO,
sqv.StyleQuoteItemCustomField4 as FOBCOO,
sqv.StyleCostingCustomField2 as Weight,
sqv.StyleCostingCustomField1 as TargetRetail,
sqv.StyleCostingCustomField14 as TargetFirstCost,
sqv.StyleQuoteItemCustomField1 as QuotedFirstCost,
sqv.TotalLandCost,
sqv.StyleCostingCustomField3 as TargetMargin,
sqv.Margin,
sqv.StyleCostingCustomField18 as Units,
datediff(d, sqv.StyleQuoteItemDueDate, getdate()) as DaysLate,
case when cast(qs.CustomKey as int) = 3 then 1 else 0 end as Approved,
case when cast(qs.CustomKey as int) != 3 then 1 else 0 end as Pending
from pStyleHeader sh WITH (NOLOCK)
join vwx_BI_Quote_Default_SELECT sqv on sh.StyleID = sqv.StyleID
join uTradePartner tp WITH (NOLOCK) on sqv.TradePartnerID = tp.TradePartnerID
join pStyleQuoteItemStatus qs WITH (NOLOCK) on sqv.StyleQuoteItemStatusID = qs.CustomKey
left join pSizeRange sr ON sr.CustomId = sh.SizeRangeId
where (@AgentVendor is null or sqv.TradePartnerID = @AgentVendor)
and (@Season is null or sh.CustomField2 = @Season)
and (@Year is null or sh.CustomField4 = @Year)
and (@ProductCategory is null or sh.CustomField5 = @ProductCategory)
and (@Status is null or sqv.StyleQuoteItemStatusID = @Status)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09604', GetDate())
GO
