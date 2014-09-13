-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 January 2012                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


IF EXISTS (select * from sysobjects where id = object_id('spx_LinePlan_StyleAttribute_RangeRollup3_Temp_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_LinePlan_StyleAttribute_RangeRollup3_Temp_SELECT
GO

CREATE PROCEDURE spx_LinePlan_StyleAttribute_RangeRollup3_Temp_SELECT
(
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@LinePlanStyleAttributeItemID UNIQUEIDENTIFIER
)
AS

DECLARE
@LinePlanAttributeItemId1 UNIQUEIDENTIFIER,
@LinePlanAttributeItemId2 UNIQUEIDENTIFIER,
@LinePlanAttributeItemId3 UNIQUEIDENTIFIER,
@LinePlanAttributeItemID4 UNIQUEIDENTIFIER,
@LinePlanFinancialSort NVARCHAR(5) ,
@LinePlanRangeAttributeID UNIQUEIDENTIFIER


SELECT @LinePlanAttributeItemID1 = LinePlanAttributeItemID1, @LinePlanAttributeItemID2 = LinePlanAttributeItemID2,
@LinePlanAttributeItemID3 = LinePlanAttributeItemID3, @LinePlanAttributeItemID4 = LinePlanAttributeItemID4	
FROM pLinePlanRange
WHERE LinePlanRangeID = @LinePlanRangeID 


DECLARE
@SLinePlanRangeDelCO1 int, 	@SLinePlanRangeDelNV1 int, 	@SLinePlanRangeDelN1 int, 	@SLinePlanRangeDelTL1 int,
@SLinePlanRangeDelCO2 int,	@SLinePlanRangeDelNV2 int,	@SLinePlanRangeDelN2 int,	@SLinePlanRangeDelTL2 int,
@SLinePlanRangeDelCO3 int,	@SLinePlanRangeDelNV3 int,	@SLinePlanRangeDelN3 int,	@SLinePlanRangeDelTL3 int,
@SLinePlanRangeDelCO4 int,	@SLinePlanRangeDelNV4 int,	@SLinePlanRangeDelN4 int,	@SLinePlanRangeDelTL4 int,
@SLinePlanRangeDelAVCO int,	@SLinePlanRangeDelAVNV int,	@SLinePlanRangeDelAVN int,	@SLinePlanRange VARCHAR(100),
@SLinePlanRangeID UNIQUEIDENTIFIER 


DECLARE
@FLinePlanRangeDelCO1 int, 	@FLinePlanRangeDelNV1 int,	@FLinePlanRangeDelN1 int,	@FLinePlanRangeDelTL1 int,
@FLinePlanRangeDelCO2 int,	@FLinePlanRangeDelNV2 int,	@FLinePlanRangeDelN2 int,	@FLinePlanRangeDelTL2 int,
@FLinePlanRangeDelCO3 int,	@FLinePlanRangeDelNV3 int,	@FLinePlanRangeDelN3 int,	@FLinePlanRangeDelTL3 int,
@FLinePlanRangeDelCO4 int,	@FLinePlanRangeDelNV4 int,	@FLinePlanRangeDelN4 int,	@FLinePlanRangeDelTL4 int,
@FLinePlanRangeDelAVCO int,	@FLinePlanRangeDelAVNV int,	@FLinePlanRangeDelAVN int,	@FLinePlanRange VARCHAR(100),
@FLinePlanRangeID UNIQUEIDENTIFIER  


DECLARE
@BLinePlanRangeDelCO1 int,	@BLinePlanRangeDelNV1 int,	@BLinePlanRangeDelN1 int,	@BLinePlanRangeDelTL1 int,
@BLinePlanRangeDelCO2 int,	@BLinePlanRangeDelNV2 int,	@BLinePlanRangeDelN2 int,	@BLinePlanRangeDelTL2 int,
@BLinePlanRangeDelCO3 int,	@BLinePlanRangeDelNV3 int,	@BLinePlanRangeDelN3 int,	@BLinePlanRangeDelTL3 int,
@BLinePlanRangeDelCO4 int,	@BLinePlanRangeDelNV4 int,	@BLinePlanRangeDelN4 int,	@BLinePlanRangeDelTL4 int,
@BLinePlanRangeDelAVCO int,	@BLinePlanRangeDelAVNV int,	@BLinePlanRangeDelAVN int,	@BLinePlanRange VARCHAR(100),
@BLinePlanRangeID UNIQUEIDENTIFIER  
	 

DECLARE
@CLinePlanRangeDelCO1 int,	@CLinePlanRangeDelNV1 int,	@CLinePlanRangeDelN1 int,	@CLinePlanRangeDelTL1 int,
@CLinePlanRangeDelCO2 int,	@CLinePlanRangeDelNV2 int,	@CLinePlanRangeDelN2 int,	@CLinePlanRangeDelTL2 int,
@CLinePlanRangeDelCO3 int,	@CLinePlanRangeDelNV3 int,	@CLinePlanRangeDelN3 int,	@CLinePlanRangeDelTL3 int,
@CLinePlanRangeDelCO4 int,	@CLinePlanRangeDelNV4 int,	@CLinePlanRangeDelN4 int,	@CLinePlanRangeDelTL4 int,
@CLinePlanRangeDelAVCO int,	@CLinePlanRangeDelAVNV int,	@CLinePlanRangeDelAVN int,	@CLinePlanRange VARCHAR(100),
@CLinePlanRangeID UNIQUEIDENTIFIER  


DECLARE
@OLinePlanRangeDelCO1 int,	@OLinePlanRangeDelNV1 int,	@OLinePlanRangeDelN1 int,	@OLinePlanRangeDelTL1 int,
@OLinePlanRangeDelCO2 int,	@OLinePlanRangeDelNV2 int,	@OLinePlanRangeDelN2 int,	@OLinePlanRangeDelTL2 int,
@OLinePlanRangeDelCO3 int,	@OLinePlanRangeDelNV3 int,	@OLinePlanRangeDelN3 int,	@OLinePlanRangeDelTL3 int,
@OLinePlanRangeDelCO4 int,	@OLinePlanRangeDelNV4 int,	@OLinePlanRangeDelN4 int,	@OLinePlanRangeDelTL4 int,
@OLinePlanRangeDelAVCO int,	@OLinePlanRangeDelAVNV int,	@OLinePlanRangeDelAVN int,	@OLinePlanRange VARCHAR(100),
@OLinePlanRangeID UNIQUEIDENTIFIER  
 
CREATE TABLE #tmpLinePlanRange(
	LinePlanRangeAttributeID UNIQUEIDENTIFIER , 
	LinePlanRangeID uniqueidentifier NULL,
	LinePlanFinancialID uniqueidentifier NULL,
	LinePlanRange nvarchar(100) NULL,
	LinePlanAttributeItemID1 uniqueidentifier NULL,
	LinePlanAttributeItemID2 uniqueidentifier NULL,
	LinePlanAttributeItemID3 uniqueidentifier NULL,
	LinePlanAttributeItemID4 uniqueidentifier NULL,
	LinePlanAttributeText1 nvarchar(100) NULL,
	LinePlanAttributeText2 nvarchar(100) NULL,
	LinePlanAttributeText3 nvarchar(100) NULL,
	LinePlanAttributeText4 nvarchar(100) NULL,
	LinePlanAttributeItemSort1 varchar(5) NULL,
	LinePlanAttributeItemSort2 varchar(5) NULL,
	LinePlanAttributeItemSort3 varchar(5) NULL,
	LinePlanAttributeItemSort4 varchar(5) NULL,
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
	LinePlanFinancialSort varchar(5) NULL)


/***************************************************************************************/
-- STYLES 
SET @LinePlanRangeID =  NULL
SELECT @LinePlanRangeID = LinePlanRangeID FROM pLinePlanRange 
WHERE  LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'
AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 
AND	LinePlanAttributeItemID2 = @LinePlanAttributeItemID2 
AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 

----------------------------
-- Reset temp table 
DELETE FROM pLinePlanRangeAttributeTemp 
WHERE LinePlanStyleAttributeItemID = @LinePlanStyleAttributeItemID 
AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 
AND	LinePlanAttributeItemID2 = @LinePlanAttributeItemID2 
AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 

--INSERT INTO pLinePlanRangeAttributeTemp  
--SELECT * FROM pLinePlanRangeAttribute
--WHERE LinePlanStyleAttributeItemID = @LinePlanStyleAttributeItemID 
--AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 
--AND	LinePlanAttributeItemID2 = @LinePlanAttributeItemID2 
--AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 

INSERT INTO pLinePlanRangeAttributeTemp (
	[LinePlanRangeAttributeID]
	,[LinePlanStyleAttributeItemID]
	,[AttributeID]
	,[AttributeName]
	,[LinePlanAttributeItemID1]
	,[LinePlanAttributeItemID2]
	,[LinePlanAttributeItemID3]
	,[LinePlanAttributeItemID4]
	,[LinePlanID]
	,[LinePlanFinancialID]
	,[LinePlanRange]
	,[LinePlanRangeDelCO1]
	,[LinePlanRangeDelNV1]
	,[LinePlanRangeDelN1]
	,[LinePlanRangeDelTL1]
	,[LinePlanRangeDelCO2]
	,[LinePlanRangeDelNV2]
	,[LinePlanRangeDelN2]
	,[LinePlanRangeDelTL2]
	,[LinePlanRangeDelCO3]
	,[LinePlanRangeDelNV3]
	,[LinePlanRangeDelN3]
	,[LinePlanRangeDelTL3]
	,[LinePlanRangeDelCO4]
	,[LinePlanRangeDelNV4]
	,[LinePlanRangeDelN4]
	,[LinePlanRangeDelTL4]
	,[LinePlanRangeDelAVCO]
	,[LinePlanRangeDelAVNV]
	,[LinePlanRangeDelAVN]
	,[CUser]
	,[CDate]
	,[MUser]
	,[MDate]
	,[LinePlanFinancialSort]
)
SELECT [LinePlanRangeAttributeID]
	,[LinePlanStyleAttributeItemID]
	,[AttributeID]
	,[AttributeName]
	,[LinePlanAttributeItemID1]
	,[LinePlanAttributeItemID2]
	,[LinePlanAttributeItemID3]
	,[LinePlanAttributeItemID4]
	,[LinePlanID]
	,[LinePlanFinancialID]
	,[LinePlanRange]
	,[LinePlanRangeDelCO1]
	,[LinePlanRangeDelNV1]
	,[LinePlanRangeDelN1]
	,[LinePlanRangeDelTL1]
	,[LinePlanRangeDelCO2]
	,[LinePlanRangeDelNV2]
	,[LinePlanRangeDelN2]
	,[LinePlanRangeDelTL2]
	,[LinePlanRangeDelCO3]
	,[LinePlanRangeDelNV3]
	,[LinePlanRangeDelN3]
	,[LinePlanRangeDelTL3]
	,[LinePlanRangeDelCO4]
	,[LinePlanRangeDelNV4]
	,[LinePlanRangeDelN4]
	,[LinePlanRangeDelTL4]
	,[LinePlanRangeDelAVCO]
	,[LinePlanRangeDelAVNV]
	,[LinePlanRangeDelAVN]
	,[CUser]
	,[CDate]
	,[MUser]
	,[MDate]
	,[LinePlanFinancialSort]
FROM [pLinePlanRangeAttribute]
WHERE LinePlanStyleAttributeItemID = @LinePlanStyleAttributeItemID 
	AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 
	AND	LinePlanAttributeItemID2 = @LinePlanAttributeItemID2 
	AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 
----------------------------

SELECT @LinePlanRangeAttributeID = LinePlanRangeAttributeID,
@SLinePlanRangeDelCO1 = SUM(LinePlanRangeDelCO1), 	@SLinePlanRangeDelNV1 = SUM(LinePlanRangeDelNV1), 
@SLinePlanRangeDelN1 = SUM(LinePlanRangeDelN1), 	@SLinePlanRangeDelCO2 = SUM(LinePlanRangeDelCO2), 
@SLinePlanRangeDelNV2 = SUM(LinePlanRangeDelNV2), 	@SLinePlanRangeDelN2 = SUM(LinePlanRangeDelN2), 
@SLinePlanRangeDelCO3 = SUM(LinePlanRangeDelCO3), 	@SLinePlanRangeDelNV3 = SUM(LinePlanRangeDelNV3), 
@SLinePlanRangeDelN3 = SUM(LinePlanRangeDelN3), 	@SLinePlanRangeDelCO4 = SUM(LinePlanRangeDelCO4), 
@SLinePlanRangeDelNV4 = SUM(LinePlanRangeDelNV4), 	@SLinePlanRangeDelN4 = SUM(LinePlanRangeDelN4), 
@SLinePlanRangeDelTL1 = SUM(LinePlanRangeDelTL1), 	@SLinePlanRangeDelTL2 = SUM(LinePlanRangeDelTL2), 
@SLinePlanRangeDelTL3 = SUM(LinePlanRangeDelTL3), 	@SLinePlanRangeDelTL4 = SUM(LinePlanRangeDelTL4), 
@SLinePlanRange = LinePlanRange, @LinePlanFinancialSort = LinePlanFinancialSort
FROM pLinePlanRangeAttribute
WHERE LinePlanStyleAttributeItemID = @LinePlanStyleAttributeItemID 
AND LinePlanAttributeItemID1 = @LinePlanAttributeItemID1 
AND	LinePlanAttributeItemID2 = @LinePlanAttributeItemID2 
AND	LinePlanAttributeItemID3 = @LinePlanAttributeItemID3 
AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'
GROUP BY LinePlanRangeAttributeID, LinePlanRange, LinePlanFinancialSort

INSERT INTO #tmpLinePlanRange (
LinePlanRangeAttributeID ,
LinePlanRangeID,		LinePlanFinancialID, LinePlanRange,
LinePlanRangeDelCO1,	LinePlanRangeDelNV1,	LinePlanRangeDelN1,		LinePlanRangeDelTL1,
LinePlanRangeDelCO2,	LinePlanRangeDelNV2,	LinePlanRangeDelN2,		LinePlanRangeDelTL2,
LinePlanRangeDelCO3,	LinePlanRangeDelNV3,	LinePlanRangeDelN3,		LinePlanRangeDelTL3,
LinePlanRangeDelCO4,	LinePlanRangeDelNV4,	LinePlanRangeDelN4,		LinePlanRangeDelTL4,
LinePlanRangeDelAVCO,	LinePlanRangeDelAVNV,	LinePlanRangeDelAVN,	LinePlanFinancialSort )
VALUES(
@LinePlanRangeAttributeID, 
@LinePlanRangeID ,		'10000000-0000-0000-0000-000000000004', @SLinePlanRange,
@SLinePlanRangeDelCO1,	@SLinePlanRangeDelNV1,	@SLinePlanRangeDelN1,	@SLinePlanRangeDelTL1,
@SLinePlanRangeDelCO2,	@SLinePlanRangeDelNV2,	@SLinePlanRangeDelN2,	@SLinePlanRangeDelTL2,
@SLinePlanRangeDelCO3,	@SLinePlanRangeDelNV3,	@SLinePlanRangeDelN3,	@SLinePlanRangeDelTL3,	
@SLinePlanRangeDelCO4,	@SLinePlanRangeDelNV4,	@SLinePlanRangeDelN4,	@SLinePlanRangeDelTL4,
@SLinePlanRangeDelAVCO,	@SLinePlanRangeDelAVNV,	@SLinePlanRangeDelAVN , @LinePlanFinancialSort)

SELECT #tmpLinePlanRange.*, 
	pLinePlanFinancial.LinePlanFinancialDataType, 
	pLinePlanFinancial.LinePlanFinancialDataFormat, 
	pLinePlanFinancial.LinePlanFinancialCssClass
	FROM #tmpLinePlanRange INNER JOIN
    pLinePlanFinancial ON #tmpLinePlanRange.LinePlanFinancialID = pLinePlanFinancial.LinePlanFinancialID
ORDER BY  #tmpLinePlanRange.LinePlanFinancialSort

DROP TABLE #tmpLinePlanRange
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.2.0000', '02957', GetDate())
GO

SET NOCOUNT Off
GO
