/****** Object:  StoredProcedure [dbo].[spx_SampleRequestListTradePartnerSeasonal_SELECT_API]    Script Date: 02/12/2014 15:08:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestListTradePartnerSeasonal_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestListTradePartnerSeasonal_SELECT_API]
GO
/****** Object:  StoredProcedure [dbo].[spx_SampleRequestListTradePartnerSeasonal_SELECT_API]    Script Date: 02/12/2014 15:08:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



Create PROCEDURE  [dbo].[spx_SampleRequestListTradePartnerSeasonal_SELECT_API](
	@StyleID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
)
AS
SELECT * FROM 
(SELECT p.SampleRequestTradeID, p.StyleID, ssy.SeasonYearID, wfi.WorkflowItemName as BOMName,
tprl.AgentID, tprl.VendorID, tprl.FactoryID, tprl.AgentName, tprl.VendorName, tprl.FactoryName,
sbd.ItemDim1TypeName, sbd.ItemDim2TypeName, sbd.ItemDim3TypeName,
sbdi1.ItemDim1ID, sbdi2.ItemDim2ID, sbdi3.ItemDim3ID,
CASE sbd.ItemDim1TypeName
WHEN 'Color' THEN (SELECT ColorCode + ' - ' + ColorName FROM pColorPalette WHERE ColorPaletteID = sbdi1.ItemDim1Id)
ELSE sbdi1.ItemDim1Name END AS ItemDim1Name, 
CASE sbd.ItemDim2TypeName
WHEN 'Color' THEN (SELECT ColorCode + ' - ' + ColorName FROM pColorPalette WHERE ColorPaletteID = sbdi2.ItemDim2Id)
ELSE sbdi2.ItemDim2Name END AS ItemDim2Name,
CASE sbd.ItemDim3TypeName
WHEN 'Color' THEN (SELECT ColorCode + ' - ' + ColorName FROM pColorPalette WHERE ColorPaletteID = sbdi3.ItemDim3Id)
ELSE sbdi3.ItemDim3Name END AS ItemDim3Name,

sh.TechPackDate,

CASE sbd.ItemDim1TypeName 
WHEN 'Color' THEN dbo.fnx_GetStreamingColorImagePath((SELECT ColorFolderID FROM pColorPalette WHERE ColorPaletteID = sbdi1.ItemDim1ID), sbdi1.ItemDim1ID) 
ELSE NULL END AS ItemDim1Image,
CASE sbd.ItemDim2TypeName
WHEN 'Color' THEN dbo.fnx_GetStreamingColorImagePath((SELECT ColorFolderID FROM pColorPalette WHERE ColorPaletteID = sbdi2.ItemDim2ID), sbdi2.ItemDim2ID) 
ELSE NULL END AS ItemDim2Image,
CASE sbd.ItemDim3TypeName 
WHEN 'Color' THEN dbo.fnx_GetStreamingColorImagePath((SELECT ColorFolderID FROM pColorPalette WHERE ColorPaletteID = sbdi3.ItemDim3ID), sbdi3.ItemDim3ID) 
ELSE NULL END AS ItemDim3Image
FROM (
SELECT SampleRequestTradeID, TradePartnerRelationshipLevelID, StyleID, StyleSeasonYearID,
'00000000-0000-0000-0000-000000000000' as StyleBOMDimensionID, '00000000-0000-0000-0000-000000000000' as ItemDim1ID, 
'00000000-0000-0000-0000-000000000000' as ItemDim2ID, '00000000-0000-0000-0000-000000000000' as ItemDim3ID 
FROM pSampleRequestTrade
UNION
SELECT SampleRequestTradeID, TradePartnerRelationshipLevelID, StyleID, StyleSeasonYearID,
StyleBOMDimensionID, ItemDim1ID, ItemDim2ID, ItemDim3ID 
FROM pSampleRequestBOMtrade
) p
LEFT JOIN pStyleHeader sh ON p.StyleID = sh.StyleID
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON p.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
LEFT JOIN pStyleBOMDimension sbd ON p.StyleBOMDimensionID = sbd.StyleBOMDimensionID
LEFT JOIN pWorkflowItem wfi ON sbd.WorkflowItemID = wfi.WorkflowItemID
LEFT JOIN pStyleSeasonYear ssy ON p.StyleSeasonYearID = ssy.StyleSeasonYearID 
LEFT JOIN pStyleBOMDimensionItem sbdi1 ON p.StyleBOMDimensionID = sbdi1.StyleBOMDimensionID AND p.ItemDim1ID = sbdi1.ItemDim1ID
LEFT JOIN pStyleBOMDimensionItem sbdi2 ON p.StyleBOMDimensionID = sbdi2.StyleBOMDimensionID AND p.ItemDim2ID = sbdi2.ItemDim2ID
LEFT JOIN pStyleBOMDimensionItem sbdi3 ON p.StyleBOMDimensionID = sbdi3.StyleBOMDimensionID AND p.ItemDim3ID = sbdi3.ItemDim3ID
Where p.TradePartnerRelationshipLevelID=@TradePartnerRelationshipLevelID) p
where StyleID=@StyleID and SeasonYearID=@SeasonYearID  


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07111', GetDate())
GO