IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanRangeLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanRangeLogic_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LinePlanRangeLogic_UPDATE](
@LinePlanRangeID UNIQUEIDENTIFIER,
@CreatedBy NVARCHAR(200),
@CreatedDate DATETIME 
)
AS

DECLARE @LinePlanID UNIQUEIDENTIFIER
DECLARE @LinePlanAttributeItemID1 UNIQUEIDENTIFIER
DECLARE @LinePlanAttributeItemID2 UNIQUEIDENTIFIER
DECLARE @LinePlanAttributeItemID3 UNIQUEIDENTIFIER
DECLARE @LinePlanAttributeItemID4 UNIQUEIDENTIFIER
DECLARE @LinePlanRangeDelCO1 INT
DECLARE @LinePlanRangeDelNV1 INT
DECLARE @LinePlanRangeDelN1 INT
DECLARE @LinePlanRangeDelTL1 INT
DECLARE @LinePlanRangeDelCO2 INT
DECLARE @LinePlanRangeDelNV2 INT
DECLARE @LinePlanRangeDelN2 INT
DECLARE @LinePlanRangeDelTL2 INT
DECLARE @LinePlanRangeDelCO3 INT
DECLARE @LinePlanRangeDelNV3 INT
DECLARE @LinePlanRangeDelN3 INT
DECLARE @LinePlanRangeDelTL3 INT
DECLARE @LinePlanRangeDelCO4 INT
DECLARE @LinePlanRangeDelNV4 INT
DECLARE @LinePlanRangeDelN4 INT
DECLARE @LinePlanRangeDelTL4 INT
DECLARE @LinePlanRangeDelAVCO INT
DECLARE @LinePlanRangeDelAVNV INT
DECLARE @LinePlanRangeDelAVN INT

DECLARE @StyleTypeID INT --MUST find StyleTypeID to insert into pLinePlanItem Table 
DECLARE @StyleCategoryID VARCHAR(40) --MUST find StyleCategoryID to insert into pLinePlanItem Table 

SELECT 
       @LinePlanAttributeItemID1 = LinePlanAttributeItemID1
      ,@LinePlanAttributeItemID2 = LinePlanAttributeItemID2
      ,@LinePlanAttributeItemID3 = LinePlanAttributeItemID3
      ,@LinePlanAttributeItemID4 = LinePlanAttributeItemID4
      ,@LinePlanRangeDelCO1 = ISNULL(LinePlanRangeDelCO1,0)
      ,@LinePlanRangeDelNV1 = ISNULL(LinePlanRangeDelNV1,0)
      ,@LinePlanRangeDelN1 = ISNULL(LinePlanRangeDelN1,0)
      ,@LinePlanRangeDelTL1 = ISNULL(LinePlanRangeDelTL1,0)
      ,@LinePlanRangeDelCO2 = ISNULL(LinePlanRangeDelCO2,0)
      ,@LinePlanRangeDelNV2 = ISNULL(LinePlanRangeDelNV2,0)
      ,@LinePlanRangeDelN2 = ISNULL(LinePlanRangeDelN2,0)
      ,@LinePlanRangeDelTL2 = ISNULL(LinePlanRangeDelTL2,0)
      ,@LinePlanRangeDelCO3 = ISNULL(LinePlanRangeDelCO3,0)
      ,@LinePlanRangeDelNV3 = ISNULL(LinePlanRangeDelNV3,0)
      ,@LinePlanRangeDelN3 = ISNULL(LinePlanRangeDelN3,0)
      ,@LinePlanRangeDelTL3 = ISNULL(LinePlanRangeDelTL3,0)
      ,@LinePlanRangeDelCO4 = ISNULL(LinePlanRangeDelCO4,0)
      ,@LinePlanRangeDelNV4 = ISNULL(LinePlanRangeDelNV4,0)
      ,@LinePlanRangeDelN4 = ISNULL(LinePlanRangeDelN4,0)
      ,@LinePlanRangeDelTL4 = ISNULL(LinePlanRangeDelTL4,0)
      ,@LinePlanID = LinePlanID
