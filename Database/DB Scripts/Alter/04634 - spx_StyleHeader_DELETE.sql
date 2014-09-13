

/****** Object:  StoredProcedure [dbo].[spx_StyleHeader_DELETE]    Script Date: 12/14/2012 15:59:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeader_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleHeader_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleHeader_DELETE]    Script Date: 12/14/2012 15:59:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleHeader_DELETE]
(@StyleID uniqueidentifier)
AS 

DECLARE @StyleDevelopmentId as uniqueidentifier
SELECT @StyleDevelopmentId = DevelopmentId FROM pStyleHeader WHERE StyleID = @StyleID

DELETE FROM pStyleHeader			WHERE StyleID = @StyleID
DELETE FROM pStyleImage				WHERE StyleID = @StyleID
DELETE FROM pStyleImageItem			WHERE StyleID = @StyleID
DELETE FROM pStyleDocument			WHERE StyleID = @StyleID
DELETE FROM pStyleHistory			WHERE StyleID = @StyleID
DELETE FROM pStyleComment			WHERE StyleID = @StyleID 
DELETE FROM pStyleChange			WHERE StyleID = @StyleID
DELETE FROM pStyleCare				WHERE StyleID = @StyleID
DELETE FROM pStyleLicensee			WHERE StyleID = @StyleID
DELETE FROM pStyleColorway			WHERE StyleID = @StyleID
DELETE FROM pStyleColorwayItem		WHERE StyleID = @StyleID
DELETE FROM pStyleDetail			WHERE StyleID = @StyleID
DELETE FROM pStyleWorkflow			WHERE StyleID = @StyleID
DELETE FROM pStyleTeam				WHERE StyleID = @StyleID
DELETE FROM pStyleMaterials			WHERE StyleID = @StyleID
DELETE FROM pStyleMaterialTemp		WHERE StyleID = @StyleID
DELETE FROM pStyleSpec				WHERE StyleID = @StyleID
DELETE FROM pStyleSpecSize			WHERE StyleID = @StyleID
DELETE FROM pStyleDevelopmentItem	WHERE StyleID = @StyleID



DELETE FROM pStyleQuoteItem			WHERE StyleID = @StyleID
DELETE FROM pStyleQuoteLog			WHERE StyleID = @StyleID
DELETE FROM pStyleQuoteVariation	WHERE StyleID = @StyleID

IF (SELECT COUNT(*) FROM pStyleDevelopmentItem WHERE StyleDevelopmentID = @StyleDevelopmentID) = 0 
BEGIN
	DELETE FROM pStyleDevelopment		WHERE StyleDevelopmentID = @StyleDevelopmentID
	DELETE FROM pStyleQuote				WHERE StyleDevelopmentID = @StyleDevelopmentID
	DELETE FROM pStyleQuoteVariation	WHERE StyleDevelopmentID = @StyleDevelopmentID
	DELETE FROM pStyleQuoteItem			WHERE StyleDevelopmentID = @StyleDevelopmentID
END



----==DELETE LINEPLAN Info
DECLARE @LinePlanAttributeItemID1 UNIQUEIDENTIFIER 
DECLARE @LinePlanAttributeItemID2 UNIQUEIDENTIFIER 
DECLARE @LinePlanAttributeItemID3 UNIQUEIDENTIFIER 
DECLARE @LinePlanAttributeItemID4 UNIQUEIDENTIFIER 
DECLARE @LinePlanID UNIQUEIDENTIFIER 
DECLARE @LinePlanRangeID UNIQUEIDENTIFIER 
DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 

/*
SELECT @LinePlanID =  LinePlanID, @LinePlanAttributeItemID1 = LinePlanAttributeItemID1, @LinePlanAttributeItemID2 = LinePlanAttributeItemID2, 
@LinePlanAttributeItemID3 = LinePlanAttributeItemID3 , @LinePlanAttributeItemID4 = LinePlanAttributeItemID4 
FROM pLinePlanBusinessItem
WHERE StyleID = @StyleID 
AND LinePlanFinancialID  = '10000000-0000-0000-0000-000000000004'
*/

SELECT @StyleSeasonYearID = c.StyleSeasonYearID,
@LinePlanID =  a.LinePlanID, @LinePlanAttributeItemID1 = a.LinePlanAttributeItemID1, 
@LinePlanAttributeItemID2 = a.LinePlanAttributeItemID2, 
@LinePlanAttributeItemID3 = a.LinePlanAttributeItemID3 , 
@LinePlanAttributeItemID4 = a.LinePlanAttributeItemID4 ,
@LinePlanRangeID = b.LinePlanRangeID
FROM pLinePlanBusinessItem a
INNER JOIN pLinePlanRange b ON  a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1
AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2
AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3
AND a.LinePlanFinancialID  = b.LinePlanFinancialID  
INNER JOIN pStyleSeasonYear c ON c.StyleID =  a.StyleID 
AND c.LinePlanID = a.LinePlanID 
where a.LinePlanFinancialID  = '10000000-0000-0000-0000-000000000004'
and a.StyleID = @StyleID


IF @LinePlanID IS NOT NULL 
BEGIN
	
	UPDATE pLinePlanItem Set StyleID  = '00000000-0000-0000-0000-000000000000' WHERE StyleID = @StyleID

	DELETE FROM  pLinePlanBusinessItem WHERE StyleID = @StyleID

/*
	EXEC dbo.spx_LinePlanBusinessItemRollup_INSERT @LinePlanId = @LinePlanId,
	@LinePlanAttributeItemId1 = @LinePlanAttributeItemId1, @LinePlanAttributeItemId2 = @LinePlanAttributeItemId2 ,
	@LinePlanAttributeItemId3 = @LinePlanAttributeItemId3 , @LinePlanAttributeItemId4 = @LinePlanAttributeItemId4
*/
		EXEC spx_LinePlanBusinessItem_QUEUE 
		@StyleQuoteItemID = NULL,
		@StyleID = NULL,
		@LinePlanID = @LinePlanID, 
		@LinePlanRangeID = @LinePlanRangeID,
		@LinePlanAttributeItemID1 = @LinePlanAttributeItemID1, 
		@LinePlanAttributeItemID2 = @LinePlanAttributeItemID2,
		@LinePlanAttributeItemID3 = @LinePlanAttributeItemID3,
		@LinePlanAttributeItemID4 = @LinePlanAttributeItemID4,
		@StyleSeasonYearID = @StyleSeasonYearID,
		@Cmd  = ''


END 


DELETE FROM pStyleSeasonYear WHERE StyleID = @StyleID
DELETE FROM pStyleColorwaySeasonYear WHERE StyleID = @StyleID

DECLARE @cursor CURSOR
DECLARE @costingID uniqueidentifier

SET @cursor  = CURSOR SCROLL
FOR
SELECT  StyleCostingID  
  FROM  pStyleCosting where StyleID=@styleID

OPEN @CURSOR

FETCH NEXT FROM @CURSOR INTO @costingID

WHILE @@FETCH_STATUS = 0
BEGIN

       exec spx_StyleCosting_DELETE2 @StyleCostingId=@costingID
       
FETCH NEXT FROM @CURSOR INTO @costingID
END
CLOSE @CURSOR


--DELETE FROM pStyleCosting			WHERE StyleID = @StyleID
DELETE FROM pStyleCostingHeader		WHERE StyleID = @StyleID

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04634', GetDate())
GO
