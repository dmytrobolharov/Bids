IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanRangeCurrentRollup4_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanRangeCurrentRollup4_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LinePlanRangeCurrentRollup4_SELECT](
	@LinePlanIndex varchar(1),
	@LinePlanId varchar(40),
	@LinePlanAttributeItemId1 varchar(40),
	@LinePlanAttributeItemId2 varchar(40),
	@LinePlanAttributeItemId3 varchar(40),
	@LinePlanAttributeItemId4 varchar(40)
)
AS 


DECLARE
	@SLinePlanRange VARCHAR(100),
	@SLinePlanRangeID UNIQUEIDENTIFIER, 
	@FLinePlanRange VARCHAR(100),
	@FLinePlanRangeID UNIQUEIDENTIFIER, 
	@BLinePlanRange VARCHAR(100),
	@BLinePlanRangeID UNIQUEIDENTIFIER ,
	@CLinePlanRange VARCHAR(100),
	@CLinePlanRangeID UNIQUEIDENTIFIER
	

CREATE TABLE #tmpLinePlanRange(
	LinePlanRangeID uniqueidentifier NULL,
	LinePlanID uniqueidentifier NULL,
	LinePlanFinancialID uniqueidentifier NULL,
	LinePlanRange nvarchar(100) NULL,

	LinePlanAttributeItemID1 uniqueidentifier NULL,
	LinePlanAttributeItemID2 uniqueidentifier NULL,
	LinePlanAttributeItemID3 uniqueidentifier NULL,
	LinePlanAttributeItemID4 uniqueidentifier NULL,

	LinePlanRangeDelCO1 int NULL,
	LinePlanRangeDelNV1 int NULL,
	LinePlanRangeDelN1 int NULL,
	LinePlanRangeDelTL1 int NULL,

	LinePlanRangeDelCO2 int NULL,
	LinePlanRangeDelNV2 int NULL,
	LinePlanRangeDelN2 int NULL,
	LinePlanRangeDelTL2 int NULL,

	LinePlanRangeDelCO3 int NULL,
	LinePlanRangeDelNV3 int NULL,
	LinePlanRangeDelN3 int NULL,
	LinePlanRangeDelTL3 int NULL,

	LinePlanRangeDelCO4 int NULL,
	LinePlanRangeDelNV4 int NULL,
	LinePlanRangeDelN4 int NULL,
	LinePlanRangeDelTL4 int NULL,
	
	LinePlanRangeDelCO5 int NULL,
	LinePlanRangeDelNV5 int NULL,
	LinePlanRangeDelN5 int NULL,
	LinePlanRangeDelTL5 int NULL,

	LinePlanRangeDelAVCO int NULL,
	LinePlanRangeDelAVNV int NULL,
	LinePlanRangeDelAVN int NULL,
	LinePlanRangeSort varchar(5) NULL
)


DECLARE @LinePlanRangeID UNIQUEIDENTIFIER



SELECT @LinePlanRangeID =  LinePlanRangeID 
FROM pLinePlanRange WITH(NOLOCK)
WHERE LinePlanAttributeItemId1 = @LinePlanAttributeItemId1
AND LinePlanAttributeItemId2 = @LinePlanAttributeItemId2
AND LinePlanAttributeItemId3 = @LinePlanAttributeItemId3
AND LinePlanAttributeItemId4 = @LinePlanAttributeItemId4
AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'


CREATE TABLE #tmp (
	LinePlanRangeTypeID UNIQUEIDENTIFIER,
	StyleID UNIQUEIDENTIFIER, 
	MaterialID UNIQUEIDENTIFIER, 
	BodyID UNIQUEIDENTIFIER, 
	ColorPaletteID UNIQUEIDENTIFIER, 
	StyleColorDelivery1 INT,
	StyleColorDelivery2 INT, 
	StyleColorDelivery3 INT, 
	StyleColorDelivery4 INT,
	StyleColorDelivery5 INT
)


INSERT INTO #tmp( 
	LinePlanRangeTypeID, StyleID, MaterialID, BodyID, ColorPaletteID,
	StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorDelivery5 )
SELECT e.LinePlanRangeTypeID , c.StyleID , g.MaterialID, h.BodyID, f.ColorPaletteID,
	d.StyleColorDelivery1,d.StyleColorDelivery2, d.StyleColorDelivery3, d.StyleColorDelivery4, d.StyleColorDelivery5
