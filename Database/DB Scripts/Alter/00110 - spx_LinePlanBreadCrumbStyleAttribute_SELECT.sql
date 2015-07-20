IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanBreadCrumbStyleAttribute_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanBreadCrumbStyleAttribute_SELECT]
GO



CREATE PROCEDURE  [dbo].[spx_LinePlanBreadCrumbStyleAttribute_SELECT] (
@LinePlanId UNIQUEIDENTIFIER, 
@LinePlanIndex VARCHAR (1) , 
@LinePlanAttributeItemId1 UNIQUEIDENTIFIER, 
@LinePlanAttributeItemId2 UNIQUEIDENTIFIER, 
@LinePlanAttributeItemId3 UNIQUEIDENTIFIER, 
@LinePlanAttributeItemId4 UNIQUEIDENTIFIER,
@LinePlanStyleAttributeID UNIQUEIDENTIFIER
)
AS 



DECLARE @Index INT 
DECLARE @LinePlanTemplateID  UNIQUEIDENTIFIER 
SELECT @LinePlanTemplateID = LinePlanTemplateID  FROM pLinePlan WHERE LinePlanID = @LinePlanId
SELECT @Index = COUNT(*) FROM pLinePlanTemplateItem WHERE LinePlanTemplateID = @LinePlanTemplateID

IF @Index = 3
BEGIN 


	IF @LinePlanIndex = '1' 
	BEGIN

		SELECT '00000000-0000-0000-0000-000000000001' AS LinePlanAttributeItemID, '' AS LinePlanAttributeText
		UNION 
		(SELECT  pLinePlanAttributeItem_1.LinePlanAttributeItemID , 
			pLinePlanAttributeItem_1.LinePlanAttributeText 
		FROM dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_3 RIGHT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_1 RIGHT OUTER JOIN
		  dbo.pLinePlanRange ON pLinePlanAttributeItem_1.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID1 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_2 ON dbo.pLinePlanRange.LinePlanAttributeItemID2 = pLinePlanAttributeItem_2.LinePlanAttributeItemID ON 
		  pLinePlanAttributeItem_3.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID3 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_4 ON dbo.pLinePlanRange.LinePlanAttributeItemID4 = pLinePlanAttributeItem_4.LinePlanAttributeItemID
		WHERE pLinePlanAttributeItem_1.LinePlanID = @LinePlanId
		AND pLinePlanRange.LinePlanFinancialID = '10000000-0000-0000-0000-000000000001' 
		AND pLinePlanRange.LinePlanRangeID NOT IN (
			SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
		) 
		GROUP BY pLinePlanAttributeItem_1.LinePlanAttributeItemID  , pLinePlanAttributeItem_1.LinePlanAttributeText 
		)
		ORDER BY LinePlanAttributeText

	END
	ELSE IF @LinePlanIndex = '2'
	BEGIN

		SELECT '00000000-0000-0000-0000-000000000002' AS LinePlanAttributeItemID, '' AS LinePlanAttributeText
		UNION 
		(SELECT  pLinePlanAttributeItem_2.LinePlanAttributeItemID ,
			pLinePlanAttributeItem_2.LinePlanAttributeText 
		FROM dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_3 RIGHT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_1 RIGHT OUTER JOIN
		  dbo.pLinePlanRange ON pLinePlanAttributeItem_1.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID1 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_2 ON dbo.pLinePlanRange.LinePlanAttributeItemID2 = pLinePlanAttributeItem_2.LinePlanAttributeItemID ON 
		  pLinePlanAttributeItem_3.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID3 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_4 ON dbo.pLinePlanRange.LinePlanAttributeItemID4 = pLinePlanAttributeItem_4.LinePlanAttributeItemID
		WHERE pLinePlanAttributeItem_1.LinePlanID = @LinePlanId
		AND pLinePlanRange.LinePlanFinancialID = '10000000-0000-0000-0000-000000000001' 
		AND pLinePlanRange.LinePlanRangeID NOT IN (
			SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
		) 
		AND pLinePlanAttributeItem_1.LinePlanAttributeItemID  = @LinePlanAttributeItemId1
		GROUP BY pLinePlanAttributeItem_2.LinePlanAttributeItemID  , pLinePlanAttributeItem_2.LinePlanAttributeText 
		)
		ORDER BY LinePlanAttributeText

	END 
	ELSE IF @LinePlanIndex = '3'
	BEGIN

		SELECT '00000000-0000-0000-0000-000000000003' AS LinePlanAttributeItemID, '' AS LinePlanAttributeText
		UNION 
		(SELECT  pLinePlanAttributeItem_3.LinePlanAttributeItemID ,
			pLinePlanAttributeItem_3.LinePlanAttributeText 
		FROM dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_3 RIGHT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_1 RIGHT OUTER JOIN
		  dbo.pLinePlanRange ON pLinePlanAttributeItem_1.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID1 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_2 ON dbo.pLinePlanRange.LinePlanAttributeItemID2 = pLinePlanAttributeItem_2.LinePlanAttributeItemID ON 
		  pLinePlanAttributeItem_3.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID3 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_4 ON dbo.pLinePlanRange.LinePlanAttributeItemID4 = pLinePlanAttributeItem_4.LinePlanAttributeItemID
		WHERE pLinePlanAttributeItem_1.LinePlanID = @LinePlanId
		AND pLinePlanRange.LinePlanFinancialID = '10000000-0000-0000-0000-000000000001' 
		AND pLinePlanRange.LinePlanRangeID NOT IN (
			SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
		) 
		AND pLinePlanAttributeItem_1.LinePlanAttributeItemID  = @LinePlanAttributeItemId1
		AND pLinePlanAttributeItem_2.LinePlanAttributeItemID  = @LinePlanAttributeItemId2
		GROUP BY pLinePlanAttributeItem_3.LinePlanAttributeItemID  , pLinePlanAttributeItem_3.LinePlanAttributeText 
		)
		ORDER BY LinePlanAttributeText

	END 
	ELSE IF @LinePlanIndex = '4'
	BEGIN

		SELECT '00000000-0000-0000-0000-000000000004' AS LinePlanAttributeItemID, '' AS LinePlanAttributeText
		UNION 
		(SELECT  pLinePlanAttributeItem_4.LinePlanAttributeItemID ,
			pLinePlanAttributeItem_4.LinePlanAttributeText 
		FROM dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_3 RIGHT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_1 RIGHT OUTER JOIN
		  dbo.pLinePlanRange ON pLinePlanAttributeItem_1.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID1 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_2 ON dbo.pLinePlanRange.LinePlanAttributeItemID2 = pLinePlanAttributeItem_2.LinePlanAttributeItemID ON 
		  pLinePlanAttributeItem_3.LinePlanAttributeItemID = dbo.pLinePlanRange.LinePlanAttributeItemID3 LEFT OUTER JOIN
		  dbo.pLinePlanAttributeItem AS pLinePlanAttributeItem_4 ON dbo.pLinePlanRange.LinePlanAttributeItemID4 = pLinePlanAttributeItem_4.LinePlanAttributeItemID
		WHERE pLinePlanAttributeItem_1.LinePlanID = @LinePlanId
		AND pLinePlanRange.LinePlanFinancialID = '10000000-0000-0000-0000-000000000001' 
		AND pLinePlanRange.LinePlanRangeID NOT IN (
			SELECT LinePlanRangeID FROM pLinePlanStyleAttributeItem WHERE LinePlanStyleAttributeID = @LinePlanStyleAttributeID
		) 
		AND pLinePlanAttributeItem_1.LinePlanAttributeItemID  = @LinePlanAttributeItemId1
		AND pLinePlanAttributeItem_2.LinePlanAttributeItemID  = @LinePlanAttributeItemId2
		AND pLinePlanAttributeItem_3.LinePlanAttributeItemID  = @LinePlanAttributeItemId3
		GROUP BY pLinePlanAttributeItem_4.LinePlanAttributeItemID  , pLinePlanAttributeItem_4.LinePlanAttributeText 
		)
		ORDER BY LinePlanAttributeText

	END 

