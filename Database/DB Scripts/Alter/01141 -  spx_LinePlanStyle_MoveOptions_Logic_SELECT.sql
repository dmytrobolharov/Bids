IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanStyle_MoveOptions_Logic_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanStyle_MoveOptions_Logic_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanStyle_MoveOptions_Logic_SELECT] (
	@StyleID UNIQUEIDENTIFIER 
)
AS 




--***
--** Actions :
--** 1 - Move between hierarchies
--** 2 - Move between Lineplans
--***

CREATE TABLE #tmp (
ActionID INT,
Action NVARCHAR(200)
)



-- StyleHeader is not locked 
IF NOT EXISTS ( SELECT * FROM pStyleHeader WHERE StyleID = @StyleID 
	AND HeaderLocked = 1  )
BEGIN 

	--** 1 - Move between hierarchies
	IF ( SELECT COUNT(*) FROM pStyleSeasonYear a WITH(NOLOCK)
		WHERE a.StyleID = @StyleID ) = 1 
	BEGIN
	
		--** Style with 1 season/year 
		INSERT INTO #tmp ( ActionID, Action ) 
		VALUES ( 1 , 'Move between Hierarchies') 
	END 

	--** 2 - Move between linePlans 
	IF  EXISTS (
		SELECT * FROM pStyleSeasonYear a WITH(NOLOCK)
		INNER JOIN pLinePlanItem b WITH(NOLOCK) ON a.LinePlanItemID =  b.LinePlanItemID
		WHERE a.StyleID = @StyleID
	) 
	BEGIN

		--** Style at least in 1 lineplan
		INSERT INTO #tmp ( ActionID, Action ) 
		VALUES ( 2 , 'Move between Lineplans') 	
	END 
	
	--** 3 LinePlanAttribute
	IF EXISTS  (SELECT * 
		FROM pStyleSeasonYear a WITH(NOLOCK)
			INNER JOIN dbo.pLinePlanItem b WITH(NOLOCK) ON a.LinePlanItemID =  b.LinePlanItemID
		WHERE  a.StyleID = @StyleID
		AND LinePlanStyleAttributeItemID IS NOT NULL 
	)
	BEGIN
		INSERT INTO #tmp ( ActionID, Action ) 
		VALUES ( 3 , 'Move between Attributes') 		
	END
	


END 

SELECT * FROM #tmp 
DROP TABLE #tmp




GO		

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01141', GetDate())
GO



