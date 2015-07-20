IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2MaterialColorSummaryTemp_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialColorSummaryTemp_SELECT]
GO



CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2MaterialColorSummaryTemp_SELECT](
	@LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS


SELECT  a.LinePlanColorGroupID,
	b.MaterialID,c.MaterialName, c.MaterialNo,
	CAST( b.MaterialCoreColorID AS NVARCHAR(40)) AS MaterialCoreColorID,
	CAST( b.ColorPaletteID AS NVARCHAR(40)) AS ColorPaletteID
INTO #tmp
FROM pLinePlanMultiCloth2MaterialGroupItemTemp a WITH(NOLOCK)
	INNER JOIN pLinePlanMultiCloth2ColorTemp b WITH(NOLOCK) ON a.LinePlanMultiCloth2ColorTempID = b.LinePlanMultiCloth2ColorTempID 
	INNER JOIN pMaterial c WITH(NOLOCK) ON c.MaterialID = b.MaterialID
WHERE a.LinePlanColorGroupID= @LinePlanColorGroupID


EXECUTE spx_Crosstab 
	'SELECT * FROM #tmp',
	NULL,
	NULL,
	'ColorPaletteID',
	'MaterialCoreColorID',
	'MAX'

DROP TABLE #tmp


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01606'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01606', GetDate())
END	

GO