END
ELSE IF @Index = 4 
BEGIN


	IF @LinePlanIndex = '1' 
	BEGIN

		SELECT '00000000-0000-0000-0000-000000000001' AS LinePlanAttributeItemID, '' AS LinePlanAttributeText
		UNION (
			SELECT 
			a.LinePlanAttributeItemID1, a1.LinePlanAttributeText 
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
			GROUP BY a.LinePlanAttributeItemID1, a1.LinePlanAttributeText 		
		)
		ORDER BY LinePlanAttributeText
		
	END
	ELSE IF @LinePlanIndex = '2' 
	BEGIN

		SELECT '00000000-0000-0000-0000-000000000002' AS LinePlanAttributeItemID, '' AS LinePlanAttributeText
		UNION (
			SELECT 
			a.LinePlanAttributeItemID2, a2.LinePlanAttributeText 
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
			AND a.LinePlanAttributeItemID1 = @LinePlanAttributeItemId1
			GROUP BY a.LinePlanAttributeItemID2, a2.LinePlanAttributeText 		
		)
		ORDER BY LinePlanAttributeText
	END
	ELSE IF @LinePlanIndex = '3' 
	BEGIN

		SELECT '00000000-0000-0000-0000-000000000003' AS LinePlanAttributeItemID, '' AS LinePlanAttributeText
		UNION (
			SELECT 
			a.LinePlanAttributeItemID3, a3.LinePlanAttributeText 
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
			AND a.LinePlanAttributeItemID1 = @LinePlanAttributeItemId1
			AND a.LinePlanAttributeItemID2 = @LinePlanAttributeItemId2
			GROUP BY a.LinePlanAttributeItemID3, a3.LinePlanAttributeText 		
		)
		ORDER BY LinePlanAttributeText
	END
	ELSE IF @LinePlanIndex = '4' 
	BEGIN

		SELECT '00000000-0000-0000-0000-000000000004' AS LinePlanAttributeItemID, '' AS LinePlanAttributeText
		UNION (
			SELECT 
			a.LinePlanAttributeItemID4, a4.LinePlanAttributeText 
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
			AND a.LinePlanAttributeItemID1 = @LinePlanAttributeItemId1
			AND a.LinePlanAttributeItemID2 = @LinePlanAttributeItemId2
			AND a.LinePlanAttributeItemID3 = @LinePlanAttributeItemId3
			GROUP BY a.LinePlanAttributeItemID4, a4.LinePlanAttributeText 		
		)
		ORDER BY LinePlanAttributeText
	END
	

END 



GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '110', GetDate())

GO

