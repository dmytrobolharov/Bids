IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_DashMaterialException_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_DashMaterialException_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_DashMaterialException_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER
	, @DivisionID UNIQUEIDENTIFIER
	, @StyleTypeID NVARCHAR(MAX)
	, @StyleCategoryID NVARCHAR(MAX)
	, @MaterialTypeID NVARCHAR(MAX)
)
AS
BEGIN

	IF @SeasonYearID = '00000000-0000-0000-0000-000000000000' SELECT @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
	
	DECLARE @tmpStyleType TABLE (StyleTypeID INT)
	INSERT INTO @tmpStyleType
	SELECT CAST(value AS INT) FROM fnx_Split(@StyleTypeID, ',')
	
	DECLARE @tmpStyleCategory TABLE (StyleCategoryID UNIQUEIDENTIFIER)
	INSERT INTO @tmpStyleCategory
	SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@StyleCategoryID, ',')
	
	DECLARE @tmpMaterialType TABLE (MaterialTypeID INT)
	INSERT INTO @tmpMaterialType
	SELECT CAST(value AS INT) FROM fnx_Split(@MaterialTypeID, ',')		

	SELECT DISTINCT sb.MaterialID
		, m.MaterialNo
		, m.MaterialName
		, mc.MaterialColorID
		, cp.ColorCode
		, cp.ColorName
		, ms.MaterialSizeID
		, ms.MaterialSize
		, COUNT(DISTINCT sbd.StyleBOMDimensionID) AS CountOfBOM_WithTheSame_MaterialColorSize
		, 'javascript: void(window.open(''' + AppSettingValue + '/Material/Material_Frame.aspx?MTID=' + CAST(m.MaterialID AS NVARCHAR(50))+ '''))' AS MaterialLink
	FROM pStyleHeader sh
		INNER JOIN pStyleBOMDimension sbd ON sh.StyleID = sbd.StyleID
		INNER JOIN pWorkFlowItem wi ON sbd.WorkFlowItemID = wi.WorkFlowItemID
		INNER JOIN pStyleSeasonYear ssy ON wi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
		INNER JOIN pStyleBOMConfig sbc ON sbd.StyleBOMDimensionID = sbc.StyleBOMDimensionID
		INNER JOIN pStyleBOM sb ON sbd.StyleBOMDimensionID = sb.StyleBOMDimensionId
		INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID
		LEFT JOIN pStyleBOMItem sbi
			INNER JOIN pStyleBOMDimensionItems sbdi ON sbi.StyleBOMDimensionItemID = sbdi.StyleBOMDimensionItemID
				AND sbdi.ItemDim1Active = 1
				AND sbdi.ItemDim2Active = 1
				AND sbdi.ItemDim3Active = 1 ON sb.StyleMaterialID = sbi.StyleMaterialID
				AND sb.StyleBOMDimensionId = sbi.StyleBOMDimensionId LEFT JOIN pMaterialColor mc ON sb.MaterialID = mc.MaterialID
				AND mc.MaterialColorID = CASE 
					WHEN 1 IN (sb.Dim1TypeSel, sb.Dim2TypeSel, sb.Dim3TypeSel) AND sbc.DimBOM = 1 THEN ISNULL(sbi.MaterialColorID, '00000000-0000-0000-0000-000000000000')
					ELSE ISNULL(sb.MaterialColorId, '00000000-0000-0000-0000-000000000000')
					END
			LEFT JOIN pColorPalette cp ON cp.ColorPaletteID = mc.ColorPaletteID LEFT JOIN pMaterialSize ms ON sb.MaterialID = ms.MaterialID
				AND ms.MaterialSizeId = CASE 
					WHEN 1 IN (sb.Dim1TypeSel, sb.Dim2TypeSel, sb.Dim3TypeSel) AND sbc.DimBOM = 1 THEN ISNULL(sbi.MaterialDimension, '00000000-0000-0000-0000-000000000000')
					ELSE ISNULL(sb.MaterialSizeID, '00000000-0000-0000-0000-000000000000')
					END
			LEFT JOIN pMaterialTradePartner mtp ON sb.MaterialID = mtp.MaterialId
				AND sb.TradePartnerRelationshipLevelID = mtp.TradePartnerRelationshipLevelID
				AND ssy.SeasonYearID = mtp.SeasonYearID LEFT JOIN pMaterialTradePartnerColor mtpc ON sb.MaterialID = mtpc.MaterialID
				AND mtp.MaterialTradePartnerId = mtpc.MaterialTradePartnerId
				AND CASE 
					WHEN 1 IN (sb.Dim1TypeSel, sb.Dim2TypeSel, sb.Dim3TypeSel) AND sbc.DimBOM = 1 THEN ISNULL(sbi.MaterialColorID, '00000000-0000-0000-0000-000000000000')
					ELSE ISNULL(sb.MaterialColorId, '00000000-0000-0000-0000-000000000000')
					END = mtpc.MaterialColorID
				AND CASE 
					WHEN 1 IN (sb.Dim1TypeSel, sb.Dim2TypeSel, sb.Dim3TypeSel) AND sbc.DimBOM = 1 THEN ISNULL(sbi.MaterialDimension, '00000000-0000-0000-0000-000000000000')
					ELSE ISNULL(sb.MaterialSizeID, '00000000-0000-0000-0000-000000000000')
					END = mtpc.MaterialSizeID LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl
		ON sb.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN @tmpStyleType tst ON sh.StyleType = tst.StyleTypeID
		INNER JOIN @tmpStyleCategory tsc ON sh.StyleCategory = tsc.StyleCategoryID
		INNER JOIN @tmpMaterialType tmt ON m.MaterialType = tmt.MaterialTypeID
		, sAppSetting
	WHERE mc.MaterialColorID IS NOT NULL
		AND mc.MaterialColorID <> '00000000-0000-0000-0000-000000000000'
		AND mtpc.MaterialTradePartnerColorID IS NULL
		AND sh.DivisionID = @DivisionID
		AND AppSettingKey = 'plmOnApplicationServerUrl'
	GROUP BY sb.MaterialID
		, m.MaterialNo
		, m.MaterialName
		, mc.MaterialColorID
		, cp.ColorCode
		, cp.ColorName
		, ms.MaterialSizeID
		, ms.MaterialSize
		, m.MaterialID
		, AppSettingValue
	ORDER BY MaterialNo

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09008', GetDate())
GO
