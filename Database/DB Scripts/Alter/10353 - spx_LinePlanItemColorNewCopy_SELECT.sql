IF OBJECT_ID(N'[dbo].[spx_LinePlanItemColorNewCopy_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanItemColorNewCopy_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanItemColorNewCopy_SELECT](
	@LinePlanID UNIQUEIDENTIFIER,
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@AllowColorAllocation INT,
	@LinePlanItemID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER	
)
AS

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

SELECT a.ColorPaletteID, a.ColorFolderID, a.ColorCode, a.ColorName, a.ColorSource, a.ColorNotes, 
	a.Hex, a.R, a.G, a.B, a.C, a.M, a.Y, a.K, a.H, 
	a.S, a.L, a.LAB_L, a.LAB_A, a.LAB_B, a.CUser, a.CDate, a.MUser, 
	a.MDate, a.ColorID, a.Change, a.Action, a.Active, a.Sort, a.ColorImage, 
	a.ColorImageType, a.CopyColorPaletteID,
	dbo.fnx_GetStreamingColorImageHTML(a.ColorFolderID, a.ColorPaletteID, 20, 'border="0"') AS ColorUrl, 
	0 AS Units, 
	0 AS StyleColorDelivery1,
	0 AS StyleColorDelivery2,
	0 AS StyleColorDelivery3,
	1 AS StyleColorDelivery4,
	0 AS StyleColorDelivery5, 'F' as ColorType,
	b.LinePlanID, b.LinePlanColorItemID, 
	b.LinePlanColorID, b.LinePlanRangeID
INTO #tmp	
FROM  pColorPalette a WITH(NOLOCK) 
	INNER JOIN pLinePlanColorItem b WITH(NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID
WHERE b.LinePlanRangeID = @LinePlanColorRangeID
ORDER BY a.ColorName



IF @AllowColorAllocation = 0
BEGIN 

	INSERT INTO #tmp
	SELECT a.ColorPaletteID, a.ColorFolderID, a.ColorCode, a.ColorName, a.ColorSource, a.ColorNotes, 
	a.Hex, a.R, a.G, a.B, a.C, a.M, a.Y, a.K, a.H, 
	a.S, a.L, a.LAB_L, a.LAB_A, a.LAB_B, a.CUser, a.CDate, a.MUser, 
	a.MDate, a.ColorID, a.Change, a.Action, a.Active, a.Sort, a.ColorImage, 
	a.ColorImageType, a.CopyColorPaletteID,
	dbo.fnx_GetStreamingColorImageHTML(a.ColorFolderID, a.ColorPaletteID, '20', 'border="0"') AS ColorUrl, 
	0 AS Units, 
	0 AS StyleColorDelivery1,
	0 AS StyleColorDelivery2,
	0 AS StyleColorDelivery3,
	1 AS StyleColorDelivery4,
	0 AS StyleColorDelivery5, 'F' as ColorType,
	b.LinePlanID, ISNULL (b.LinePlanColorItemID, '00000000-0000-0000-0000-000000000000' ), 
	b.LinePlanColorID, b.LinePlanRangeID
	FROM pLinePlanColorItemTemp b WITH(NOLOCK)
		INNER JOIN dbo.pColorPalette a WITH(NOLOCK) ON a.ColorPaletteID =  b.ColorPaletteID
	WHERE LinePlanColorGroupID = @LinePlanItemID
		AND b.TeamID = @TeamID
		AND  a.ColorCode NOT IN ( SELECT ColorCode FROM  #tmp )
	ORDER BY a.ColorName

END


SELECT * FROM #tmp
DROP TABLE #tmp


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10353', GetUTCDate())
GO
