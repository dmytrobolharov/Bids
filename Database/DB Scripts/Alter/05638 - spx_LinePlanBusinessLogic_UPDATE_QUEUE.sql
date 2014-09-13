IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanBusinessLogic_UPDATE_QUEUE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanBusinessLogic_UPDATE_QUEUE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LinePlanBusinessLogic_UPDATE_QUEUE](
@LinePlanID VARCHAR(40),
@LinePlanAttributeItemID1 VARCHAR(40),
@LinePlanAttributeItemID2 VARCHAR(40),
@LinePlanAttributeItemID3 VARCHAR(40),
@LinePlanAttributeItemID4 VARCHAR(40),
@MUser NVARCHAR(200) = NULL ,
@MDate DATETIME = NULL
)
AS

IF @LinePlanAttributeItemID1 =''
	SET @LinePlanAttributeItemID1 = '00000000-0000-0000-0000-000000000000'
IF @LinePlanAttributeItemID2 =''
	SET @LinePlanAttributeItemID2 = '00000000-0000-0000-0000-000000000000'
IF @LinePlanAttributeItemID3 =''
	SET @LinePlanAttributeItemID3 = '00000000-0000-0000-0000-000000000000'
IF @LinePlanAttributeItemID4 =''
	SET @LinePlanAttributeItemID4 = '00000000-0000-0000-0000-000000000000'

IF @MDate IS NULL
	SET @MDate = GETDATE()

