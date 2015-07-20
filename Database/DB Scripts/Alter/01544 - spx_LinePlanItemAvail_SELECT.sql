IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanItemAvail_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanItemAvail_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanItemAvail_SELECT](
	@LinePlanRangeTypeID UNIQUEIDENTIFIER,
	@LinePlanRangeID UNIQUEIDENTIFIER,
	@LinePlanID UNIQUEIDENTIFIER,
	@LinePlanItemID UNIQUEIDENTIFIER
)
AS


CREATE TABLE #LinePlanItemAvail (
	ID int NOT NULL IDENTITY (1, 1),
	LinePlanItemID UNIQUEIDENTIFIER
)

DECLARE 
	@LinePlanStyleAttributeItemID UNIQUEIDENTIFIER,
	@StyleTypeID INT

SELECT @LinePlanStyleAttributeItemID  = LinePlanStyleAttributeItemID, @StyleTypeID = StyleTypeID 
FROM pLinePlanItem WITH(NOLOCK)
WHERE LinePlanItemID = @LinePlanItemID


-- Soft Accessories (18), Hard LLG (22), or Hard SLG (23) 
IF @LinePlanStyleAttributeItemID IS NOT NULL AND ( @StyleTypeID IN (18, 22, 23) )

BEGIN 

	INSERT INTO #LinePlanItemAvail (LinePlanItemID) 
	SELECT LinePlanItemID 
	FROM dbo.pLinePlanItem
	WHERE LinePlanRangeID = @LinePlanRangeID 
		AND LinePlanRangeTypeID = @LinePlanRangeTypeID 
		AND StyleID = '00000000-0000-0000-0000-000000000000'
		AND LinePlanStyleAttributeItemID = @LinePlanStyleAttributeItemID

END 		
ELSE 

BEGIN 

	INSERT INTO #LinePlanItemAvail (LinePlanItemID) 
	SELECT LinePlanItemID 
	FROM pLinePlanItem WITH (NOLOCK) 
	WHERE LinePlanID = @LinePlanID 
		AND LinePlanRangeID = @LinePlanRangeID 
		AND LinePlanRangeTypeID = @LinePlanRangeTypeID 
		AND StyleID = '00000000-0000-0000-0000-000000000000'
END 


SELECT ID, LinePlanItemID FROM #LinePlanItemAvail

DROP TABLE #LinePlanItemAvail


GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01544'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01544', GetDate())
END	

GO

