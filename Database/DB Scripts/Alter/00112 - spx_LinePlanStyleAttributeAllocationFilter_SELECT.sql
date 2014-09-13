
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyleAttributeAllocationFilter_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanStyleAttributeAllocationFilter_SELECT]
GO



CREATE PROCEDURE [dbo].[spx_LinePlanStyleAttributeAllocationFilter_SELECT]
(
@LinePlanId varchar(50),
@LinePlanIndex VARCHAR (1) , 
@LinePlanAttributeItemId1 UNIQUEIDENTIFIER, 
@LinePlanAttributeItemId2 UNIQUEIDENTIFIER, 
@LinePlanAttributeItemId3 UNIQUEIDENTIFIER, 
@LinePlanAttributeItemId4 UNIQUEIDENTIFIER,
@LinePlanStyleAttributeID varchar(50)
)
AS 

DECLARE @Index INT 
DECLARE @LinePlanTemplateID  UNIQUEIDENTIFIER 
SELECT @LinePlanTemplateID = LinePlanTemplateID  FROM pLinePlan WHERE LinePlanID = @LinePlanId
SELECT @Index = COUNT(*) FROM pLinePlanTemplateItem WHERE LinePlanTemplateID = @LinePlanTemplateID

IF @Index = 3
BEGIN 
	IF @LinePlanIndex  = '0' 
	BEGIN 
		SELECT pLinePlanRange.LinePlanRangeID, 
		pLinePlanAttributeItem_1.LinePlanAttributeItemID AS LinePlanAttributeItemID1, 
		pLinePlanAttributeItem_2.LinePlanAttributeItemID AS LinePlanAttributeItemID2, 
		pLinePlanAttributeItem_3.LinePlanAttributeItemID AS LinePlanAttributeItemID3, 
		pLinePlanAttributeItem_4.LinePlanAttributeItemID AS LinePlanAttributeItemID4, 
		pLinePlanAttributeItem_1.LinePlanAttributeText AS LinePlanAttributeHeader1, 
		pLinePlanAttributeItem_2.LinePlanAttributeText AS LinePlanAttributeHeader2, 
		pLinePlanAttributeItem_3.LinePlanAttributeText AS LinePlanAttributeHeader3, 
		pLinePlanAttributeItem_4.LinePlanAttributeText AS LinePlanAttributeHeader4
		FROM dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_3 
		RIGHT OUTER JOIN  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_1 
		RIGHT OUTER JOIN  dbo.pLinePlanRange ON pLinePlanAttributeItem_1.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID1 
		LEFT OUTER JOIN	dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_2 ON dbo.pLinePlanRange.LinePlanAttributeItemID2 = pLinePlanAttributeItem_2.LinePlanAttributeItemID ON 
		  pLinePlanAttributeItem_3.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID3 
		 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_4 ON dbo.pLinePlanRange.LinePlanAttributeItemID4 = pLinePlanAttributeItem_4.LinePlanAttributeItemID
		WHERE pLinePlanAttributeItem_1.LinePlanID = @LinePlanID AND 
		pLinePlanRange.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004' AND 
			pLinePlanRange.LinePlanRangeID NOT IN (
				SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID

			) 
		ORDER BY LinePlanAttributeHeader1, LinePlanAttributeHeader2, LinePlanAttributeHeader3, LinePlanAttributeHeader4
	END
	ELSE IF @LinePlanIndex  = '1' 
	BEGIN 

		SELECT pLinePlanRange.LinePlanRangeID, pLinePlanAttributeItem_1.LinePlanAttributeItemID AS LinePlanAttributeItemID1, 
		  pLinePlanAttributeItem_2.LinePlanAttributeItemID AS LinePlanAttributeItemID2, pLinePlanAttributeItem_3.LinePlanAttributeItemID AS LinePlanAttributeItemID3, 
		  pLinePlanAttributeItem_4.LinePlanAttributeItemID AS LinePlanAttributeItemID4, pLinePlanAttributeItem_1.LinePlanAttributeText AS LinePlanAttributeHeader1, 
		  pLinePlanAttributeItem_2.LinePlanAttributeText AS LinePlanAttributeHeader2, pLinePlanAttributeItem_3.LinePlanAttributeText AS LinePlanAttributeHeader3, 
		  pLinePlanAttributeItem_4.LinePlanAttributeText AS LinePlanAttributeHeader4
		FROM dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_3 RIGHT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_1 RIGHT OUTER JOIN
		  dbo.pLinePlanRange ON pLinePlanAttributeItem_1.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID1 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_2 ON dbo.pLinePlanRange.LinePlanAttributeItemID2 = pLinePlanAttributeItem_2.LinePlanAttributeItemID ON 
		  pLinePlanAttributeItem_3.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID3 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_4 ON dbo.pLinePlanRange.LinePlanAttributeItemID4 = pLinePlanAttributeItem_4.LinePlanAttributeItemID
		WHERE pLinePlanAttributeItem_1.LinePlanID = @LinePlanID 
		AND pLinePlanRange.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004' AND 
			pLinePlanRange.LinePlanRangeID NOT IN (
				SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
			) 
		AND pLinePlanAttributeItem_1.LinePlanAttributeItemID  = @LinePlanAttributeItemId1
		ORDER BY LinePlanAttributeHeader1, LinePlanAttributeHeader2, LinePlanAttributeHeader3, LinePlanAttributeHeader4

	END 
	ELSE IF @LinePlanIndex  = '2' 
	BEGIN 

		SELECT pLinePlanRange.LinePlanRangeID, pLinePlanAttributeItem_1.LinePlanAttributeItemID AS LinePlanAttributeItemID1, 
		  pLinePlanAttributeItem_2.LinePlanAttributeItemID AS LinePlanAttributeItemID2, pLinePlanAttributeItem_3.LinePlanAttributeItemID AS LinePlanAttributeItemID3, 
		  pLinePlanAttributeItem_4.LinePlanAttributeItemID AS LinePlanAttributeItemID4, pLinePlanAttributeItem_1.LinePlanAttributeText AS LinePlanAttributeHeader1, 
		  pLinePlanAttributeItem_2.LinePlanAttributeText AS LinePlanAttributeHeader2, pLinePlanAttributeItem_3.LinePlanAttributeText AS LinePlanAttributeHeader3, 
		  pLinePlanAttributeItem_4.LinePlanAttributeText AS LinePlanAttributeHeader4
		FROM dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_3 RIGHT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_1 RIGHT OUTER JOIN
		  dbo.pLinePlanRange ON pLinePlanAttributeItem_1.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID1 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_2 ON dbo.pLinePlanRange.LinePlanAttributeItemID2 = pLinePlanAttributeItem_2.LinePlanAttributeItemID ON 
		  pLinePlanAttributeItem_3.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID3 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_4 ON dbo.pLinePlanRange.LinePlanAttributeItemID4 = pLinePlanAttributeItem_4.LinePlanAttributeItemID
		WHERE pLinePlanAttributeItem_1.LinePlanID = @LinePlanID 
		AND pLinePlanRange.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004' AND 
			pLinePlanRange.LinePlanRangeID NOT IN (
				SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
			) 
		AND pLinePlanAttributeItem_1.LinePlanAttributeItemID  = @LinePlanAttributeItemId1
		AND pLinePlanAttributeItem_2.LinePlanAttributeItemID  = @LinePlanAttributeItemId2
		ORDER BY LinePlanAttributeHeader1, LinePlanAttributeHeader2, LinePlanAttributeHeader3, LinePlanAttributeHeader4

	END 
	ELSE IF @LinePlanIndex  = '3' 
	BEGIN 

		SELECT pLinePlanRange.LinePlanRangeID, pLinePlanAttributeItem_1.LinePlanAttributeItemID AS LinePlanAttributeItemID1, 
		  pLinePlanAttributeItem_2.LinePlanAttributeItemID AS LinePlanAttributeItemID2, pLinePlanAttributeItem_3.LinePlanAttributeItemID AS LinePlanAttributeItemID3, 
		  pLinePlanAttributeItem_4.LinePlanAttributeItemID AS LinePlanAttributeItemID4, pLinePlanAttributeItem_1.LinePlanAttributeText AS LinePlanAttributeHeader1, 
		  pLinePlanAttributeItem_2.LinePlanAttributeText AS LinePlanAttributeHeader2, pLinePlanAttributeItem_3.LinePlanAttributeText AS LinePlanAttributeHeader3, 
		  pLinePlanAttributeItem_4.LinePlanAttributeText AS LinePlanAttributeHeader4
		FROM dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_3 RIGHT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_1 RIGHT OUTER JOIN
		  dbo.pLinePlanRange ON pLinePlanAttributeItem_1.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID1 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_2 ON dbo.pLinePlanRange.LinePlanAttributeItemID2 = pLinePlanAttributeItem_2.LinePlanAttributeItemID ON 
		  pLinePlanAttributeItem_3.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID3 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_4 ON dbo.pLinePlanRange.LinePlanAttributeItemID4 = pLinePlanAttributeItem_4.LinePlanAttributeItemID
		WHERE pLinePlanAttributeItem_1.LinePlanID = @LinePlanID 
		AND pLinePlanRange.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004' AND 
			pLinePlanRange.LinePlanRangeID NOT IN (
				SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
			) 
		AND pLinePlanAttributeItem_1.LinePlanAttributeItemID  = @LinePlanAttributeItemId1
		AND pLinePlanAttributeItem_2.LinePlanAttributeItemID  = @LinePlanAttributeItemId2
		AND pLinePlanAttributeItem_3.LinePlanAttributeItemID  = @LinePlanAttributeItemId3
		ORDER BY LinePlanAttributeHeader1, LinePlanAttributeHeader2, LinePlanAttributeHeader3, LinePlanAttributeHeader4

	END 