DECLARE @LY1_NoOfStyle INTEGER
DECLARE @LY1_NoOfFabric INTEGER
DECLARE @LY1_NoOfBody INTEGER 
DECLARE @LY1_NoOfColor INTEGER
DECLARE @LY1_NoOfOptions INTEGER
DECLARE @LY1_MarkupFactor DECIMAL(18, 3)
DECLARE @LY1_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @LY1_AvgTargetFOB DECIMAL(18, 5)
DECLARE @LY1_SalesUnit DECIMAL(18, 3)
DECLARE @LY1_ProjectedWhs DECIMAL(18, 5)
DECLARE @LY1_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @LY1_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @LY1_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @LY1_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @LY1_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @LY2_NoOfStyle INTEGER
DECLARE @LY2_NoOfFabric INTEGER
DECLARE @LY2_NoOfBody INTEGER 
DECLARE @LY2_NoOfColor INTEGER
DECLARE @LY2_NoOfOptions INTEGER
DECLARE @LY2_MarkupFactor DECIMAL(18, 3)
DECLARE @LY2_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @LY2_AvgTargetFOB DECIMAL(18, 5)
DECLARE @LY2_SalesUnit DECIMAL(18, 3)
DECLARE @LY2_ProjectedWhs DECIMAL(18, 5)
DECLARE @LY2_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @LY2_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @LY2_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @LY2_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @LY2_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @LY3_NoOfStyle INTEGER
DECLARE @LY3_NoOfFabric INTEGER
DECLARE @LY3_NoOfBody INTEGER 
DECLARE @LY3_NoOfColor INTEGER
DECLARE @LY3_NoOfOptions INTEGER
DECLARE @LY3_MarkupFactor DECIMAL(18, 3)
DECLARE @LY3_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @LY3_AvgTargetFOB DECIMAL(18, 5)
DECLARE @LY3_SalesUnit DECIMAL(18, 3)
DECLARE @LY3_ProjectedWhs DECIMAL(18, 5)
DECLARE @LY3_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @LY3_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @LY3_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @LY3_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @LY3_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @LY4_NoOfStyle INTEGER
DECLARE @LY4_NoOfFabric INTEGER
DECLARE @LY4_NoOfBody INTEGER 
DECLARE @LY4_NoOfColor INTEGER
DECLARE @LY4_NoOfOptions INTEGER
DECLARE @LY4_MarkupFactor DECIMAL(18, 3)
DECLARE @LY4_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @LY4_AvgTargetFOB DECIMAL(18, 5)
DECLARE @LY4_SalesUnit DECIMAL(18, 3)
DECLARE @LY4_ProjectedWhs DECIMAL(18, 5)
DECLARE @LY4_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @LY4_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @LY4_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @LY4_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @LY4_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @PL1_NoOfStyle INTEGER
DECLARE @PL1_NoOfFabric INTEGER
DECLARE @PL1_NoOfBody INTEGER 
DECLARE @PL1_NoOfColor INTEGER
DECLARE @PL1_NoOfOptions INTEGER
DECLARE @PL1_MarkupFactor DECIMAL(18, 3)
DECLARE @PL1_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @PL1_AvgTargetFOB DECIMAL(18, 5)
DECLARE @PL1_SalesUnit DECIMAL(18, 3)
DECLARE @PL1_ProjectedWhs DECIMAL(18, 5)
DECLARE @PL1_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @PL1_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @PL1_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @PL1_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @PL1_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @PL2_NoOfStyle INTEGER
DECLARE @PL2_NoOfFabric INTEGER
DECLARE @PL2_NoOfBody INTEGER 
DECLARE @PL2_NoOfColor INTEGER
DECLARE @PL2_NoOfOptions INTEGER
DECLARE @PL2_MarkupFactor DECIMAL(18, 3)
DECLARE @PL2_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @PL2_AvgTargetFOB DECIMAL(18, 5)
DECLARE @PL2_SalesUnit DECIMAL(18, 3)
DECLARE @PL2_ProjectedWhs DECIMAL(18, 5)
DECLARE @PL2_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @PL2_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @PL2_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @PL2_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @PL2_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @PL3_NoOfStyle INTEGER
DECLARE @PL3_NoOfFabric INTEGER
DECLARE @PL3_NoOfBody INTEGER 
DECLARE @PL3_NoOfColor INTEGER
DECLARE @PL3_NoOfOptions INTEGER
DECLARE @PL3_MarkupFactor DECIMAL(18, 3)
DECLARE @PL3_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @PL3_AvgTargetFOB DECIMAL(18, 5)
DECLARE @PL3_SalesUnit DECIMAL(18, 3)
DECLARE @PL3_ProjectedWhs DECIMAL(18, 5)
DECLARE @PL3_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @PL3_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @PL3_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @PL3_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @PL3_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @PL4_NoOfStyle INTEGER
DECLARE @PL4_NoOfFabric INTEGER
DECLARE @PL4_NoOfBody INTEGER 
DECLARE @PL4_NoOfColor INTEGER
DECLARE @PL4_NoOfOptions INTEGER
DECLARE @PL4_MarkupFactor DECIMAL(18, 3)
DECLARE @PL4_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @PL4_AvgTargetFOB DECIMAL(18, 5)
DECLARE @PL4_SalesUnit DECIMAL(18, 3)
DECLARE @PL4_ProjectedWhs DECIMAL(18, 5)
DECLARE @PL4_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @PL4_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @PL4_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @PL4_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @PL4_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @Cu1_NoOfStyle INTEGER
DECLARE @Cu1_NoOfFabric INTEGER
DECLARE @Cu1_NoOfBody INTEGER 
DECLARE @Cu1_NoOfColor INTEGER
DECLARE @Cu1_NoOfOptions INTEGER
DECLARE @Cu1_MarkupFactor DECIMAL(18, 3)
DECLARE @Cu1_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @Cu1_AvgTargetFOB DECIMAL(18, 5)
DECLARE @Cu1_SalesUnit DECIMAL(18, 3)
DECLARE @Cu1_ProjectedWhs DECIMAL(18, 5)
DECLARE @Cu1_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @Cu1_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @Cu1_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @Cu1_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @Cu1_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @Cu2_NoOfStyle INTEGER
DECLARE @Cu2_NoOfFabric INTEGER
DECLARE @Cu2_NoOfBody INTEGER 
DECLARE @Cu2_NoOfColor INTEGER
DECLARE @Cu2_NoOfOptions INTEGER
DECLARE @Cu2_MarkupFactor DECIMAL(18, 3)
DECLARE @Cu2_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @Cu2_AvgTargetFOB DECIMAL(18, 5)
DECLARE @Cu2_SalesUnit DECIMAL(18, 3)
DECLARE @Cu2_ProjectedWhs DECIMAL(18, 5)
DECLARE @Cu2_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @Cu2_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @Cu2_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @Cu2_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @Cu2_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @Cu3_NoOfStyle INTEGER
DECLARE @Cu3_NoOfFabric INTEGER
DECLARE @Cu3_NoOfBody INTEGER 
DECLARE @Cu3_NoOfColor INTEGER
DECLARE @Cu3_NoOfOptions INTEGER
DECLARE @Cu3_MarkupFactor DECIMAL(18, 3)
DECLARE @Cu3_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @Cu3_AvgTargetFOB DECIMAL(18, 5)
DECLARE @Cu3_SalesUnit DECIMAL(18, 3)
DECLARE @Cu3_ProjectedWhs DECIMAL(18, 5)
DECLARE @Cu3_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @Cu3_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @Cu3_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @Cu3_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @Cu3_WeightedAverageRetailPrice DECIMAL(18, 3)

