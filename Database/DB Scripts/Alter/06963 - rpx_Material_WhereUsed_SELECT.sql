IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Material_WhereUsed_SELECT] (
	@Season NVARCHAR(200) = NULL
	, @Year NVARCHAR(200) = NULL
	, @MaterialType INT = NULL
	, @MaterialName NVARCHAR(200) = NULL
	, @MaterialNo NVARCHAR(50) = NULL
	)
AS
BEGIN
	SELECT DISTINCT	
		m.MaterialNo
		, m.MaterialName
		, ct.ComponentDescription
		, m.Q AS VendorMill
		, m.R AS VendorMillRefNO
		, m.B AS Content
		, m.E AS Construction
		, m.F AS YarnSizeCount
		, m.D AS Weight
		, UOM.UOM
		, xc.Custom AS STATUS
		, CAST(ISNULL(sm.QTY, sb.Qty) AS DECIMAL(18,4)) AS Quantity
		, ISNULL(sm.Placement, sb.Placement) AS Placement
		, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion) AS FilePath
		, sh.StyleNo
		, sy.Season AS Season
		, sy.year AS [Year]
		, sh.[Description]
		, sh.SizeClass
		--, 1 AS GrandTotalGroup --- only to get the entire row group for grand total of the record count
	FROM pMaterial m
		LEFT JOIN pStyleMaterials sm ON m.MaterialID = sm.MaterialID
		LEFT JOIN pStyleBOM sb
			INNER JOIN pWorkFlowItem wfi
				INNER JOIN pStyleSeasonYear ssy ON wfi.StyleSeasonYearID = ssy.StyleSeasonYearID
			ON sb.WorkflowItemId = wfi.WorkFlowItemID
		ON m.MaterialID = sb.MaterialID
		INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
		LEFT JOIN pStyleHeader sh ON ISNULL(sm.StyleID, sb.StyleID) = sh.StyleID
		INNER JOIN pMaterialSeasonYear msy ON m.MaterialID = msy.MaterialID
		INNER JOIN pSeasonYear sy ON ISNULL(ssy.SeasonYearID, msy.SeasonYearID) = sy.SeasonYearID
		LEFT JOIN xCustom8 xc ON m.S = xc.CustomKey
		LEFT JOIN UOM ON m.UOM = UOM.UOMValue
	WHERE
		(sy.Season = @Season OR @Season IS NULL)
		AND (sy.Year = @Year OR @Year IS NULL)
		AND (ct.ComponentTypeID = @MaterialType OR @MaterialType IS NULL)
		AND (m.MaterialNo = @MaterialNo OR @MaterialNo IS NULL OR @MaterialNo = '')
		AND (m.MaterialName = @MaterialName	OR @MaterialName IS NULL OR @MaterialName = '')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06963', GetDate())
GO