END 
ELSE IF @Index = 4 
BEGIN
	--***
	--** INDEX =  4 
	--***

	IF @LinePlanIndex = '0' 
	BEGIN
		SELECT 
		a.LinePlanRangeID, 
		a.LinePlanAttributeItemID1, a.LinePlanAttributeItemID2, a.LinePlanAttributeItemID3,a.LinePlanAttributeItemID4, 
		a1.LinePlanAttributeText AS LinePlanAttributeHeader1, a2.LinePlanAttributeText AS LinePlanAttributeHeader2,
		a3.LinePlanAttributeText AS LinePlanAttributeHeader3,a4.LinePlanAttributeText AS LinePlanAttributeHeader4
		FROM pLinePlanRange a
		INNER JOIN pLinePlanAttributeItem a1 ON a1.LinePlanAttributeItemID = a.LinePlanAttributeItemID1
		INNER JOIN pLinePlanAttributeItem a2 ON a2.LinePlanAttributeItemID = a.LinePlanAttributeItemID2
		INNER JOIN pLinePlanAttributeItem a3 ON a3.LinePlanAttributeItemID = a.LinePlanAttributeItemID3
		INNER JOIN pLinePlanAttributeItem a4 ON a4.LinePlanAttributeItemID = a.LinePlanAttributeItemID4
		AND a.LinePlanID = @LinePlanID
		AND a.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004' 
		AND a.LinePlanRangeID NOT IN (
			SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
		) 
	END 
	ELSE IF @LinePlanIndex = '1'
	BEGIN
		SELECT 
		a.LinePlanRangeID, 
		a.LinePlanAttributeItemID1, a.LinePlanAttributeItemID2, a.LinePlanAttributeItemID3,a.LinePlanAttributeItemID4, 
		a1.LinePlanAttributeText AS LinePlanAttributeHeader1, a2.LinePlanAttributeText AS LinePlanAttributeHeader2,
		a3.LinePlanAttributeText AS LinePlanAttributeHeader3,a4.LinePlanAttributeText AS LinePlanAttributeHeader4
		FROM pLinePlanRange a
		INNER JOIN pLinePlanAttributeItem a1 ON a1.LinePlanAttributeItemID = a.LinePlanAttributeItemID1
		INNER JOIN pLinePlanAttributeItem a2 ON a2.LinePlanAttributeItemID = a.LinePlanAttributeItemID2
		INNER JOIN pLinePlanAttributeItem a3 ON a3.LinePlanAttributeItemID = a.LinePlanAttributeItemID3
		INNER JOIN pLinePlanAttributeItem a4 ON a4.LinePlanAttributeItemID = a.LinePlanAttributeItemID4
		AND a.LinePlanID = @LinePlanID
		AND a.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004' 
		AND a.LinePlanRangeID NOT IN (
			SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
		) 
		AND a.LinePlanAttributeItemID1 =  @LinePlanAttributeItemId1	
	END 
	ELSE IF @LinePlanIndex = '2'
	BEGIN
		SELECT 
		a.LinePlanRangeID, 
		a.LinePlanAttributeItemID1, a.LinePlanAttributeItemID2, a.LinePlanAttributeItemID3,a.LinePlanAttributeItemID4, 
		a1.LinePlanAttributeText AS LinePlanAttributeHeader1, a2.LinePlanAttributeText AS LinePlanAttributeHeader2,
		a3.LinePlanAttributeText AS LinePlanAttributeHeader3,a4.LinePlanAttributeText AS LinePlanAttributeHeader4
		FROM pLinePlanRange a
		INNER JOIN pLinePlanAttributeItem a1 ON a1.LinePlanAttributeItemID = a.LinePlanAttributeItemID1
		INNER JOIN pLinePlanAttributeItem a2 ON a2.LinePlanAttributeItemID = a.LinePlanAttributeItemID2
		INNER JOIN pLinePlanAttributeItem a3 ON a3.LinePlanAttributeItemID = a.LinePlanAttributeItemID3
		INNER JOIN pLinePlanAttributeItem a4 ON a4.LinePlanAttributeItemID = a.LinePlanAttributeItemID4
		AND a.LinePlanID = @LinePlanID
		AND a.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004' 
		AND a.LinePlanRangeID NOT IN (
			SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
		) 
		AND a.LinePlanAttributeItemID1 =  @LinePlanAttributeItemId1	
		AND a.LinePlanAttributeItemID2 =  @LinePlanAttributeItemId2	
	END 
	ELSE IF @LinePlanIndex = '3'
	BEGIN
		SELECT 
		a.LinePlanRangeID, 
		a.LinePlanAttributeItemID1, a.LinePlanAttributeItemID2, a.LinePlanAttributeItemID3,a.LinePlanAttributeItemID4, 
		a1.LinePlanAttributeText AS LinePlanAttributeHeader1, a2.LinePlanAttributeText AS LinePlanAttributeHeader2,
		a3.LinePlanAttributeText AS LinePlanAttributeHeader3,a4.LinePlanAttributeText AS LinePlanAttributeHeader4
		FROM pLinePlanRange a
		INNER JOIN pLinePlanAttributeItem a1 ON a1.LinePlanAttributeItemID = a.LinePlanAttributeItemID1
		INNER JOIN pLinePlanAttributeItem a2 ON a2.LinePlanAttributeItemID = a.LinePlanAttributeItemID2
		INNER JOIN pLinePlanAttributeItem a3 ON a3.LinePlanAttributeItemID = a.LinePlanAttributeItemID3
		INNER JOIN pLinePlanAttributeItem a4 ON a4.LinePlanAttributeItemID = a.LinePlanAttributeItemID4
		AND a.LinePlanID = @LinePlanID
		AND a.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004' 
		AND a.LinePlanRangeID NOT IN (
			SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
		) 
		AND a.LinePlanAttributeItemID1 =  @LinePlanAttributeItemId1	
		AND a.LinePlanAttributeItemID2 =  @LinePlanAttributeItemId2	
		AND a.LinePlanAttributeItemID3 =  @LinePlanAttributeItemId3
	END 
	ELSE IF @LinePlanIndex = '4'
	BEGIN
		SELECT 
		a.LinePlanRangeID, 
		a.LinePlanAttributeItemID1, a.LinePlanAttributeItemID2, a.LinePlanAttributeItemID3,a.LinePlanAttributeItemID4, 
		a1.LinePlanAttributeText AS LinePlanAttributeHeader1, a2.LinePlanAttributeText AS LinePlanAttributeHeader2,
		a3.LinePlanAttributeText AS LinePlanAttributeHeader3, a4.LinePlanAttributeText AS LinePlanAttributeHeader4
		FROM pLinePlanRange a
		INNER JOIN pLinePlanAttributeItem a1 ON a1.LinePlanAttributeItemID = a.LinePlanAttributeItemID1
		INNER JOIN pLinePlanAttributeItem a2 ON a2.LinePlanAttributeItemID = a.LinePlanAttributeItemID2
		INNER JOIN pLinePlanAttributeItem a3 ON a3.LinePlanAttributeItemID = a.LinePlanAttributeItemID3
		INNER JOIN pLinePlanAttributeItem a4 ON a4.LinePlanAttributeItemID = a.LinePlanAttributeItemID4
		AND a.LinePlanID = @LinePlanID
		AND a.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004' 
		AND a.LinePlanRangeID NOT IN (
			SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
		) 
		AND a.LinePlanAttributeItemID1 =  @LinePlanAttributeItemId1	
		AND a.LinePlanAttributeItemID2 =  @LinePlanAttributeItemId2	
		AND a.LinePlanAttributeItemID3 =  @LinePlanAttributeItemId3
		AND a.LinePlanAttributeItemID4 =  @LinePlanAttributeItemId4
	END 
	
	
END 	 -- ELSE index = 4 
	




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '112', GetDate())

GO