DECLARE @Cu4_NoOfStyle INTEGER
DECLARE @Cu4_NoOfFabric INTEGER
DECLARE @Cu4_NoOfBody INTEGER 
DECLARE @Cu4_NoOfColor INTEGER
DECLARE @Cu4_NoOfOptions INTEGER
DECLARE @Cu4_MarkupFactor DECIMAL(18, 3)
DECLARE @Cu4_TargetAvgWhsPrice DECIMAL(18, 5)
DECLARE @Cu4_AvgTargetFOB DECIMAL(18, 5)
DECLARE @Cu4_SalesUnit DECIMAL(18, 3)
DECLARE @Cu4_ProjectedWhs DECIMAL(18, 5)
DECLARE @Cu4_InitialGrossMarginRtl DECIMAL(18, 3)
DECLARE @Cu4_InitialGrossMarginWhs DECIMAL(18, 3)
DECLARE @Cu4_WeightGrossMarginWhs DECIMAL(18, 3)
DECLARE @Cu4_WeightGrossMarginRtl DECIMAL(18, 3)
DECLARE @Cu4_WeightedAverageRetailPrice DECIMAL(18, 3)


/*
--***
--** Number of Styles
--***
SELECT TOP 1 
@LY1_NoOfStyle = LinePlanBusLYCh1, @LY2_NoOfStyle = LinePlanBusLYCh2, @LY3_NoOfStyle = LinePlanBusLYCh3, @LY4_NoOfStyle = LinePlanBusLYCh4, 
@PL1_NoOfStyle = LinePlanBusPnCh1, @PL2_NoOfStyle = LinePlanBusPnCh2, @PL3_NoOfStyle = LinePlanBusPnCh3, @PL4_NoOfStyle = LinePlanBusPnCh4, 
@Cu1_NoOfStyle = LinePlanBusCuCh1, @Cu2_NoOfStyle = LinePlanBusCuCh2, @Cu3_NoOfStyle = LinePlanBusCuCh3, @Cu4_NoOfStyle = LinePlanBusCuCh4 
FROM pLinePlanBusiness
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'
*/

/*
--***
--** Number of Fabrics
--***
SELECT TOP 1 
@LY1_NoOfFabric = LinePlanBusLYCh1, @LY2_NoOfFabric = LinePlanBusLYCh2, @LY3_NoOfFabric = LinePlanBusLYCh3, @LY4_NoOfFabric = LinePlanBusLYCh4, 
@PL1_NoOfFabric = LinePlanBusPnCh1, @PL2_NoOfFabric = LinePlanBusPnCh2, @PL3_NoOfFabric = LinePlanBusPnCh3, @PL4_NoOfFabric = LinePlanBusPnCh4, 
@Cu1_NoOfFabric = LinePlanBusCuCh1, @Cu2_NoOfFabric = LinePlanBusCuCh2, @Cu3_NoOfFabric = LinePlanBusCuCh3, @Cu4_NoOfFabric = LinePlanBusCuCh4 
FROM pLinePlanBusiness
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 	AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 	AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000001'
*/

