
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_MoveTo_AttributesLogic_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_MoveTo_AttributesLogic_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlan_MoveTo_AttributesLogic_SELECT] (
	@StyleID UNIQUEIDENTIFIER 
)
AS 


DECLARE 
	@StyleLinkID UNIQUEIDENTIFIER,
	@Count INT,
	@LinePlanAttributeTypeID INT, 
	@AttributeID UNIQUEIDENTIFIER,
	@AttributeName NVARCHAR(200),
	@LinePlanAttributeText1  NVARCHAR(200), 
	@LinePlanAttributeText2  NVARCHAR(200),
	@LinePlanAttributeText3  NVARCHAR(200),
	@LinePlanID UNIQUEIDENTIFIER,
	@ROWID INT,
	@TOTAL INT,
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@LinePlanRangeTypeID UNIQUEIDENTIFIER,
	@QTY INT


SELECT  @StyleLinkID = StyleLinkID FROM dbo.pStyleHeader WHERE StyleID = @StyleID 


-- Current Attribute
--- > SHOULD TAKE ATTRIBUTE FROM pStyleheader  ... 
SELECT TOP  1 
	@LinePlanAttributeTypeID = d.LinePlanAttributeTypeID, @AttributeID = d.AttributeID,
	@AttributeName = d.AttributeName,
	@LinePlanAttributeText1 = e.LinePlanAttributeText1, @LinePlanAttributeText2 = e.LinePlanAttributeText2, 
	@LinePlanAttributeText3 = e.LinePlanAttributeText3
FROM dbo.pStyleSeasonYear  a
	INNER JOIN pLinePlanItem b ON a.LinePlanItemID = b.LinePlanItemID
	INNER JOIN dbo.pLinePlanRange e ON e.LinePlanRangeID =  b.LinePlanRangeID
	INNER JOIN dbo.pLinePlanStyleAttributeItem c ON c.LinePlanStyleAttributeItemID = b.LinePlanStyleAttributeItemID
	INNER JOIN  pLinePlanStyleAttribute d ON d.LinePlanStyleAttributeID = c.LineplanStyleAttributeID
WHERE a.StyleID = @StyleID 

CREATE TABLE #lpr (
	ROWID INT IDENTITY (1,1),
	LinePlanID UNIQUEIDENTIFIER, 
	AttributeID  UNIQUEIDENTIFIER,
	AttributeName NVARCHAR(200),
	LinePlanRangeTypeID  UNIQUEIDENTIFIER
)


CREATE TABLE #tmp (
	ROWID INT IDENTITY (1,1),
	LinePlanRangeID UNIQUEIDENTIFIER,
	LinePlanRangeTypeID UNIQUEIDENTIFIER,
	QTY INT,
	Active INT 
)

IF @StyleLinkID IS NOT NULL
	INSERT INTO #tmp (LinePlanRangeID, LinePlanRangeTypeID, QTY, Active  )
	SELECT c.LinePlanRangeID,  c.LinePlanRangeTypeID, COUNT(*), 0 
	FROM pStyleHeader a
		INNER JOIN dbo.pStyleSeasonYear b ON a.StyleID = b.StyleID
		INNER JOIN dbo.pLinePlanItem c ON c.LinePlanItemID = b.LinePlanItemID
			AND c.StyleID =  b.StyleID 	
	WHERE a.StyleLinkID = @StyleLinkID
	GROUP BY c.LinePlanRangeID,c.LinePlanRangeTypeID
ELSE
	INSERT INTO #tmp (LinePlanRangeID, LinePlanRangeTypeID, QTY, Active  )
	SELECT c.LinePlanRangeID,  c.LinePlanRangeTypeID, COUNT(*), 0 
	FROM pStyleHeader a
		INNER JOIN dbo.pStyleSeasonYear b ON a.StyleID = b.StyleID
		INNER JOIN dbo.pLinePlanItem c ON c.LinePlanItemID = b.LinePlanItemID
			AND c.StyleID =  b.StyleID 	
	WHERE a.StyleID = @StyleID
	GROUP BY c.LinePlanRangeID,c.LinePlanRangeTypeID



SET @ROWID = 1
SELECT @TOTAL = COUNT(*) FROM #tmp