FROM pStyleQuoteItem c  WITH(NOLOCK)
INNER JOIN pStyleSourcing a WITH(NOLOCK) ON a.StyleSourcingID =  c.StyleSourcingID
INNER JOIN pStyleSeasonYear b WITH(NOLOCK) ON b.StyleSeasonYearID = a.StyleSeasonYearID
INNER JOIN pStyleColorwaySeasonYear d WITH(NOLOCK) ON  ( d.StyleSeasonYearID = b.StyleSeasonYearID 
	AND d.StyleColorwayID =  c.StyleColorID )
INNER JOIN pLinePlanItem e WITH(NOLOCK) ON e.LinePlanItemID =  b.LinePlanItemID 
INNER JOIN pStyleColorway f WITH(NOLOCK) ON f.StyleColorID = d.StyleColorwayID 
INNER JOIN pStyleHeader h WITH(NOLOCK) ON h.StyleID = c.StyleID 
LEFT OUTER JOIN pStyleMaterials g WITH(NOLOCK) ON g.StyleID = c.StyleID 
WHERE b.LinePlanItemID  IN ( 
	SELECT a.LinePlanItemID
	FROM pLinePlanItem a WITH(NOLOCK)
	WHERE a.LinePlanID = @LinePlanID
	AND a.StyleID <>  '00000000-0000-0000-0000-000000000000'
	AND a.LinePlanRangeID = @LinePlanRangeID
) 
AND c.StyleQuoteItemStatusID = 3 
AND d.StyleColorStatus = 200
AND b.TradePartnerVendorID IS NOT NULL
AND g.MainMaterial = 1  
ORDER BY e.LinePlanRangeTypeID , c.StyleID



---=======================================================================================================
--- DELIVERY 1 
DECLARE
	@SLinePlanRangeDelCO1 int,	@SLinePlanRangeDelNV1 int,	@SLinePlanRangeDelN1 int,
	@FLinePlanRangeDel1 int,	@BLinePlanRangeDel1 int,	@CLinePlanRangeDel1 int

SELECT @SLinePlanRangeDelCO1 = COUNT(DISTINCT StyleID) FROM #tmp WHERE StyleColorDelivery1 = 1 AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001'
SELECT @SLinePlanRangeDelN1  = COUNT(DISTINCT StyleID) FROM #tmp WHERE StyleColorDelivery1 = 1 AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
SELECT @SLinePlanRangeDelNV1  =  0
SELECT @FLinePlanRangeDel1 = COUNT(DISTINCT MaterialID) FROM #tmp WHERE StyleColorDelivery1 = 1 AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND MaterialID IS NOT NULL
-- **  Comment #01 SELECT @BLinePlanRangeDel1 = COUNT(DISTINCT BodyID) FROM #tmp WHERE StyleColorDelivery1 = 1 AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND BodyID IS NOT NULL
SELECT @CLinePlanRangeDel1 =  COUNT(DISTINCT(ColorPaletteID)) FROM #tmp WHERE StyleColorDelivery1 = 1 AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' )


---  =======================================================================================================
--- DELIVERY 2
DECLARE
	@SLinePlanRangeDelCO2 int,	@SLinePlanRangeDelNV2 int,	@SLinePlanRangeDelN2 int,
	@FLinePlanRangeDel2 int,	@BLinePlanRangeDel2 int,	@CLinePlanRangeDel2 int