/*
--***
--** Number of Silhouettes
--***
SELECT TOP 1 
@LY1_NoOfBody = LinePlanBusLYCh1, @LY2_NoOfBody = LinePlanBusLYCh2,	@LY3_NoOfBody = LinePlanBusLYCh3, @LY4_NoOfBody = LinePlanBusLYCh4, 
@PL1_NoOfBody = LinePlanBusPnCh1, @PL2_NoOfBody = LinePlanBusPnCh2, @PL3_NoOfBody = LinePlanBusPnCh3, @PL4_NoOfBody = LinePlanBusPnCh4, 
@Cu1_NoOfBody = LinePlanBusCuCh1, @Cu2_NoOfBody = LinePlanBusCuCh2, @Cu3_NoOfBody = LinePlanBusCuCh3, @Cu4_NoOfBody = LinePlanBusCuCh4 
FROM pLinePlanBusiness
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000003'
*/

/*
--***
--** Number of Colors
--***
SELECT TOP 1 
@LY1_NoOfColor = LinePlanBusLYCh1, @LY2_NoOfColor = LinePlanBusLYCh2, @LY3_NoOfColor = LinePlanBusLYCh3, @LY4_NoOfColor = LinePlanBusLYCh4, 
@PL1_NoOfColor = LinePlanBusPnCh1, @PL2_NoOfColor = LinePlanBusPnCh2, @PL3_NoOfColor = LinePlanBusPnCh3, @PL4_NoOfColor = LinePlanBusPnCh4, 
@Cu1_NoOfColor = LinePlanBusCuCh1, @Cu2_NoOfColor = LinePlanBusCuCh2, @Cu3_NoOfColor = LinePlanBusCuCh3, @Cu4_NoOfColor = LinePlanBusCuCh4 
FROM pLinePlanBusiness
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 	AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
*/


--***
--** Initial Gross Margin WHS %
--***
SELECT TOP 1 
@LY1_InitialGrossMarginWhs = ISNULL(LinePlanBusLYCh1,0), @LY2_InitialGrossMarginWhs = ISNULL(LinePlanBusLYCh2,0), @LY3_InitialGrossMarginWhs = ISNULL(LinePlanBusLYCh3,0), @LY4_InitialGrossMarginWhs = ISNULL(LinePlanBusLYCh4,0), 
@PL1_InitialGrossMarginWhs = ISNULL(LinePlanBusPnCh1,0), @PL2_InitialGrossMarginWhs = ISNULL(LinePlanBusPnCh2,0), @PL3_InitialGrossMarginWhs = ISNULL(LinePlanBusPnCh3,0), @PL4_InitialGrossMarginWhs = ISNULL(LinePlanBusPnCh4,0), 
@Cu1_InitialGrossMarginWhs = ISNULL(LinePlanBusCuCh1,0), @Cu2_InitialGrossMarginWhs = ISNULL(LinePlanBusCuCh2,0), @Cu3_InitialGrossMarginWhs = ISNULL(LinePlanBusCuCh3,0), @Cu4_InitialGrossMarginWhs = ISNULL(LinePlanBusCuCh4,0) 
FROM pLinePlanBusiness
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000013'


