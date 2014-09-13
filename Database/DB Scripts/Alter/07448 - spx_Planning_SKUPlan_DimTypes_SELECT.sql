IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUPlan_DimTypes_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUPlan_DimTypes_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUPlan_DimTypes_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @LookupQuery NVARCHAR(MAX) = 
		REPLACE('SELECT DISTINCT sbdt.DimTypeID, sbdt.DimTypeName
        FROM pPlanningItem pi
        INNER JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID
        INNER JOIN pStyleBOMDimension sbd ON pi.StyleBOMDimensionID = sbd.StyleBOMDimensionID
        CROSS APPLY (VALUES (sbd.ItemDim1TypeId),
					        (sbd.ItemDim2TypeId),
					        (sbd.ItemDim3TypeId)) 
				            V(ItemDimTypeID)
        INNER JOIN pStyleBOMDimType sbdt ON V.ItemDimTypeID = sbdt.DimTypeID
        WHERE pi.PlanningID = ''' + CAST(@PlanningID AS nVARCHAR(50)) + ''' AND ssy.SeasonYearID = ''' + CAST(@SeasonYearID AS nVARCHAR(50)) + '''
        ORDER BY sbdt.DimTypeName', CHAR(13) + CHAR(10), ' ')
	
	SELECT 'Dimension' + CAST(ROW_NUMBER() OVER(ORDER BY DimTypeName) AS NVARCHAR(5)) AS XmlSchema_Name
		, 'drlDimension' + CAST(ROW_NUMBER() OVER(ORDER BY DimTypeName) AS NVARCHAR(5))AS UniqueID -- name of the control
		, 'Dimension' AS XmlSchema_alias
		, 'dropdownlist' AS [XmlSchema_Type]
		, 'query' AS XmlSchema_datatype
		, 'true' AS [XmlSchema_enabled]
		, 'true' AS XmlSchema_Visible
		, '1' AS [XmlSchema_column]
		, @LookupQuery AS XmlSchema_lookupquery
		, 'DimTypeName' AS XmlSchema_textfield
		, 'DimTypeID' AS XmlSchema_ValueField
		, 'true' AS XmlSchema_GridVisible
		, ROW_NUMBER() OVER(ORDER BY DimTypeName) + 900 AS [XmlSchema_order]
		, 'one-source' AS XmlSchema_cssClass
		, ROW_NUMBER() OVER(ORDER BY DimTypeName) + 900 AS XmlSchema_GridOrder
		, 'TableHeaderYellow' AS XmlSchema_GridHeaderCss
		, * 
	FROM (
		SELECT DISTINCT sbdt.DimTypeID, sbdt.DimTypeName
		FROM pPlanningItem pi
		INNER JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pStyleBOMDimension sbd ON pi.StyleBOMDimensionID = sbd.StyleBOMDimensionID
		CROSS APPLY (VALUES (sbd.ItemDim1TypeId),
							(sbd.ItemDim2TypeId),
							(sbd.ItemDim3TypeId)) 
						   V(ItemDimTypeID)
		INNER JOIN pStyleBOMDimType sbdt ON V.ItemDimTypeID = sbdt.DimTypeID
		WHERE pi.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID) Dims
	ORDER BY DimTypeName

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07448', GetDate())
GO
