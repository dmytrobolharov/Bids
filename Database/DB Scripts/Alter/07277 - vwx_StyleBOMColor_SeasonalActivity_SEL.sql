IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleBOMColor_SeasonalActivity_SEL]'))
DROP VIEW [dbo].[vwx_StyleBOMColor_SeasonalActivity_SEL]
GO

CREATE VIEW [dbo].[vwx_StyleBOMColor_SeasonalActivity_SEL]
AS
SELECT wfi.StyleSeasonYearID, V.DimID AS StyleColorID, MAX(V.DimActive) AS ColorActive 
FROM pStyleBOMDimensionItem sbdi
INNER JOIN pWorkFlowItem wfi ON sbdi.WorkFlowItemID = wfi.WorkFlowItemID
CROSS APPLY (VALUES (sbdi.ItemDim1TypeId, sbdi.ItemDim1Id, ItemDim1Active),
					(sbdi.ItemDim2TypeId, sbdi.ItemDim2Id, ItemDim2Active),
					(sbdi.ItemDim3TypeId, sbdi.ItemDim3Id, ItemDim3Active))
				   V(DimTypeID, DimID, DimActive)
INNER JOIN pStyleBOMDimType sbdt ON V.DimTypeID = sbdt.DimTypeID
WHERE UPPER(LTRIM(RTRIM(sbdt.DimTypeName))) = 'COLOR' AND V.DimID IS NOT NULL
GROUP BY wfi.StyleSeasonYearID, V.DimID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07277', GetDate())
GO