/*
--***
--** Mark up Factor
--***
SELECT TOP 1 
@LY1_MarkupFactor = LinePlanBusLYCh1, @LY2_MarkupFactor = LinePlanBusLYCh2, @LY3_MarkupFactor = LinePlanBusLYCh3, @LY4_MarkupFactor = LinePlanBusLYCh4, 
@PL1_MarkupFactor = LinePlanBusPnCh1, @PL2_MarkupFactor = LinePlanBusPnCh2, @PL3_MarkupFactor = LinePlanBusPnCh3, @PL4_MarkupFactor = LinePlanBusPnCh4, 
@Cu1_MarkupFactor = LinePlanBusCuCh1, @Cu2_MarkupFactor = LinePlanBusCuCh2, @Cu3_MarkupFactor = LinePlanBusCuCh3, @Cu4_MarkupFactor = LinePlanBusCuCh4 
FROM pLinePlanBusiness
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000005'
*/


--***
--** Retail Flow Through Margin%
--***
SELECT TOP 1 
@LY1_InitialGrossMarginRtl = ISNULL(LinePlanBusLYCh1,0), @LY2_InitialGrossMarginRtl = ISNULL(LinePlanBusLYCh2,0), @LY3_InitialGrossMarginRtl = ISNULL(LinePlanBusLYCh3,0), @LY4_InitialGrossMarginRtl = ISNULL(LinePlanBusLYCh4,0), 
@PL1_InitialGrossMarginRtl = ISNULL(LinePlanBusPnCh1,0), @PL2_InitialGrossMarginRtl = ISNULL(LinePlanBusPnCh2,0), @PL3_InitialGrossMarginRtl = ISNULL(LinePlanBusPnCh3,0), @PL4_InitialGrossMarginRtl = ISNULL(LinePlanBusPnCh4,0), 
@Cu1_InitialGrossMarginRtl = ISNULL(LinePlanBusCuCh1,0), @Cu2_InitialGrossMarginRtl = ISNULL(LinePlanBusCuCh2,0), @Cu3_InitialGrossMarginRtl = ISNULL(LinePlanBusCuCh3,0), @Cu4_InitialGrossMarginRtl = ISNULL(LinePlanBusCuCh4,0) 
FROM pLinePlanBusiness
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000010'

--***
--** Sales units
--***
SELECT TOP 1 
@LY1_SalesUnit = ISNULL(LinePlanBusLYCh1,0), @LY2_SalesUnit = ISNULL(LinePlanBusLYCh2,0), @LY3_SalesUnit = ISNULL(LinePlanBusLYCh3,0), @LY4_SalesUnit = ISNULL(LinePlanBusLYCh4,0), 
@PL1_SalesUnit = ISNULL(LinePlanBusPnCh1,0), @PL2_SalesUnit = ISNULL(LinePlanBusPnCh2,0), @PL3_SalesUnit = ISNULL(LinePlanBusPnCh3,0), @PL4_SalesUnit = ISNULL(LinePlanBusPnCh4,0), 
@Cu1_SalesUnit = ISNULL(LinePlanBusCuCh1,0), @Cu2_SalesUnit = ISNULL(LinePlanBusCuCh2,0), @Cu3_SalesUnit = ISNULL(LinePlanBusCuCh3,0), @Cu4_SalesUnit = ISNULL(LinePlanBusCuCh4,0) 
FROM pLinePlanBusiness
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000008'


--***
--** Target Average Whs Price
--***   
SELECT TOP 1 
@LY1_TargetAvgWhsPrice = ISNULL(LinePlanBusLYCh1,0), @LY2_TargetAvgWhsPrice = ISNULL(LinePlanBusLYCh2,0), @LY3_TargetAvgWhsPrice = ISNULL(LinePlanBusLYCh3,0), @LY4_TargetAvgWhsPrice = ISNULL(LinePlanBusLYCh4,0), 
@PL1_TargetAvgWhsPrice = ISNULL(LinePlanBusPnCh1,0), @PL2_TargetAvgWhsPrice = ISNULL(LinePlanBusPnCh2,0), @PL3_TargetAvgWhsPrice = ISNULL(LinePlanBusPnCh3,0), @PL4_TargetAvgWhsPrice = ISNULL(LinePlanBusPnCh4,0), 
@Cu1_TargetAvgWhsPrice = ISNULL(LinePlanBusCuCh1,0), @Cu2_TargetAvgWhsPrice = ISNULL(LinePlanBusCuCh2,0), @Cu3_TargetAvgWhsPrice = ISNULL(LinePlanBusCuCh3,0), @Cu4_TargetAvgWhsPrice = ISNULL(LinePlanBusCuCh4,0) 
FROM pLinePlanBusiness
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000009'


