/****** Object:  StoredProcedure [dbo].[spx_LinePlanRangeCurrentRollup3_SELECT]    Script Date: 03/01/2012 14:29:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanRangeCurrentRollup3_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanRangeCurrentRollup3_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanRangeCurrentRollup3_SELECT]    Script Date: 03/01/2012 14:29:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LinePlanRangeCurrentRollup3_SELECT]
(
@LinePlanIndex varchar(1),
@LinePlanId varchar(40),
@LinePlanAttributeItemId1 varchar(40),
@LinePlanAttributeItemId2 varchar(40),
@LinePlanAttributeItemId3 varchar(40)
)
AS 


DECLARE
	@SLinePlanRangeDelCO4 int,
	@SLinePlanRangeDelNV4 int,
	@SLinePlanRangeDelN4 int,
	@FLinePlanRangeDel4 int,
	@BLinePlanRangeDel4 int,
	@CLinePlanRangeDel4 int,
	
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

	LinePlanRangeDelAVCO int NULL,
	LinePlanRangeDelAVNV int NULL,
	LinePlanRangeDelAVN int NULL,
	LinePlanRangeSort varchar(5) NULL
)


SET @SLinePlanRangeDelCO4 = 0 
SET @SLinePlanRangeDelNV4 = 0 
SET @SLinePlanRangeDelN4 = 0 
SET @FLinePlanRangeDel4 = 0 
SET @BLinePlanRangeDel4 = 0 
SET @CLinePlanRangeDel4 = 0 

DECLARE @LinePlanRangeID UNIQUEIDENTIFIER

SELECT @LinePlanRangeID =  LinePlanRangeID FROM pLinePlanRange 
WHERE LinePlanAttributeItemId1 = @LinePlanAttributeItemId1
AND LinePlanAttributeItemId2 = @LinePlanAttributeItemId2
AND LinePlanAttributeItemId3 = @LinePlanAttributeItemId3
AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'


SELECT b.MostLikelyVendor, b.TradePartnerVendorID, e.LinePlanRangeTypeID , c.StyleID , g.MaterialID, h.BodyID, -- c.StyleSourcingID , c.StyleColorID , 
f.ColorPaletteID,
d.StyleColorDelivery1,d.StyleColorDelivery2, d.StyleColorDelivery3, d.StyleColorDelivery4
INTO #tmp
FROM pStyleQuoteItem c 
INNER JOIN pStyleSourcing a ON a.StyleSourcingID =  c.StyleSourcingID
INNER JOIN pStyleSeasonYear b ON b.StyleSeasonYearID = a.StyleSeasonYearID
INNER JOIN pStyleColorwaySeasonYear d ON  ( d.StyleSeasonYearID = b.StyleSeasonYearID AND d.StyleColorwayID =  c.StyleColorID )
INNER JOIN pLinePlanItem e ON e.LinePlanItemID =  b.LinePlanItemID 
INNER JOIN pStyleColorway f ON f.StyleColorID = d.StyleColorwayID 
INNER JOIN pStyleHeader h ON h.StyleID = c.StyleID 
LEFT OUTER JOIN pStyleMaterials g ON g.StyleID = c.StyleID 
WHERE b.LinePlanItemID  IN ( 
	SELECT a.LinePlanItemID
	FROM pLinePlanItem a
	WHERE a.LinePlanID = @LinePlanID
	AND a.StyleID <>  '00000000-0000-0000-0000-000000000000'
	AND a.LinePlanRangeID = @LinePlanRangeID
) 
-- AND c.StyleQuoteItemStatusID = 3 -- styles with unapproved quotes will popup in "actual styles"
-- AND d.StyleColorStatus = 200
AND b.TradePartnerVendorID IS NOT NULL
AND g.MainMaterial = 1  
ORDER BY e.LinePlanRangeTypeID , c.StyleID



---  =======================================================================================================
--- DELIVERY 1 
DECLARE
	@SLinePlanRangeDelCO1 int,	@SLinePlanRangeDelNV1 int,	@SLinePlanRangeDelN1 int,
	@FLinePlanRangeDel1 int,	@BLinePlanRangeDel1 int,	@CLinePlanRangeDel1 int



SELECT @SLinePlanRangeDelCO1 = COUNT(DISTINCT StyleID) FROM #tmp WHERE StyleColorDelivery1 = 1 AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001'
SELECT @SLinePlanRangeDelN1  = COUNT(DISTINCT StyleID) FROM #tmp WHERE StyleColorDelivery1 = 1 AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
SELECT @SLinePlanRangeDelNV1  =  0
SELECT @FLinePlanRangeDel1 = COUNT(DISTINCT MaterialID) FROM #tmp WHERE StyleColorDelivery1 = 1 AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND MaterialID IS NOT NULL
SELECT @BLinePlanRangeDel1 = COUNT(DISTINCT BodyID) FROM #tmp WHERE StyleColorDelivery1 = 1 AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND BodyID IS NOT NULL
SELECT @CLinePlanRangeDel1 =  COUNT(DISTINCT(ColorPaletteID)) FROM #tmp WHERE StyleColorDelivery1 = 1 AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' )


/*
SELECT @SLinePlanRangeDelCO1 AS SLinePlanRangeDelCO1,
@SLinePlanRangeDelN1  AS SLinePlanRangeDelN1 ,
@FLinePlanRangeDel1 AS FLinePlanRangeDel1,
@BLinePlanRangeDel1  AS BLinePlanRangeDel1,
@CLinePlanRangeDel1  AS CLinePlanRangeDel1 
*/

