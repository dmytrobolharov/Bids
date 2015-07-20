IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanRangeColorsUsed_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanRangeColorsUsed_SELECT]
GO

CREATE PROCEDURE  dbo.spx_LinePlanRangeColorsUsed_SELECT(
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
)
AS 


-- Get Color - LineplanRangeID
DECLARE 
	@LinePlanIndex INT,
	@LinePlanColorRangeID UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID1 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID2 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID3 UNIQUEIDENTIFIER,
	@LinePlanAttributeItemID4 UNIQUEIDENTIFIER

SELECT 
	@LinePlanIndex = COUNT(*),
	@LinePlanAttributeItemID1 = a.LinePlanAttributeItemID1, 
	@LinePlanAttributeItemID2 = a.LinePlanAttributeItemID2,
	@LinePlanAttributeItemID3 = a.LinePlanAttributeItemID3, 
	@LinePlanAttributeItemID4 = a.LinePlanAttributeItemID4
FROM pLinePlanRange a WITH(NOLOCK) 
	INNER JOIN dbo.pLinePlan b WITH(NOLOCK)  ON a.LinePlanID =  b.LinePlanID 
	INNER JOIN dbo.pLinePlanTemplateItem c WITH(NOLOCK)  ON b.LinePlanTemplateID = c.LinePlanTemplateID
WHERE a.LinePlanRangeID = @LinePlanRangeID 	
GROUP BY  a.LinePlanAttributeItemID1, a.LinePlanAttributeItemID2, 
	a.LinePlanAttributeItemID3, a.LinePlanAttributeItemID4




IF @LinePlanIndex = 4
	SELECT @LinePlanColorRangeID = LinePlanRangeID FROM pLinePlanRange WITH(NOLOCK)
	WHERE  LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
		AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
		AND LinePlanAttributeItemID4 = @LinePlanAttributeItemID4
		AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
ELSE 	
	SELECT @LinePlanColorRangeID = LinePlanRangeID FROM pLinePlanRange WITH(NOLOCK)
	WHERE  LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
		AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
		AND LinePlanAttributeItemID4 IS NULL 
		AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'


SELECT a.ColorPaletteID, b.ColorFolderID, b.ColorCode, b.ColorName, b.ColorSource,
	'<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(b.ColorFolderID AS NVARCHAR(50)) 
	+ '&CPID=' + CAST(b.ColorPaletteID AS NVARCHAR(50)) +  '" border="0" />' AS ColorImage
FROM dbo.pLinePlanColorItem a WITH(NOLOCK)
	INNER JOIN dbo.pColorPalette b WITH(NOLOCK)  ON a.ColorPaletteID = b.ColorPaletteID
WHERE a.LinePlanRangeID  = @LinePlanColorRangeID


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01610'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01610', GetDate())
END	

GO