--***
--** Average Target FOB
--***   
SET @LY1_AvgTargetFOB = @LY1_TargetAvgWhsPrice - (@LY1_TargetAvgWhsPrice * @LY1_InitialGrossMarginWhs)
SET @LY2_AvgTargetFOB = @LY2_TargetAvgWhsPrice - (@LY2_TargetAvgWhsPrice * @LY2_InitialGrossMarginWhs)
SET @LY3_AvgTargetFOB = @LY3_TargetAvgWhsPrice - (@LY3_TargetAvgWhsPrice * @LY3_InitialGrossMarginWhs)
SET @LY4_AvgTargetFOB = @LY4_TargetAvgWhsPrice - (@LY4_TargetAvgWhsPrice * @LY4_InitialGrossMarginWhs)

SET @PL1_AvgTargetFOB = @PL1_TargetAvgWhsPrice - (@PL1_TargetAvgWhsPrice * @PL1_InitialGrossMarginWhs)
SET @PL2_AvgTargetFOB = @PL2_TargetAvgWhsPrice - (@PL2_TargetAvgWhsPrice * @PL2_InitialGrossMarginWhs)
SET @PL3_AvgTargetFOB = @PL3_TargetAvgWhsPrice - (@PL3_TargetAvgWhsPrice * @PL3_InitialGrossMarginWhs)
SET @PL4_AvgTargetFOB = @PL4_TargetAvgWhsPrice - (@PL4_TargetAvgWhsPrice * @PL4_InitialGrossMarginWhs)

SET @Cu1_AvgTargetFOB = @Cu1_TargetAvgWhsPrice - (@Cu1_TargetAvgWhsPrice * @Cu1_InitialGrossMarginWhs)
SET @Cu2_AvgTargetFOB = @Cu2_TargetAvgWhsPrice - (@Cu2_TargetAvgWhsPrice * @Cu2_InitialGrossMarginWhs)
SET @Cu3_AvgTargetFOB = @Cu3_TargetAvgWhsPrice - (@Cu3_TargetAvgWhsPrice * @Cu3_InitialGrossMarginWhs)
SET @Cu4_AvgTargetFOB = @Cu4_TargetAvgWhsPrice - (@Cu4_TargetAvgWhsPrice * @Cu4_InitialGrossMarginWhs)


UPDATE pLinePlanBusiness SET
LinePlanBusLYCh1 = @LY1_AvgTargetFOB, LinePlanBusLYCh2 = @LY2_AvgTargetFOB,
LinePlanBusLYCh3 = @LY3_AvgTargetFOB, LinePlanBusLYCh4 = @LY4_AvgTargetFOB, 
LinePlanBusPnCh1 = @PL1_AvgTargetFOB, LinePlanBusPnCh2 = @PL2_AvgTargetFOB, 
LinePlanBusPnCh3 = @PL3_AvgTargetFOB, LinePlanBusPnCh4 = @PL4_AvgTargetFOB, 
LinePlanBusCuCh1 = @Cu1_AvgTargetFOB, LinePlanBusCuCh2 = @Cu2_AvgTargetFOB, 
LinePlanBusCuCh3 = @Cu3_AvgTargetFOB, LinePlanBusCuCh4 = @Cu4_AvgTargetFOB 	
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000006'