SELECT @SLinePlanRangeDelCO2 = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001'
SELECT @SLinePlanRangeDelN2  = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
SELECT @SLinePlanRangeDelNV2  =  0
SELECT @FLinePlanRangeDel2 = COUNT(DISTINCT MaterialID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND MaterialID IS NOT NULL
-- **  Comment #01 SELECT @BLinePlanRangeDel2 = COUNT(DISTINCT BodyID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND BodyID IS NOT NULL
SELECT @CLinePlanRangeDel2 =  COUNT(DISTINCT(ColorPaletteID)) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' )


---  =======================================================================================================
--- DELIVERY 3
DECLARE
	@SLinePlanRangeDelCO3 int,	@SLinePlanRangeDelNV3 int,	@SLinePlanRangeDelN3 int,
	@FLinePlanRangeDel3 int,	@BLinePlanRangeDel3 int,	@CLinePlanRangeDel3 int

SELECT @SLinePlanRangeDelCO3 = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001'
SELECT @SLinePlanRangeDelN3  = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
SELECT @SLinePlanRangeDelNV3  =  0
SELECT @FLinePlanRangeDel3 = COUNT(DISTINCT MaterialID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND MaterialID IS NOT NULL
-- **  Comment #01 SELECT @BLinePlanRangeDel3 = COUNT(DISTINCT BodyID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND BodyID IS NOT NULL
SELECT @CLinePlanRangeDel3 =  COUNT(DISTINCT(ColorPaletteID)) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' )



---  =======================================================================================================
--- DELIVERY 4
DECLARE
	@SLinePlanRangeDelCO4 int,	@SLinePlanRangeDelNV4 int,	@SLinePlanRangeDelN4 int,
	@FLinePlanRangeDel4 int,	@BLinePlanRangeDel4 int,	@CLinePlanRangeDel4 int

SELECT @SLinePlanRangeDelCO4 = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1 OR StyleColorDelivery4 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001'
SELECT @SLinePlanRangeDelN4 = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1 OR StyleColorDelivery4 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
SELECT @SLinePlanRangeDelNV4  =  0
SELECT @FLinePlanRangeDel4 = COUNT(DISTINCT MaterialID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1 OR StyleColorDelivery4 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND MaterialID IS NOT NULL
SELECT @CLinePlanRangeDel4 =  COUNT(DISTINCT(ColorPaletteID)) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1 OR StyleColorDelivery4 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' )


---  =======================================================================================================
--- DELIVERY 5
DECLARE
	@SLinePlanRangeDelCO5 int,	@SLinePlanRangeDelNV5 int,	@SLinePlanRangeDelN5 int,
	@FLinePlanRangeDel5 int,	@BLinePlanRangeDel5 int,	@CLinePlanRangeDel5 int

SELECT @SLinePlanRangeDelCO5 = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1 OR StyleColorDelivery4 = 1 OR StyleColorDelivery5 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001'
SELECT @SLinePlanRangeDelN5 = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1 OR StyleColorDelivery4 = 1 OR StyleColorDelivery5 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
SELECT @SLinePlanRangeDelNV5  =  0
SELECT @FLinePlanRangeDel5 = COUNT(DISTINCT MaterialID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1 OR StyleColorDelivery4 = 1 OR StyleColorDelivery5 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND MaterialID IS NOT NULL
SELECT @CLinePlanRangeDel5 =  COUNT(DISTINCT(ColorPaletteID)) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1 OR StyleColorDelivery4 = 1 OR StyleColorDelivery5 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' )

DROP TABLE  #tmp



	SELECT @SLinePlanRange = LinePlanRange, @SLinePlanRangeID = LinePlanRangeID 
	FROM   pLinePlanRange
	WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'
		AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
		AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
		AND	LinePlanAttributeItemID4 = @LinePlanAttributeItemID4
		AND	LinePlanId = @LinePlanID
	GROUP BY LinePlanID, LinePlanFinancialID, LinePlanRange, LinePlanAttributeItemID1, 
	LinePlanAttributeItemID2, LinePlanAttributeItemID3,LinePlanAttributeItemID4, LinePlanRangeSort, LineplanRangeID

	select @FLinePlanRange = LinePlanRange, @FLinePlanRangeID = LinePlanRangeID 
	FROM   pLinePlanRange
	WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000001'
	AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
	AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
	AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
	AND	LinePlanAttributeItemID4 = @LinePlanAttributeItemID4
	AND	LinePlanId = @LinePlanID
	GROUP BY LinePlanID, LinePlanFinancialID, LinePlanRange, LinePlanAttributeItemID1, 
	LinePlanAttributeItemID2, LinePlanAttributeItemID3, LinePlanAttributeItemID4, LinePlanRangeSort, LineplanRangeID

	select @CLinePlanRange = LinePlanRange, @CLinePlanRangeID = LinePlanRangeID 
	FROM   pLinePlanRange
	WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
	AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
	AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
	AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
	AND	LinePlanAttributeItemID4 = @LinePlanAttributeItemID4
	AND	LinePlanId = @LinePlanID
	GROUP BY LinePlanID, LinePlanFinancialID, LinePlanRange, LinePlanAttributeItemID1, 
	LinePlanAttributeItemID2, LinePlanAttributeItemID3, LinePlanAttributeItemID4, LinePlanRangeSort, LineplanRangeID
	
	




/***
**  Comment #01
***
select @BLinePlanRange = LinePlanRange, @BLinePlanRangeID = LinePlanRangeID 
FROM   pLinePlanRange
WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000003'
AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
AND	LinePlanId = @LinePlanID
GROUP BY LinePlanID, LinePlanFinancialID, LinePlanRange, LinePlanAttributeItemID1, 
LinePlanAttributeItemID2, LinePlanAttributeItemID3, LinePlanRangeSort, LineplanRangeID
*/



INSERT INTO #tmpLinePlanRange (
LinePlanID, LineplanRangeID, LinePlanFinancialID, LinePlanRange, 
LinePlanRangeDelCO1, LinePlanRangeDelNV1, LinePlanRangeDelN1, LinePlanRangeDelTL1, 
LinePlanRangeDelCO2, LinePlanRangeDelNV2, LinePlanRangeDelN2, LinePlanRangeDelTL2, 
LinePlanRangeDelCO3, LinePlanRangeDelNV3, LinePlanRangeDelN3, LinePlanRangeDelTL3, 
LinePlanRangeDelCO4, LinePlanRangeDelNV4, LinePlanRangeDelN4, LinePlanRangeDelTL4,
LinePlanRangeDelCO5, LinePlanRangeDelNV5, LinePlanRangeDelN5, LinePlanRangeDelTL5 )
VALUES (
@LinePlanID,@SLineplanRangeID ,'10000000-0000-0000-0000-000000000004', @SLinePlanRange,
@SLinePlanRangeDelCO1, @SLinePlanRangeDelNV1, @SLinePlanRangeDelN1, @SLinePlanRangeDelCO1+@SLinePlanRangeDelNV1+@SLinePlanRangeDelN1,
@SLinePlanRangeDelCO2, @SLinePlanRangeDelNV2, @SLinePlanRangeDelN2, @SLinePlanRangeDelCO2+@SLinePlanRangeDelNV2+@SLinePlanRangeDelN2,
@SLinePlanRangeDelCO3, @SLinePlanRangeDelNV3, @SLinePlanRangeDelN3, @SLinePlanRangeDelCO3+@SLinePlanRangeDelNV3+@SLinePlanRangeDelN3,
@SLinePlanRangeDelCO4, @SLinePlanRangeDelNV4, @SLinePlanRangeDelN4, @SLinePlanRangeDelCO4+@SLinePlanRangeDelNV4+@SLinePlanRangeDelN4,
@SLinePlanRangeDelCO5, @SLinePlanRangeDelNV5, @SLinePlanRangeDelN5, @SLinePlanRangeDelCO5+@SLinePlanRangeDelNV5+@SLinePlanRangeDelN5 )


INSERT INTO #tmpLinePlanRange (
LinePlanID, LineplanRangeID, LinePlanFinancialID, LinePlanRange, 
LinePlanRangeDelTL1, LinePlanRangeDelTL2, LinePlanRangeDelTL3, LinePlanRangeDelTL4, LinePlanRangeDelTL5 )
VALUES (
@LinePlanID,@FLineplanRangeID ,'10000000-0000-0000-0000-000000000001', @FLinePlanRange,
@FLinePlanRangeDel1, @FLinePlanRangeDel2, @FLinePlanRangeDel3, @FLinePlanRangeDel4, @FLinePlanRangeDel5)

/***
**  Comment #01
***
INSERT INTO #tmpLinePlanRange (
LinePlanID, LineplanRangeID, LinePlanFinancialID, LinePlanRange, 
LinePlanRangeDelTL1, LinePlanRangeDelTL2, LinePlanRangeDelTL3, LinePlanRangeDelTL4 )
VALUES (
@LinePlanID,@BLineplanRangeID ,'10000000-0000-0000-0000-000000000003', @BLinePlanRange,
@BLinePlanRangeDel1, @BLinePlanRangeDel2, @BLinePlanRangeDel3, @BLinePlanRangeDel4
)
*/

INSERT INTO #tmpLinePlanRange (
LinePlanID, LineplanRangeID, LinePlanFinancialID, LinePlanRange, 
LinePlanRangeDelTL1, LinePlanRangeDelTL2, LinePlanRangeDelTL3, LinePlanRangeDelTL4, LinePlanRangeDelTL5 )
VALUES (
@LinePlanID,@CLineplanRangeID ,'10000000-0000-0000-0000-000000000002', @CLinePlanRange,
@CLinePlanRangeDel1, @CLinePlanRangeDel2, @CLinePlanRangeDel3, @CLinePlanRangeDel4, @CLinePlanRangeDel5 )


SELECT #tmpLinePlanRange.*, 
pLinePlanFinancial.LinePlanFinancialDataType, 
pLinePlanFinancial.LinePlanFinancialDataFormat, 
pLinePlanFinancial.LinePlanFinancialCssClass
FROM #tmpLinePlanRange 
INNER JOIN pLinePlanFinancial ON #tmpLinePlanRange.LinePlanFinancialID = pLinePlanFinancial.LinePlanFinancialID


DROP TABLE #tmpLinePlanRange