WHILE @ROWID <= @TOTAL 
BEGIN 


	SELECT @LinePlanRangeID = LinePlanRangeID, @LinePlanRangeTypeID = LinePlanRangeTypeID, @QTY = QTY 
	FROM #tmp WHERE ROWID = @ROWID 
	
	INSERT INTO #lpr ( LinePlanID, AttributeID, AttributeName, LinePlanRangeTypeID)
	SELECT a.LinePlanID, c.AttributeID, c.AttributeName, a.LinePlanRangeTypeID
	FROM pLineplanItem a
		INNER JOIN dbo.pLinePlanStyleAttributeItem b ON b.LinePlanStyleAttributeItemID = a.LinePlanStyleAttributeItemID
		INNER JOIN pLinePlanStyleAttribute c ON c.LinePlanStyleAttributeID = b.LineplanStyleAttributeID
	WHERE a.LinePlanRangeID = @LinePlanRangeID 
	AND a.StyleID = '00000000-0000-0000-0000-000000000000' 
	AND a.LinePlanRangeTypeID = @LinePlanRangeTypeID
	AND c.AttributeID <> @AttributeID
	AND c.AttributeName <> @AttributeName 
	GROUP BY a.LinePlanID, c.AttributeID, c.AttributeName, a.LinePlanRangeTypeID
	HAVING COUNT(*) >= @Qty
	
	SET @ROWID = @ROWID + 1 
	
END 



SELECT AttributeID, AttributeName from #lpr
GROUP BY AttributeID, AttributeName
HAVING COUNT(*) >= @TOTAL


----- Get list of attributes available in the same hierarchy in all lineplans 

--SELECT b.LinePlanID, d.AttributeID,d.AttributeName,  b.LinePlanRangeTypeID ,COUNT(*) AS Qty
--FROM (
--	SELECT  a.LinePlanID
--	FROM dbo.pStyleSeasonYear a
--		INNER JOIN dbo.pLinePlanItem b ON a.LinePlanItemID = b.LinePlanItemID
--		INNER JOIN dbo.pLinePlanRange c ON c.LinePlanRangeID = b.LinePlanRangeID
--	WHERE a.StyleID = @StyleID
--) AS foo
--	INNER JOIN pLinePlanItem b ON foo.LinePlanID =  b.LinePlanID
--	INNER JOIN dbo.pLinePlanRange c ON b.LinePlanRangeID = c.LinePlanRangeID
--	INNER JOIN dbo.pLinePlanStyleAttributeItem e ON e.LinePlanStyleAttributeItemID = b.LinePlanStyleAttributeItemID
--	INNER JOIN pLinePlanStyleAttribute d ON d.LinePlanStyleAttributeID = e.LineplanStyleAttributeID
--WHERE b.StyleID = '00000000-0000-0000-0000-000000000000'
--AND c.LinePlanAttributeText1 = @LinePlanAttributeText1
--AND c.LinePlanAttributeText2 = @LinePlanAttributeText2 
--AND c.LinePlanAttributeText3 = @LinePlanAttributeText3
--AND d.AttributeID <> @AttributeID
--AND d.AttributeName <> @AttributeName 
--GROUP BY b.LinePlanID, d.AttributeID,d.AttributeName, b.LinePlanRangeTypeID
--HAVING COUNT(*) >= @Count
--ORDER BY Qty


--SELECT @AttributeName

--SELECT c.LinePlanAttributeText1,c.LinePlanAttributeText2, c.LinePlanAttributeText3,
--b.LinePlanID, d.AttributeID,d.AttributeName,  b.LinePlanRangeTypeID 
--FROM (
--	SELECT  a.LinePlanID
--	FROM dbo.pStyleSeasonYear a
--		INNER JOIN dbo.pLinePlanItem b ON a.LinePlanItemID = b.LinePlanItemID
--		INNER JOIN dbo.pLinePlanRange c ON c.LinePlanRangeID = b.LinePlanRangeID
--	WHERE a.StyleID = @StyleID
--) AS foo
--	INNER JOIN pLinePlanItem b ON foo.LinePlanID =  b.LinePlanID
--	INNER JOIN dbo.pLinePlanRange c ON b.LinePlanRangeID = c.LinePlanRangeID
--	INNER JOIN dbo.pLinePlanStyleAttributeItem e ON e.LinePlanStyleAttributeItemID = b.LinePlanStyleAttributeItemID
--	INNER JOIN pLinePlanStyleAttribute d ON d.LinePlanStyleAttributeID = e.LineplanStyleAttributeID
--WHERE b.StyleID = '00000000-0000-0000-0000-000000000000'
--AND c.LinePlanAttributeText1 = @LinePlanAttributeText1
--AND c.LinePlanAttributeText2 = @LinePlanAttributeText2 
--AND c.LinePlanAttributeText3 = @LinePlanAttributeText3
--AND d.AttributeID <> @AttributeID
--AND d.AttributeName <> @AttributeName 
--ORDER BY d.AttributeName


	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01137', GetDate())
GO