--***
--** Projected Wholesale £
--***   
SET @LY1_ProjectedWhs = (@LY1_SalesUnit * @LY1_TargetAvgWhsPrice)  
SET @LY2_ProjectedWhs = (@LY2_SalesUnit * @LY2_TargetAvgWhsPrice) 
SET @LY3_ProjectedWhs = (@LY3_SalesUnit * @LY3_TargetAvgWhsPrice) 
SET @LY4_ProjectedWhs = (@LY4_SalesUnit * @LY4_TargetAvgWhsPrice) 
SET @PL1_ProjectedWhs = (@PL1_SalesUnit * @PL1_TargetAvgWhsPrice) 
SET @PL2_ProjectedWhs = (@PL2_SalesUnit * @PL2_TargetAvgWhsPrice) 
SET @PL3_ProjectedWhs = (@PL3_SalesUnit * @PL3_TargetAvgWhsPrice) 
SET @PL4_ProjectedWhs = (@PL4_SalesUnit * @PL4_TargetAvgWhsPrice) 
SET @Cu1_ProjectedWhs = (@Cu1_SalesUnit * @Cu1_TargetAvgWhsPrice) 
SET @Cu2_ProjectedWhs = (@Cu2_SalesUnit * @Cu2_TargetAvgWhsPrice) 
SET @Cu3_ProjectedWhs = (@Cu3_SalesUnit * @Cu3_TargetAvgWhsPrice) 
SET @Cu4_ProjectedWhs = (@Cu4_SalesUnit * @Cu4_TargetAvgWhsPrice) 	

UPDATE pLinePlanBusiness SET
LinePlanBusLYCh1 = @LY1_ProjectedWhs, LinePlanBusLYCh2 = @LY2_ProjectedWhs,
LinePlanBusLYCh3 = @LY3_ProjectedWhs, LinePlanBusLYCh4 = @LY4_ProjectedWhs, 
LinePlanBusPnCh1 = @PL1_ProjectedWhs, LinePlanBusPnCh2 = @PL2_ProjectedWhs, 
LinePlanBusPnCh3 = @PL3_ProjectedWhs, LinePlanBusPnCh4 = @PL4_ProjectedWhs, 
LinePlanBusCuCh1 = @Cu1_ProjectedWhs, LinePlanBusCuCh2 = @Cu2_ProjectedWhs, 
LinePlanBusCuCh3 = @Cu3_ProjectedWhs, LinePlanBusCuCh4 = @Cu4_ProjectedWhs	
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000007'


--***
--** Weighted gross margin - Retail %
--***   
UPDATE pLinePlanBusiness SET
LinePlanBusLYCh1 = @LY1_InitialGrossMarginRtl, LinePlanBusLYCh2 = @LY2_InitialGrossMarginRtl, LinePlanBusLYCh3 = @LY3_InitialGrossMarginRtl, LinePlanBusLYCh4 = @LY4_InitialGrossMarginRtl,
LinePlanBusPnCh1 = @PL1_InitialGrossMarginRtl, LinePlanBusPnCh2 = @PL2_InitialGrossMarginRtl, LinePlanBusPnCh3 = @PL3_InitialGrossMarginRtl, LinePlanBusPnCh4 = @PL4_InitialGrossMarginRtl,
LinePlanBusCuCh1 = @Cu1_InitialGrossMarginRtl, LinePlanBusCuCh2 = @Cu2_InitialGrossMarginRtl, LinePlanBusCuCh3 = @Cu3_InitialGrossMarginRtl, LinePlanBusCuCh4 = @Cu4_InitialGrossMarginRtl
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000012'


