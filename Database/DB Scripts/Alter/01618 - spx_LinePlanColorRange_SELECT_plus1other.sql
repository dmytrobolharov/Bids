IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanColorRange_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanColorRange_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LinePlanColorRange_SELECT](
	@LinePlanItemID UNIQUEIDENTIFIER,
	@LinePlanColorRangeID UNIQUEIDENTIFIER OUTPUT 
)
AS

	DECLARE 
		@LinaPlanIndex INT, 
		@LinePlanRangeID UNIQUEIDENTIFIER

	SELECT @LinaPlanIndex = COUNT(*), @LinePlanRangeID = c.LinePlanRangeID
	FROM pLinePlanItem c WITH(NOLOCK)
		INNER JOIN pLinePlan a WITH(NOLOCK) ON c.LinePlanID =  a.LinePlanID 
		INNER JOIN dbo.pLinePlanTemplateItem b WITH(NOLOCK)  ON a.LinePlanTemplateID = b.LinePlanTemplateID  
	WHERE c.LinePlanItemID = @LinePlanItemID
	GROUP BY c.LinePlanRangeID


	IF @LinaPlanIndex =  3 
		SELECT @LinePlanColorRangeID = b.LinePlanRangeID
		FROM dbo.pLinePlanRange a WITH(NOLOCK)
			INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK) ON a.LinePlanID = b.LinePlanID
				AND a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1
				AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2
				AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3
		WHERE a.LinePlanRangeID = @LinePlanRangeID
			AND b.LineplanFinancialID = '10000000-0000-0000-0000-000000000002'
	ELSE 
		SELECT @LinePlanColorRangeID = b.LinePlanRangeID
		FROM dbo.pLinePlanRange a WITH(NOLOCK)
			INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK) ON a.LinePlanID = b.LinePlanID
				AND a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1
				AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2
				AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3
				AND a.LinePlanAttributeItemID4 = b.LinePlanAttributeItemID4
		WHERE a.LInePlanRangeID = @LinePlanRangeID
			AND b.LineplanFinancialID = '10000000-0000-0000-0000-000000000002'

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMaterialRange_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanMaterialRange_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LinePlanMaterialRange_SELECT](
	@LinePlanItemID UNIQUEIDENTIFIER,
	@LinePlanMaterialRangeID UNIQUEIDENTIFIER OUTPUT 
)
AS

	DECLARE 
		@LinaPlanIndex INT, 
		@LinePlanRangeID UNIQUEIDENTIFIER

	SELECT @LinaPlanIndex = COUNT(*), @LinePlanRangeID = c.LinePlanRangeID
	FROM pLinePlanItem c WITH(NOLOCK)
		INNER JOIN pLinePlan a WITH(NOLOCK) ON c.LinePlanID =  a.LinePlanID 
		INNER JOIN dbo.pLinePlanTemplateItem b WITH(NOLOCK)  ON a.LinePlanTemplateID = b.LinePlanTemplateID  
	WHERE c.LinePlanItemID = @LinePlanItemID
	GROUP BY c.LinePlanRangeID


	IF @LinaPlanIndex =  3 
		SELECT @LinePlanMaterialRangeID = b.LinePlanRangeID
		FROM dbo.pLinePlanRange a WITH(NOLOCK)
			INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK) ON a.LinePlanID = b.LinePlanID
				AND a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1
				AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2
				AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3
		WHERE a.LinePlanRangeID = @LinePlanRangeID
			AND b.LineplanFinancialID = '10000000-0000-0000-0000-000000000001'
	ELSE 
		SELECT @LinePlanMaterialRangeID = b.LinePlanRangeID
		FROM dbo.pLinePlanRange a WITH(NOLOCK)
			INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK) ON a.LinePlanID = b.LinePlanID
				AND a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1
				AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2
				AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3
				AND a.LinePlanAttributeItemID4 = b.LinePlanAttributeItemID4
		WHERE a.LInePlanRangeID = @LinePlanRangeID
			AND b.LineplanFinancialID = '10000000-0000-0000-0000-000000000001'
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01618'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01618', GetDate())
END	

GO
