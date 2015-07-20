IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanBusinessLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanBusinessLogic_INSERT]
GO



CREATE PROCEDURE [dbo].[spx_LinePlanBusinessLogic_INSERT]
(
@LinePlanId varchar(40)
)
AS 


DECLARE @LinePlanTemplateID UNIQUEIDENTIFIER 
DECLARE @LinePlanIndex INT 

SELECT @LinePlanTemplateID = LinePlanTemplateID FROM pLinePlan WHERE LinePlanID  = @LinePlanId
SELECT @LinePlanIndex = COUNT(*) FROM pLinePlanTemplateItem WHERE LinePlanTemplateID = @LinePlanTemplateID


IF @LinePlanIndex = 3 
BEGIN 
	INSERT INTO pLinePlanBusiness
		(LinePlanId, LinePlanFinancialID, LinePlanAttributeItemID1, LinePlanAttributeItemID2, LinePlanAttributeItemID3, 
		  LinePlanFinancialText, LinePlanAttributeText1, LinePlanAttributeText2, LinePlanAttributeText3, 
		  LinePlanAttributeItemSort1, LinePlanAttributeItemSort2, LinePlanAttributeItemSort3, LinePlanFinancialSort)
	SELECT CAST(@LinePlanId AS VARCHAR(40)), CAST(pLinePlanFinancial.LinePlanFinancialID AS VARCHAR(40)), 
		CAST(vLinePlanP.LinePlanAttributeItemID1 AS VARCHAR(40)), CAST(vLinePlanP.LinePlanAttributeItemID2 AS VARCHAR(40)), 
		CAST(vLinePlanP.LinePlanAttributeItemID3 AS VARCHAR(40)), pLinePlanFinancial.LinePlanFinancialText, 
		vLinePlanP.LinePlanAttributeText1, vLinePlanP.LinePlanAttributeText2, vLinePlanP.LinePlanAttributeText3,
		vLinePlanP.LinePlanAttributeItemSort1, vLinePlanP.LinePlanAttributeItemSort2, vLinePlanP.LinePlanAttributeItemSort3, 
		pLinePlanFinancial.LinePlanFinancialSort
	FROM vwx_LinePlanItemProduct_SELECT vLinePlanP CROSS JOIN pLinePlanFinancial 
	WHERE vLinePlanP.LinePlanID = @LinePlanID AND vLinePlanP.LinePlanAttributeItemID3 NOT IN 
	(SELECT LinePlanAttributeItemID3 FROM pLinePlanBusiness WHERE LinePlanID = @LinePlanID)
END
ELSE IF @LinePlanIndex = 4 
BEGIN

	INSERT INTO pLinePlanBusiness(
	LinePlanId, LinePlanFinancialID, LinePlanAttributeItemID1, LinePlanAttributeItemID2, LinePlanAttributeItemID3, LinePlanAttributeItemID4, LinePlanFinancialText, 
	LinePlanAttributeText1, LinePlanAttributeText2, LinePlanAttributeText3, LinePlanAttributeText4,
	LinePlanAttributeItemSort1, LinePlanAttributeItemSort2, LinePlanAttributeItemSort3, LinePlanAttributeItemSort4, LinePlanFinancialSort)
	SELECT CAST(@LinePlanId AS VARCHAR(40)), CAST(pLinePlanFinancial.LinePlanFinancialID AS VARCHAR(40)), 
	CAST(vLinePlanP.LinePlanAttributeItemID1 AS VARCHAR(40)), CAST(vLinePlanP.LinePlanAttributeItemID2 AS VARCHAR(40)), 
	CAST(vLinePlanP.LinePlanAttributeItemID3 AS VARCHAR(40)), CAST(vLinePlanP.LinePlanAttributeItemID4 AS VARCHAR(40)), pLinePlanFinancial.LinePlanFinancialText, 
	vLinePlanP.LinePlanAttributeText1, vLinePlanP.LinePlanAttributeText2, vLinePlanP.LinePlanAttributeText3, vLinePlanP.LinePlanAttributeText4,
	vLinePlanP.LinePlanAttributeItemSort1, vLinePlanP.LinePlanAttributeItemSort2, vLinePlanP.LinePlanAttributeItemSort3, vLinePlanP.LinePlanAttributeItemSort4, 
	pLinePlanFinancial.LinePlanFinancialSort
	FROM vwx_LinePlanItemProduct_SELECT vLinePlanP CROSS JOIN pLinePlanFinancial 
	WHERE vLinePlanP.LinePlanID = @LinePlanID AND vLinePlanP.LinePlanAttributeItemID4 NOT IN 
	(SELECT LinePlanAttributeItemID4 FROM pLinePlanBusiness WHERE LinePlanID = @LinePlanID)

END 



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '103', GetDate())

GO