--***
--** Weighted gross margin - Wholesale %
--***   
UPDATE pLinePlanBusiness SET
LinePlanBusLYCh1 = @LY1_InitialGrossMarginWhs, LinePlanBusLYCh2 = @LY2_InitialGrossMarginWhs, LinePlanBusLYCh3 = @LY3_InitialGrossMarginWhs, LinePlanBusLYCh4 = @LY4_InitialGrossMarginWhs,
LinePlanBusPnCh1 = @PL1_InitialGrossMarginWhs, LinePlanBusPnCh2 = @PL2_InitialGrossMarginWhs, LinePlanBusPnCh3 = @PL3_InitialGrossMarginWhs, LinePlanBusPnCh4 = @PL4_InitialGrossMarginWhs,
LinePlanBusCuCh1 = @Cu1_InitialGrossMarginWhs, LinePlanBusCuCh2 = @Cu2_InitialGrossMarginWhs, LinePlanBusCuCh3 = @Cu3_InitialGrossMarginWhs, LinePlanBusCuCh4 = @Cu4_InitialGrossMarginWhs
WHERE LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 AND LinePlanID = @LinePlanID
AND LinePlanFinancialID = '00000000-0000-0000-0000-000000000011'




DECLARE @TOTAL INT
DECLARE @ROW_ID INT 
DECLARE @StyleQuoteItemID UNIQUEIDENTIFIER 
DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
DECLARE @StyleID UNIQUEIDENTIFIER 

--========================================================================================================
-- UPDATE StyleCosting 

CREATE TABLE #tmpStyleSeasonYear  ( 
ROW_ID INT IDENTITY (1,1),
StyleSeasonYearID UNIQUEIDENTIFIER, 
StyleID UNIQUEIDENTIFIER
)

INSERT INTO  #tmpStyleSeasonYear ( StyleSeasonYearID, StyleID)
SELECT c.StyleSeasonYearID, b.StyleID
FROM pLinePlanRange a 
INNER JOIN pLinePlanItem b ON a.LinePlanRangeID = b.LinePlanRangeID 
INNER JOIN pStyleSeasonYear c ON (b.StyleID = c.StyleID AND b.LinePlanItemID = c.LinePlanItemID)
WHERE a.LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
AND a.LinePlanAttributeItemID2 = @LinePlanAttributeItemID2
AND a.LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
AND a.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'
AND b.StyleID <>  '00000000-0000-0000-0000-000000000000'


SET @ROW_ID = 1 
SELECT @TOTAL  = COUNT(*) FROM #tmpStyleSeasonYear



WHILE  @ROW_ID <= @TOTAL
BEGIN

	SELECT @StyleSeasonYearID = StyleSeasonYearID, @StyleID = StyleID 
	FROM #tmpStyleSeasonYear WHERE ROW_ID = @ROW_ID

	EXEC dbo.spx_StyleCostingHeaderLogic_UPDATE 
	@StyleID = @StyleID,
	@ModifiedBy = @MUser,
	@ModifiedDate = @MDate, 
	@StyleSeasonYearID = @StyleSeasonYearID

	SET @ROW_ID = @ROW_ID + 1 
END 
DROP TABLE  #tmpStyleSeasonYear


--========================================================================================================
-- ADD LOGIC TO UPDATE STYLE_SOURCING_QUOTE_ITEMS 

CREATE TABLE #tmpQuoteItem  (
ROW_ID INT IDENTITY (1,1),
StyleQuoteItemID UNIQUEIDENTIFIER 
)

INSERT INTO #tmpQuoteItem (StyleQuoteItemID)
SELECT StyleQuoteItemID 
from pStyleQuoteItem 
WHERE StyleID IN ( SELECT distinct StyleID 
		FROM pLinePlanBusinessItem
		WHERE LinePlanID = @LinePlanID AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemID2 
		AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
)

SET @ROW_ID = 1 
SELECT @TOTAL  = COUNT(*) FROM #tmpQuoteItem

WHILE  @ROW_ID <= @TOTAL
BEGIN
	SELECT @StyleQuoteItemID = StyleQuoteItemID FROM #tmpQuoteItem WHERE ROW_ID = @ROW_ID
	EXEC dbo.spx_StyleSourcingQuoteItemLogic_UPDATE @StyleQuoteItemID, '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', @MUser, @MDate
	SET @ROW_ID = @ROW_ID + 1 
END 
DROP TABLE  #tmpQuoteItem

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05638', GetDate())
GO
