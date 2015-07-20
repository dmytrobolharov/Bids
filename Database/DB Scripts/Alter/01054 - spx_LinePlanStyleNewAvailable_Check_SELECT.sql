IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyleNewAvailable_Check_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanStyleNewAvailable_Check_SELECT]
GO

CREATE PROCEDURE dbo.spx_LinePlanStyleNewAvailable_Check_SELECT(
@Total INT,
@LinePlanRangeTypeID UNIQUEIDENTIFIER,
@LinePlanRangeID UNIQUEIDENTIFIER,
@ClientSessionID NVARCHAR(40),
@TeamID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@LinePlanItemID UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@TotalStyleLinked INT,
	@LinePlanItemAvailable INT,
	@LinePlanStyleAttributeItemID UNIQUEIDENTIFIER,
	@Msg NVARCHAR(2000)

SELECT @TotalStyleLinked = COUNT(*)
FROM pLinePlanStyleLinkedTemp a
	INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID
	INNER JOIN pStyleHeader c ON b.StyleLinkID = c.StyleLinkID
WHERE c.StyleID = @StyleID
AND a.TeamID = @TeamID 
AND a.ClientSessionID = @ClientSessionID 


IF @TotalStyleLinked = 0
	SET @TotalStyleLinked = 1 



IF @LinePlanItemID IS NOT NULL 
BEGIN 
	SELECT @LinePlanStyleAttributeItemID = LinePlanStyleAttributeItemID 
	FROM dbo.pLinePlanItem WHERE LinePlanItemID = @LinePlanItemID 
END 
	
	
	
IF @LinePlanStyleAttributeItemID IS NULL 
BEGIN 
	SELECT @LinePlanItemAvailable =  COUNT(*) 
	FROM pLinePlanItem 	WITH(NOLOCK) 
	WHERE LinePlanRangeID = @LinePlanRangeID
		AND LinePlanRangeTypeID =  @LinePlanRangeTypeID
		AND StyleID =  '00000000-0000-0000-0000-000000000000'
END 
ELSE 
BEGIN 
	
	SELECT @LinePlanItemAvailable =  COUNT(*) 
	FROM pLinePlanItem 	WITH(NOLOCK) 
	WHERE LinePlanRangeID = @LinePlanRangeID
		AND LinePlanRangeTypeID =  @LinePlanRangeTypeID
		AND StyleID =  '00000000-0000-0000-0000-000000000000'	
		AND LinePlanStyleAttributeItemID = @LinePlanStyleAttributeItemID

END 	
	
IF 	@LinePlanItemAvailable < (@TotalStyleLinked * @Total)
	SET @Msg = 'No enough slots available' 


SELECT @Msg

SELECT a.StyleID
FROM pLinePlanStyleLinkedTemp a
	INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID
	INNER JOIN pStyleHeader c ON b.StyleLinkID = c.StyleLinkID
WHERE c.StyleID = @StyleID
AND a.TeamID = @TeamID 
AND a.ClientSessionID = @ClientSessionID 

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01054', GetDate())
GO

	
	
	





