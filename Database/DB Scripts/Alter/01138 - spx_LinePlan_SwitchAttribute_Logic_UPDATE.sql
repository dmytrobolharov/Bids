
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_SwitchAttribute_Logic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlan_SwitchAttribute_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_LinePlan_SwitchAttribute_Logic_UPDATE] (
	@StyleID UNIQUEIDENTIFIER,
	@AttributeID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS

DECLARE 
	@LinePlanAttributeTypeID UNIQUEIDENTIFIER,
	@AttributeName NVARCHAR(200),
	@LinePlanAttributeText1 NVARCHAR(200),
	@LinePlanAttributeText2 NVARCHAR(200),
	@LinePlanAttributeText3 NVARCHAR(200)

DECLARE 
	@StyleLinkID UNIQUEIDENTIFIER,
	@ROWID INT,
	@TOTAL INT,
	@tmpStyleID UNIQUEIDENTIFIER, 
	@LinePlanStyleAttributeItemID UNIQUEIDENTIFIER, 
	@LinePlanItemID UNIQUEIDENTIFIER,
	@LinePlanRangeTypeID UNIQUEIDENTIFIER,
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@AvaliableLinePlanItemID UNIQUEIDENTIFIER ,
	@LinePlanID UNIQUEIDENTIFIER ,
	@NewLinePlanStyleAttributeItemID UNIQUEIDENTIFIER,
	@StyleTypeID INT 

	
SELECT @StyleLinkID = StyleLinkID  
FROM dbo.pStyleHeader a
WHERE StyleID = @StyleID

SELECT @AttributeName = AttributeName FROM dbo.pLinePlanStyleAttribute WITH(NOLOCK) WHERE AttributeID = @AttributeID

CREATE TABLE  #sty (
	ROWID INT IDENTITY(1,1),
	StyleID UNIQUEIDENTIFIER, 
	LinePlanStyleAttributeItemID UNIQUEIDENTIFIER, 
	LinePlanItemID UNIQUEIDENTIFIER,
	LinePlanRangeTypeID	UNIQUEIDENTIFIER,
	LinePlanRangeID UNIQUEIDENTIFIER,
	LinePlanID UNIQUEIDENTIFIER,
	NewLinePlanItemID UNIQUEIDENTIFIER,
	StyleTypeID INT
)

-- Current Lineplanitem

IF @StyleLinkID IS NOT NULL
BEGIN 

	INSERT INTO #sty(LinePlanStyleAttributeItemID, LinePlanItemID, StyleID, LinePlanRangeTypeID, LinePlanRangeID, LinePlanID, StyleTypeID)
	SELECT b.LinePlanStyleAttributeItemID, 
		b.LinePlanItemID, b.StyleID, b.LinePlanRangeTypeID, b.LinePlanRangeID, b.LinePlanID, c.StyleType
	FROM dbo.pStyleSeasonYear  a
		INNER JOIN pLinePlanItem b ON a.LinePlanItemID = b.LinePlanItemID
		INNER JOIN pStyleHeader c ON c.StyleID = a.StyleID
	WHERE c.StyleLinkID = @StyleLinkID
	
END 
ELSE 
BEGIN

	INSERT INTO #sty(LinePlanStyleAttributeItemID, LinePlanItemID, StyleID, LinePlanRangeTypeID, LinePlanRangeID, LinePlanID, StyleTypeID )
	SELECT b.LinePlanStyleAttributeItemID, 
		b.LinePlanItemID, b.StyleID, b.LinePlanRangeTypeID, b.LinePlanRangeID, b.LinePlanID, d.StyleType
	FROM dbo.pStyleSeasonYear  a
		INNER JOIN pLinePlanItem b ON a.LinePlanItemID = b.LinePlanItemID
		INNER JOIN dbo.pLinePlanRange c ON c.LinePlanRangeID =  b.LinePlanRangeID
		INNER JOIN dbo.pStyleHeader d ON d.StyleID =  a.StyleID 
	WHERE a.StyleID = @StyleID
	
END

	
SET @ROWID = 1
SELECT @TOTAL = COUNT(*) FROM #sty 

WHILE @ROWID <= @TOTAL 
BEGIN
	
	SELECT @tmpStyleID = StyleID, @LinePlanStyleAttributeItemID = LinePlanStyleAttributeItemID, 
		@LinePlanItemID = LinePlanItemID, @LinePlanRangeTypeID = LinePlanRangeTypeID,
		@LinePlanRangeID = LinePlanRangeID, @LinePlanID = LinePlanID, @StyleTypeID = StyleTypeID
	FROM #sty WHERE ROWID = @ROWID 
	
	-- Get the new LineplanItem  
	SET @AvaliableLinePlanItemID = NULL 
	SET @NewLinePlanStyleAttributeItemID = NULL
		
	SELECT  TOP 1  @AvaliableLinePlanItemID = a.LinePlanItemID , @NewLinePlanStyleAttributeItemID = a.LinePlanStyleAttributeItemID
	FROM pLinePlanItem a
		INNER JOIN pLinePlanStyleAttributeItem b ON a.LinePlanStyleAttributeItemID = b.LinePlanStyleAttributeItemID
		INNER JOIN pLinePlanStyleAttribute c ON c.LinePlanStyleAttributeID = b.LineplanStyleAttributeID
	WHERE a.LinePlanRangeID = @LinePlanRangeID 
	AND LinePlanRangeTypeID = @LinePlanRangeTypeID
	AND a.StyleID = '00000000-0000-0000-0000-000000000000'
	AND c.AttributeID = @AttributeID
	AND a.LinePlanID = @LinePlanID
	
	
	IF @AvaliableLinePlanItemID  IS NOT NULL AND @NewLinePlanStyleAttributeItemID IS NOT NULL 
	BEGIN 
		UPDATE pLineplanItem SET LinePlanStyleAttributeItemID = @NewLinePlanStyleAttributeItemID
		WHERE LinePlanItemID = @LinePlanItemID
		
		UPDATE pLineplanItem SET LinePlanStyleAttributeItemID = @LinePlanStyleAttributeItemID
		WHERE LinePlanItemID = @AvaliableLinePlanItemID
		
		-- Hard LLG or Hard SLG 
		IF @StyleTypeID = 22 OR @StyleTypeID = 23 
			UPDATE pStyleHeader SET CustomField10 = @AttributeName  WHERE StyleID =  @tmpStyleID
		ELSE IF @StyleTypeID = 18 
			UPDATE pStyleHeader SET CustomField20 = @AttributeName  WHERE StyleID =  @tmpStyleID
		
	END 


	SET @ROWID  = @ROWID + 1
END 

--SELECT * FROM #sty		
	
DROP TABLE #sty	
	
	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01138', GetDate())
GO





