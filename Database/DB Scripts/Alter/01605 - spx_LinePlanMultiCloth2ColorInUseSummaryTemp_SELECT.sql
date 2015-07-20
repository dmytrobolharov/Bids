IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2ColorInUseSummaryTemp_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorInUseSummaryTemp_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2ColorInUseSummaryTemp_SELECT](
@LinePlanColorGroupID UNIQUEIDENTIFIER
)
AS



	SELECT DISTINCT b.ColorPaletteID, b.ColorFolderID ,  b.ColorCode, b.ColorName, 
	'<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(b.ColorFolderID AS NVARCHAR(50)) 
	+ '&CPID=' + CAST(b.ColorPaletteID AS NVARCHAR(50)) + '" border="0" />' AS ColorUrl	
	FROM pLinePlanMultiCloth2ColorTemp a
	INNER JOIN  pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID 
	WHERE a.LinePlanColorGroupID = @LinePlanColorGroupID 
	AND a.MaterialCoreColorID IS NOT NULL 
	AND a.MaterialCoreColorID  <> '00000000-0000-0000-0000-000000000000'
	ORDER BY b.ColorCode



GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01605'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01605', GetDate())
END	

GO
