/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowBOMGridTable_SELECT]    Script Date: 06/25/2013 17:03:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowBOMGridTable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowBOMGridTable_SELECT]
GO

Create  PROCEDURE [dbo].[spx_SampleWorkflowBOMGridTable_SELECT] (
@StyleDevelopmentID	UNIQUEIDENTIFIER, 
@UserID	INT, 
@Filter NVARCHAR (4000),
@SeasonYearID UNIQUEIDENTIFIER
)
AS

DECLARE @SQL NVARCHAR(4000)

--, b.SampleWorkflow, b.SampleWorkflowSort 
CREATE TABLE #tmpWorkflow (
SampleWorkflow NVARCHAR(100), 
SampleWorkflowSort NVARCHAR(5)
)

SET @SQL  =  'INSERT INTO #tmpWorkflow ( SampleWorkflow ,  SampleWorkflowSort)  SELECT b.SampleWorkflow , b.SampleWorkflowSort
FROM pSampleRequestWorkflowBOM a
INNER JOIN pSampleWorkflow b ON a.SampleWorkflowID  =  b.SampleWorkflowID 
INNER JOIN pSampleRequestBOMTrade c ON a.SampleRequestTradeID = c.SampleRequestTradeID
INNER JOIN pStyleSeasonYear d ON c.StyleSeasonYearID = d.StyleSeasonYearID
WHERE a.StyleID IN ( SELECT StyleID FROM  pStyleDevelopmentItem WHERE StyleDevelopmentID  = ''' + 
CAST (@StyleDevelopmentID AS NVARCHAR(50)) + ''' )
	AND d.SeasonYearID = ''' + CAST(@SeasonYearID AS VARCHAR(40)) + '''
	AND c.TradePartnerVendorID IS NOT NULL
'

IF @UserID IS NOT NULL 
BEGIN
	SET @SQL = @SQL +  ' AND a.AssignedTo =  '  +  CAST ( @UserID AS NVARCHAR(50)) 
END 

IF  @Filter IS NOT NULL  AND LEN(@Filter) > 0 
BEGIN 
	SET @SQL = @SQL +  ' AND ' + @Filter
END 	

SET @SQL = @SQL +  ' GROUP BY b.SampleWorkflow, b.SampleWorkflowSort'

PRINT (@SQL)
EXEC (@SQL)

SELECT SampleWorkflow FROM  #tmpWorkflow ORDER BY SampleWorkflowSort
DROP TABLE #tmpWorkflow


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05909', GetDate())
GO
