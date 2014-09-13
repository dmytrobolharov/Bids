IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanItemColorNew_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanItemColorNew_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanItemColorNew_SELECT](
	@LinePlanID UNIQUEIDENTIFIER,
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@AllowColorAllocation INT,
	@LinePlanItemID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
)
AS

IF @AllowColorAllocation = 0
BEGIN 

	SELECT 
		a.LinePlanID, a.LinePlanColorItemID, 
		a.LinePlanColorID, a.LinePlanRangeID, 
		b.ColorPaletteID , b.ColorFolderID, b.ColorCode, b.ColorName,
		'<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(b.ColorFolderID AS NVARCHAR(50)) 
		+ '&CPID=' + CAST(b.ColorPaletteID AS NVARCHAR(50)) +  '" border="0" />' AS ColorUrl,	
		0 AS StyleColorDelivery1,
		0 AS StyleColorDelivery2,
		0 AS StyleColorDelivery3,
		1 AS StyleColorDelivery4,
		0 AS StyleColorDelivery5,
		0 as Units, 'F' AS ColorType,
		'N' AS Custom_ColorType
	FROM pLinePlanColorItemTemp a WITH(NOLOCK)
		INNER JOIN dbo.pColorPalette b WITH(NOLOCK) ON a.ColorPaletteID =  b.ColorPaletteID
	WHERE LinePlanColorGroupID = @LinePlanItemID
		AND a.TeamID = @TeamID
	ORDER BY b.ColorName
END
ELSE 
BEGIN

	DECLARE 
		@LinePlanColorRangeID UNIQUEIDENTIFIER,
		@Index INT


	--** LinePlan Hierarchy index 
	SELECT @Index =  COUNT(*)
	FROM pLinePlanRange a WITH(NOLOCK)
		INNER JOIN dbo.pLinePlan b WITH(NOLOCK) ON a.LinePlanID = b.LinePlanID 
		INNER JOIN dbo.pLinePlanTemplateItem c WITH(NOLOCK) ON c.LinePlanTemplateID =  b.LinePlanTemplateID
	WHERE LinePlanRangeID = @LinePlanRangeID

	IF @Index = 3 
		SELECT @LinePlanColorRangeID = b.LinePlanRangeID 
		FROM dbo.pLinePlanRange a WITH(NOLOCK)
			INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK)  ON 
				a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1 
				AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2 
				AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3 
		WHERE a.LinePlanRangeID = @LinePlanRangeID
			AND b.LinePlanFinancialID = '10000000-0000-0000-0000-000000000002' 
	ELSE 
		SELECT @LinePlanColorRangeID = b.LinePlanRangeID 
		FROM dbo.pLinePlanRange a WITH(NOLOCK)
			INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK)  ON 
				a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1 
				AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2 
				AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3 
				AND a.LinePlanAttributeItemID4 = b.LinePlanAttributeItemID4
		WHERE a.LinePlanRangeID = @LinePlanRangeID
			AND b.LinePlanFinancialID = '10000000-0000-0000-0000-000000000002' 
	---****		

	SELECT b.LinePlanID, b.LinePlanColorItemID, 
		b.LinePlanColorID, b.LinePlanRangeID, 
		c.ColorPaletteID , c.ColorFolderID, c.ColorCode, c.ColorName,
		'<img src="../System/Control/ColorStream.ashx?S=20&CFID=' + CAST(c.ColorFolderID AS NVARCHAR(50)) 
		+ '&CPID=' + CAST(c.ColorPaletteID AS NVARCHAR(50)) +  '" border="0" />' AS ColorUrl,	
		0 AS StyleColorDelivery1,
		0 AS StyleColorDelivery2,
		0 AS StyleColorDelivery3,
		1 AS StyleColorDelivery4,
		0 AS StyleColorDelivery5,
		0 as Units, 'F' AS ColorType,
		'N' AS Custom_ColorType
	FROM dbo.pLinePlanColorItem b WITH(NOLOCK)
		INNER JOIN dbo.pColorPalette  c WITH(NOLOCK) ON c.ColorPaletteID = b.ColorPaletteID
	WHERE b.LinePlanRangeID = @LinePlanColorRangeID
	ORDER BY c.ColorName
END 



GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01545'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01545', GetDate())
END	

GO

