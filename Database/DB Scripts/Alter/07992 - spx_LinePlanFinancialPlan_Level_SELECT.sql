/****** Object:  StoredProcedure [dbo].[spx_LinePlanFinancialPlan_Level_SELECT]    Script Date: 06/12/2014 10:57:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanFinancialPlan_Level_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanFinancialPlan_Level_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanFinancialPlan_Level_SELECT]    Script Date: 06/12/2014 10:57:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LinePlanFinancialPlan_Level_SELECT]
(
	@LinePlanID uniqueidentifier,
	@LinePlanAttributeItemID uniqueidentifier,
	@TeamID uniqueidentifier
)
AS 
BEGIN
	DECLARE @LinePlanLevel INTEGER

	SELECT @LinePlanLevel = COUNT(*)
	FROM pLinePlan a
	INNER JOIN pLinePlanTemplateItem b ON a.LinePlanTemplateID = b.LinePlanTemplateID 
	WHERE LinePlanID = @LinePlanId 


	IF @LinePlanAttributeItemID = '00000000-0000-0000-0000-000000000000'
	BEGIN

		SELECT DISTINCT a.LinePlanAttributeItemID, a.LinePlanAttributeItemParentID, a.LinePlanAttributeID, 
			a.LinePlanTemplateID, a.LinePlanTemplateItemID, a.LinePlanId, 
			a.LinePlanAttributeText, a.LinePlanAttributeValue, 
			a.CUser, a.CDate, a.MUser, a.MDate, 
			CAST(a.Sort AS INT) AS Sort, CAST(b.LinePlanTemplateItemSort AS INT) AS LinePlanTemplateItemSort,
			@LinePlanLevel AS LinePlanLevel

		FROM pLinePlanAttributeItem a WITH (NOLOCK) 
			INNER JOIN pLinePlanTemplateItem b WITH (NOLOCK) ON a.LinePlanTemplateItemID = b.LinePlanTemplateItemID
			INNER JOIN sAccessLinePlanFolder c WITH (NOLOCK) ON a.LinePlanAttributeValue = CAST(c.CustomID AS nVARCHAR(40))

		WHERE a.LinePlanId = @LinePlanId
			AND a.LinePlanAttributeItemParentID = @LinePlanAttributeItemID
			AND b.Active = 1
			AND c.TeamId = @TeamID
			AND c.LinePlanTemplateID = a.LinePlanTemplateID
			AND c.AccessRoleId <> 0

		ORDER BY CAST(b.LinePlanTemplateItemSort AS INT), CAST(a.Sort AS INT)

	END
	
	IF @LinePlanAttributeItemID <> '00000000-0000-0000-0000-000000000000'
	BEGIN

		SELECT DISTINCT a.LinePlanAttributeItemID, a.LinePlanAttributeItemParentID, a.LinePlanAttributeID, 
			a.LinePlanTemplateID, a.LinePlanTemplateItemID, a.LinePlanId, 
			a.LinePlanAttributeText, a.LinePlanAttributeValue, 
			a.CUser, a.CDate, a.MUser, a.MDate, 
			CAST(a.Sort AS INT) AS Sort, CAST(b.LinePlanTemplateItemSort AS INT) AS LinePlanTemplateItemSort,
			@LinePlanLevel AS LinePlanLevel

		FROM pLinePlanAttributeItem a WITH (NOLOCK) 
			INNER JOIN pLinePlanTemplateItem b WITH (NOLOCK) ON a.LinePlanTemplateItemID = b.LinePlanTemplateItemID

		WHERE a.LinePlanId = @LinePlanId
			AND a.LinePlanAttributeItemParentID = @LinePlanAttributeItemID
			AND b.Active = 1

		ORDER BY CAST(b.LinePlanTemplateItemSort AS INT), CAST(a.Sort AS INT)
	
	END

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07992', GetDate())
GO