---  =======================================================================================================
--- DELIVERY 2
DECLARE
	@SLinePlanRangeDelCO2 int,	@SLinePlanRangeDelNV2 int,	@SLinePlanRangeDelN2 int,
	@FLinePlanRangeDel2 int,	@BLinePlanRangeDel2 int,	@CLinePlanRangeDel2 int

SELECT @SLinePlanRangeDelCO2 = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001'
SELECT @SLinePlanRangeDelN2  = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
SELECT @SLinePlanRangeDelNV2  =  0
SELECT @FLinePlanRangeDel2 = COUNT(DISTINCT MaterialID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND MaterialID IS NOT NULL
SELECT @BLinePlanRangeDel2 = COUNT(DISTINCT BodyID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND BodyID IS NOT NULL
SELECT @CLinePlanRangeDel2 =  COUNT(DISTINCT(ColorPaletteID)) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' )

/*
SELECT @SLinePlanRangeDelCO2 AS SLinePlanRangeDelCO2,
@SLinePlanRangeDelN2  AS SLinePlanRangeDelN2 ,
@FLinePlanRangeDel2 AS FLinePlanRangeDel2,
@BLinePlanRangeDel2  AS BLinePlanRangeDel2,
@CLinePlanRangeDel2  AS CLinePlanRangeDel2 
*/


---  =======================================================================================================
--- DELIVERY 3
DECLARE
	@SLinePlanRangeDelCO3 int,	@SLinePlanRangeDelNV3 int,	@SLinePlanRangeDelN3 int,
	@FLinePlanRangeDel3 int,	@BLinePlanRangeDel3 int,	@CLinePlanRangeDel3 int

SELECT @SLinePlanRangeDelCO3 = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001'
SELECT @SLinePlanRangeDelN3  = COUNT(DISTINCT StyleID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1) AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
SELECT @SLinePlanRangeDelNV3  =  0
SELECT @FLinePlanRangeDel3 = COUNT(DISTINCT MaterialID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND MaterialID IS NOT NULL
SELECT @BLinePlanRangeDel3 = COUNT(DISTINCT BodyID) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' ) AND BodyID IS NOT NULL
SELECT @CLinePlanRangeDel3 =  COUNT(DISTINCT(ColorPaletteID)) FROM #tmp WHERE (StyleColorDelivery1 = 1 OR StyleColorDelivery2 = 1 OR StyleColorDelivery3 = 1) AND ( LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001' OR LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003' )

/*
SELECT @SLinePlanRangeDelCO3 AS SLinePlanRangeDelCO3,
@SLinePlanRangeDelN3  AS SLinePlanRangeDelN3 ,
@FLinePlanRangeDel3 AS FLinePlanRangeDel3,
@BLinePlanRangeDel3  AS BLinePlanRangeDel3,
@CLinePlanRangeDel3  AS CLinePlanRangeDel3 
*/


DROP TABLE  #tmp


SELECT @SLinePlanRange = LinePlanRange, @SLinePlanRangeID = LinePlanRangeID 
FROM   pLinePlanRange
WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'
AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
AND	LinePlanId = @LinePlanID
GROUP BY LinePlanID, LinePlanFinancialID, LinePlanRange, LinePlanAttributeItemID1, 
LinePlanAttributeItemID2, LinePlanAttributeItemID3, LinePlanRangeSort, LineplanRangeID


select @FLinePlanRange = LinePlanRange, @FLinePlanRangeID = LinePlanRangeID 
FROM   pLinePlanRange
WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000001'
AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
AND	LinePlanId = @LinePlanID
GROUP BY LinePlanID, LinePlanFinancialID, LinePlanRange, LinePlanAttributeItemID1, 
LinePlanAttributeItemID2, LinePlanAttributeItemID3, LinePlanRangeSort, LineplanRangeID

select @CLinePlanRange = LinePlanRange, @CLinePlanRangeID = LinePlanRangeID 
FROM   pLinePlanRange
WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
AND	LinePlanId = @LinePlanID
GROUP BY LinePlanID, LinePlanFinancialID, LinePlanRange, LinePlanAttributeItemID1, 
LinePlanAttributeItemID2, LinePlanAttributeItemID3, LinePlanRangeSort, LineplanRangeID

select @BLinePlanRange = LinePlanRange, @BLinePlanRangeID = LinePlanRangeID 
FROM   pLinePlanRange
WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000003'
AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
AND	LinePlanId = @LinePlanID
GROUP BY LinePlanID, LinePlanFinancialID, LinePlanRange, LinePlanAttributeItemID1, 
LinePlanAttributeItemID2, LinePlanAttributeItemID3, LinePlanRangeSort, LineplanRangeID




INSERT INTO #tmpLinePlanRange (
LinePlanID, LineplanRangeID, LinePlanFinancialID, LinePlanRange, 
LinePlanRangeDelCO1, LinePlanRangeDelNV1, LinePlanRangeDelN1, LinePlanRangeDelTL1, 
LinePlanRangeDelCO2, LinePlanRangeDelNV2, LinePlanRangeDelN2, LinePlanRangeDelTL2, 
LinePlanRangeDelCO3, LinePlanRangeDelNV3, LinePlanRangeDelN3, LinePlanRangeDelTL3, 
LinePlanRangeDelCO4, LinePlanRangeDelNV4, LinePlanRangeDelN4, LinePlanRangeDelTL4 )
VALUES (
@LinePlanID,@SLineplanRangeID ,'10000000-0000-0000-0000-000000000004', @SLinePlanRange,
@SLinePlanRangeDelCO1, @SLinePlanRangeDelNV1, @SLinePlanRangeDelN1, @SLinePlanRangeDelCO1+@SLinePlanRangeDelNV1+@SLinePlanRangeDelN1,
@SLinePlanRangeDelCO2, @SLinePlanRangeDelNV2, @SLinePlanRangeDelN2, @SLinePlanRangeDelCO2+@SLinePlanRangeDelNV2+@SLinePlanRangeDelN2,
@SLinePlanRangeDelCO3, @SLinePlanRangeDelNV3, @SLinePlanRangeDelN3, @SLinePlanRangeDelCO3+@SLinePlanRangeDelNV3+@SLinePlanRangeDelN3,
@SLinePlanRangeDelCO4, @SLinePlanRangeDelNV4, @SLinePlanRangeDelN4, @SLinePlanRangeDelCO4+@SLinePlanRangeDelNV4+@SLinePlanRangeDelN4 )


INSERT INTO #tmpLinePlanRange (
LinePlanID, LineplanRangeID, LinePlanFinancialID, LinePlanRange, 
LinePlanRangeDelTL1, LinePlanRangeDelTL2, LinePlanRangeDelTL3, LinePlanRangeDelTL4 )
VALUES (
@LinePlanID,@FLineplanRangeID ,'10000000-0000-0000-0000-000000000001', @FLinePlanRange,
@FLinePlanRangeDel1, @FLinePlanRangeDel2, @FLinePlanRangeDel3, @FLinePlanRangeDel4
)

INSERT INTO #tmpLinePlanRange (
LinePlanID, LineplanRangeID, LinePlanFinancialID, LinePlanRange, 
LinePlanRangeDelTL1, LinePlanRangeDelTL2, LinePlanRangeDelTL3, LinePlanRangeDelTL4 )
VALUES (
@LinePlanID,@BLineplanRangeID ,'10000000-0000-0000-0000-000000000003', @BLinePlanRange,
@BLinePlanRangeDel1, @BLinePlanRangeDel2, @BLinePlanRangeDel3, @BLinePlanRangeDel4
)


INSERT INTO #tmpLinePlanRange (
LinePlanID, LineplanRangeID, LinePlanFinancialID, LinePlanRange, 
LinePlanRangeDelTL1, LinePlanRangeDelTL2, LinePlanRangeDelTL3, LinePlanRangeDelTL4 )
VALUES (
@LinePlanID,@CLineplanRangeID ,'10000000-0000-0000-0000-000000000002', @CLinePlanRange,
@CLinePlanRangeDel1, @CLinePlanRangeDel2, @CLinePlanRangeDel3, @CLinePlanRangeDel4
)


SELECT #tmpLinePlanRange.*, 
pLinePlanFinancial.LinePlanFinancialDataType, 
pLinePlanFinancial.LinePlanFinancialDataFormat, 
pLinePlanFinancial.LinePlanFinancialCssClass
FROM #tmpLinePlanRange 
INNER JOIN pLinePlanFinancial ON #tmpLinePlanRange.LinePlanFinancialID = pLinePlanFinancial.LinePlanFinancialID


DROP TABLE #tmpLinePlanRange

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03158'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03158', GetDate())

END
GO