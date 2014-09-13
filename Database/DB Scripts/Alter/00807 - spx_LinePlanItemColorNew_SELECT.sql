IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanItemColorNew_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanItemColorNew_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LinePlanItemColorNew_SELECT](
@LinePlanID UNIQUEIDENTIFIER,
@LinePlanRangeID UNIQUEIDENTIFIER
)
AS


DECLARE 
	@LinePlanAttributeItemID1 UNIQUEIDENTIFIER, 
	@LinePlanAttributeItemID2 UNIQUEIDENTIFIER, 
	@LinePlanAttributeItemID3 UNIQUEIDENTIFIER, 
	@LinePlanAttributeItemID4 UNIQUEIDENTIFIER,
	@Index INT


--** LinePlan Hierarchy index 
SELECT @Index =  COUNT(*) 
FROM dbo.pLinePlanTemplateItem a WITH(NOLOCK)
	INNER JOIN pLinePlanTemplate b WITH(NOLOCK) ON b.LinePlanTemplateID = a.LinePlanTemplateID
	INNER JOIN dbo.pLinePlan c WITH(NOLOCK) ON c.LinePlanTemplateID =  b.LinePlanTemplateID
WHERE c.LinePlanID = @LinePlanID

--** Hierarchy attributes
SELECT 
	@LinePlanAttributeItemID1 = LinePlanAttributeItemID1, 
	@LinePlanAttributeItemID2 = LinePlanAttributeItemID2, 
	@LinePlanAttributeItemID3 = LinePlanAttributeItemID3, 
	@LinePlanAttributeItemID4 = LinePlanAttributeItemID4
FROM pLinePlanRange WITH(NOLOCK)
WHERE LinePlanRangeID = @LinePlanRangeID



IF @Index = 3 
BEGIN 
	SELECT b.LinePlanID, b.LinePlanColorItemID, 
		b.LinePlanColorID, b.LinePlanRangeID, c.*,
		'<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(c.ColorFolderID AS NVARCHAR(50)) 
		+ '&CPID=' + CAST(c.ColorPaletteID AS NVARCHAR(50)) +  '" border="0" />' AS ColorUrl,	
		0 AS StyleColorDelivery1,
		0 AS StyleColorDelivery2,
		0 AS StyleColorDelivery3,
		1 AS StyleColorDelivery4,
		0 AS StyleColorDelivery5,
		0 as Units, 'F' AS ColorType,
		'N' AS Custom_ColorType
	FROM dbo.pLinePlanRange a WITH(NOLOCK)
		INNER JOIN dbo.pLinePlanColorItem b WITH(NOLOCK) ON a.LinePlanRangeID = b.LinePlanRangeID
		INNER JOIN dbo.pColorPalette  c WITH(NOLOCK) ON c.ColorPaletteID = b.ColorPaletteID
	WHERE a.LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
	AND a.LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
	AND a.LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
	AND a.LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
	ORDER BY c.ColorName
END
ELSE 
BEGIN

	SELECT b.LinePlanID, b.LinePlanColorItemID, 
		b.LinePlanColorID, b.LinePlanRangeID, c.*,
		'<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(c.ColorFolderID AS NVARCHAR(50)) 
		+ '&CPID=' + CAST(c.ColorPaletteID AS NVARCHAR(50)) +  '" border="0" />' AS ColorUrl,	
		0 AS StyleColorDelivery1,
		0 AS StyleColorDelivery2,
		0 AS StyleColorDelivery3,
		1 AS StyleColorDelivery4,
		0 AS StyleColorDelivery5,
		0 as Units, 'F' AS ColorType,
		'N' AS Custom_ColorType
	FROM dbo.pLinePlanRange a WITH(NOLOCK)
		INNER JOIN dbo.pLinePlanColorItem b WITH(NOLOCK) ON a.LinePlanRangeID = b.LinePlanRangeID
		INNER JOIN dbo.pColorPalette  c WITH(NOLOCK) ON c.ColorPaletteID = b.ColorPaletteID
	WHERE a.LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
	AND a.LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
	AND a.LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
	AND a.LinePlanAttributeItemID4 = @LinePlanAttributeItemID4
	AND a.LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
	ORDER BY c.ColorName
	
END 


GO