FROM pLinePlanRange 
WHERE LinePlanrangeID = @LinePlanRangeID
AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'

--Find StyleTypeID
SELECT @StyleTypeID = LinePlanAttributeValue FROM pLinePlanAttributeItem WHERE LinePlanAttributeItemID = @LinePlanAttributeItemID2
SELECT @StyleCategoryID = LinePlanAttributeValue FROM pLinePlanAttributeItem WHERE LinePlanAttributeItemID = @LinePlanAttributeItemID3

CREATE TABLE #RangeType (CO int ,NV int, N int)
INSERT INTO #RangeType (CO, NV ,N) values (@LinePlanRangeDelCO1, @LinePlanRangeDelNV1, @LinePlanRangeDelN1)
INSERT INTO #RangeType (CO, NV ,N) values (@LinePlanRangeDelCO2, @LinePlanRangeDelNV2, @LinePlanRangeDelN2)
INSERT INTO #RangeType (CO, NV ,N) values (@LinePlanRangeDelCO3, @LinePlanRangeDelNV3, @LinePlanRangeDelN3)
INSERT INTO #RangeType (CO, NV ,N) values (@LinePlanRangeDelCO4, @LinePlanRangeDelNV4, @LinePlanRangeDelN4)

SELECT @LinePlanRangeDelAVCO = ISNULL(MAX([CO]),0), @LinePlanRangeDelAVNV = ISNULL(MAX([NV]),0), @LinePlanRangeDelAVN = ISNULL(MAX([N]),0) FROM #RangeType

UPDATE pLinePlanRange
   SET
       [LinePlanRangeDelTL1] = (ISNULL(@LinePlanRangeDelCO1,0) + ISNULL(@LinePlanRangeDelNV1,0) + ISNULL(@LinePlanRangeDelN1,0))
      ,[LinePlanRangeDelTL2] = (ISNULL(@LinePlanRangeDelCO2,0) + ISNULL(@LinePlanRangeDelNV2,0) + ISNULL(@LinePlanRangeDelN2,0))
      ,[LinePlanRangeDelTL3] = (ISNULL(@LinePlanRangeDelCO3,0) + ISNULL(@LinePlanRangeDelNV3,0) + ISNULL(@LinePlanRangeDelN3,0))
      ,[LinePlanRangeDelTL4] = (ISNULL(@LinePlanRangeDelCO4,0) + ISNULL(@LinePlanRangeDelNV4,0) + ISNULL(@LinePlanRangeDelN4,0))
        ,[LinePlanRangeDelAVCO] = ISNULL(@LinePlanRangeDelAVCO,0)
        ,[LinePlanRangeDelAVNV] = ISNULL(@LinePlanRangeDelAVNV,0)
        ,[LinePlanRangeDelAVN] = ISNULL(@LinePlanRangeDelAVN,0)
 WHERE LinePlanrangeID = @LinePlanRangeID AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'
 
