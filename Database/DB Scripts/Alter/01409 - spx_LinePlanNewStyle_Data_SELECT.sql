IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanNewStyle_Data_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanNewStyle_Data_SELECT]
GO 


CREATE PROCEDURE  dbo.spx_LinePlanNewStyle_Data_SELECT (
	@LinePlanItemID	UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@FormSQL NVARCHAR(MAX)
)
AS 

DECLARE 
	@SQL NVARCHAR(MAX),
	@StyleHeaderField NVARCHAR(200),
	@DefaultValue NVARCHAR(200),
	@ROWID INT,
	@TOTAL INT,
	@StyleType INT,
	@CustomField3 NVARCHAR(200)
	
	
SELECT  * INTO #tmp FROM pStyleHeader WHERE StyleID = @StyleID 

-- Get Default values 
CREATE TABLE #tmpDefaults ( 
RecID INT,
StyleHeaderField NVARCHAR(200),
DefaultValue NVARCHAR(200),
SetDefault INT DEFAULT 1 
)

INSERT INTO #tmpDefaults EXECUTE spx_LinePlanStyleHeaderFields_Logic_SELECT @LinePlanItemID = @LinePlanItemID, @StyleCopy = 0


SET @ROWID = 1
SELECT @TOTAL = COUNT(*) FROM #tmpDefaults

WHILE @ROWID <= @TOTAL 
BEGIN
	SELECT @StyleHeaderField = StyleHeaderField, @DefaultValue = DefaultValue FROM #tmpDefaults WHERE RecID = @ROWID

	SET @SQL = 'UPDATE #tmp SET ' + @StyleHeaderField + ' = '''  +  @DefaultValue + ''' '
	EXEC sys.sp_executesql @SQL
	
	SET @ROWID = @ROWID  + 1 
END 
DROP TABLE #tmpDefaults


SELECT * FROM #tmp
DROP TABLE #tmp

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01409', GETDATE())
GO	