--WHILE (SELECT COUNT(*) FROM pLinePlanItem WHERE LinePlanRangeID = @LinePlanRangeID) < @LinePlanRangeDelAVCO
DECLARE @intCount INT
DECLARE @intFlag INT
SET @intFlag = 1
SET @intCount =  ISNULL((SELECT COUNT(*) FROM pLinePlanItem WHERE LinePlanID = @LinePlanID AND LinePlanRangeID = @LinePlanRangeID AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000001'),0)
PRINT @LinePlanRangeDelAVCO - @intCount
WHILE (@intFlag <= (@LinePlanRangeDelAVCO - @intCount))
  BEGIN
            INSERT pLinePlanItem (StyleCategoryID, StyleTypeID, LinePlanItemID, LinePlanRangeID, LinePlanRangeTypeID, LinePlanID, StyleID, CUser, CDate, MUser, MDate) 
            VALUES (@StyleCategoryID, @StyleTypeID, newid(), @LinePlanRangeID, '00000000-0000-0000-0000-000000000001', @LinePlanID, '00000000-0000-0000-0000-000000000000', @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)    
            SET @intFlag = @intFlag + 1
  END

--- DELETE UN-USED STYLES 
DECLARE @Difference INT 
DECLARE @LinePlanItemID	UNIQUEIDENTIFIER 

IF @intCount > @LinePlanRangeDelAVCO
BEGIN
	SET @intFlag = 1	
	SET @Difference = @intCount - @LinePlanRangeDelAVCO 
	SET @LinePlanItemID = NULL 
	
	WHILE @Difference >= 1
	BEGIN 
		SELECT TOP 1 @LinePlanItemID = LinePlanItemID
		FROM pLinePlanItem 
		WHERE StyleCategoryID = @StyleCategoryID
		AND LinePlanRangeID = @LinePlanRangeID
		AND LinePlanRangeTypeID =  '00000000-0000-0000-0000-000000000001'
		AND LinePlanID= @LinePlanID
		AND StyleID = '00000000-0000-0000-0000-000000000000'
		IF @LinePlanItemID IS NOT NULL 
		BEGIN
			PRINT CAST (@LinePlanItemID  AS NVARCHAR(50))
			DELETE FROM pLinePlanItem WHERE LinePlanItemID = @LinePlanItemID 
		END 
		ELSE
			SET @Difference  = 0 

		SET @Difference = @Difference - 1 
	END

END  




SET @intFlag = 1
SET @intCount =  ISNULL((SELECT COUNT(*) FROM pLinePlanItem WHERE LinePlanID = @LinePlanID AND LinePlanRangeID = @LinePlanRangeID AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000002'),0)
PRINT @LinePlanRangeDelAVNV - @intCount
WHILE (@intFlag <= (@LinePlanRangeDelAVNV - @intCount))
  BEGIN
            INSERT pLinePlanItem (StyleCategoryID, StyleTypeID, LinePlanItemID, LinePlanRangeID, LinePlanRangeTypeID, LinePlanID, StyleID, CUser, CDate, MUser, MDate) 
            VALUES (@StyleCategoryID, @StyleTypeID, newid(), @LinePlanRangeID, '00000000-0000-0000-0000-000000000002', @LinePlanID, '00000000-0000-0000-0000-000000000000', @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)    
            SET @intFlag = @intFlag + 1
  END


--- DELETE UN-USED STYLES 
IF @intCount > @LinePlanRangeDelAVNV
BEGIN
	SET @intFlag = 1	
	SET @Difference = @intCount - @LinePlanRangeDelAVNV 
	SET @LinePlanItemID = NULL 
	
	WHILE @Difference >= 1
	BEGIN 
		SELECT TOP 1 @LinePlanItemID = LinePlanItemID
		FROM pLinePlanItem 
		WHERE StyleCategoryID = @StyleCategoryID
		AND LinePlanRangeID = @LinePlanRangeID
		AND LinePlanRangeTypeID =  '00000000-0000-0000-0000-000000000002'
		AND LinePlanID= @LinePlanID
		AND StyleID = '00000000-0000-0000-0000-000000000000'
		IF @LinePlanItemID IS NOT NULL 
		BEGIN
			PRINT CAST (@LinePlanItemID  AS NVARCHAR(50))
			DELETE FROM pLinePlanItem WHERE LinePlanItemID = @LinePlanItemID 
		END 
		ELSE
			SET @Difference  = 0 

		SET @Difference = @Difference - 1 
	END

END  




SET @intFlag = 1
SET @intCount =  ISNULL((SELECT COUNT(*) FROM pLinePlanItem WHERE LinePlanID = @LinePlanID AND LinePlanRangeID = @LinePlanRangeID AND LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'),0)
PRINT @LinePlanRangeDelAVN - @intCount
WHILE (@intFlag <= (@LinePlanRangeDelAVN - @intCount))
  BEGIN
            INSERT pLinePlanItem (StyleCategoryID, StyleTypeID, LinePlanItemID, LinePlanRangeID, LinePlanRangeTypeID, LinePlanID, StyleID, CUser, CDate, MUser, MDate) 
            VALUES (@StyleCategoryID, @StyleTypeID, newid(), @LinePlanRangeID, '00000000-0000-0000-0000-000000000003', @LinePlanID, '00000000-0000-0000-0000-000000000000', @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)    
            SET @intFlag = @intFlag + 1
  END


--- DELETE UN-USED STYLES 
IF @intCount > @LinePlanRangeDelAVN
BEGIN
	
	SET @intFlag = 1	
	SET @Difference = @intCount - @LinePlanRangeDelAVN 
	SET @LinePlanItemID = NULL 

	WHILE @Difference >= 1
	BEGIN 

		SELECT TOP 1 @LinePlanItemID = LinePlanItemID
		FROM pLinePlanItem 
		WHERE StyleCategoryID = @StyleCategoryID
		AND LinePlanRangeID = @LinePlanRangeID
		AND LinePlanRangeTypeID =  '00000000-0000-0000-0000-000000000003'
		AND LinePlanID= @LinePlanID
		AND StyleID = '00000000-0000-0000-0000-000000000000'

		IF @LinePlanItemID IS NOT NULL 
		BEGIN
			PRINT CAST (@LinePlanItemID  AS NVARCHAR(50))
			DELETE FROM pLinePlanItem WHERE LinePlanItemID = @LinePlanItemID 
		END 
		ELSE
			SET @Difference  = 0 

		SET @Difference = @Difference - 1 
	END

END  



-- Update No. of Options

DECLARE @TStyles1 INT 
DECLARE @TStyles2 INT 
DECLARE @TStyles3 INT 
DECLARE @TStyles4 INT 

DECLARE @TFabric1 INT 
DECLARE @TFabric2 INT 
DECLARE @TFabric3 INT 
DECLARE @TFabric4 INT 

DECLARE @TColorway1 INT 
DECLARE @TColorway2 INT 
DECLARE @TColorway3 INT 
DECLARE @TColorway4 INT 


SELECT @TStyles1 = ISNULL (a.LinePlanRangeDelTL1,0) , @TStyles2 = ISNULL (a.LinePlanRangeDelTL2,0),
@TStyles3 = ISNULL (a.LinePlanRangeDelTL3,0) , @TStyles4 = ISNULL (a.LinePlanRangeDelTL4,0)
from  pLinePlanRange a 
WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000004'
AND LinePlanID = @LinePlanID
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3

SELECT @TFabric1= ISNULL (a.LinePlanRangeDelTL1,0) , @TFabric2= ISNULL (a.LinePlanRangeDelTL2,0) ,
@TFabric3= ISNULL (a.LinePlanRangeDelTL3,0) , @TFabric4= ISNULL (a.LinePlanRangeDelTL4,0)
from  pLinePlanRange a 
WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000001'
AND LinePlanID = @LinePlanID
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3

SELECT @TColorway1 = ISNULL (a.LinePlanRangeDelTL1,0) , @TColorway2 = ISNULL (a.LinePlanRangeDelTL2,0) ,
@TColorway3 = ISNULL (a.LinePlanRangeDelTL3,0) , @TColorway4 = ISNULL (a.LinePlanRangeDelTL4,0) 
from  pLinePlanRange a 
WHERE LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'
AND LinePlanID = @LinePlanID
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3

UPDATE pLinePlanRange 
SET LinePlanRangeDelTL1 = (@TStyles1 * @TFabric1 * @TColorway1),
LinePlanRangeDelTL2 = (@TStyles2 * @TFabric2 * @TColorway2),
LinePlanRangeDelTL3 = (@TStyles3 * @TFabric3 * @TColorway3),
LinePlanRangeDelTL4 = (@TStyles4 * @TFabric4 * @TColorway4)
WHERE LinePlanID = @LinePlanID
AND LinePlanAttributeItemID3 = @LinePlanAttributeItemID3
AND LinePlanFinancialID = '10000000-0000-0000-0000-000000000005'

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03819', GetDate())
GO
