IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleWorkflowSilhoGridTable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleWorkflowSilhoGridTable_SELECT]
GO

CREATE  PROCEDURE [dbo].[spx_NPMSampleWorkflowSilhoGridTable_SELECT] (
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
FROM pSampleRequestWorkflow a
INNER JOIN pSampleWorkflow b ON a.SampleWorkflowID  =  b.SampleWorkflowID 
INNER JOIN pSampleRequestTrade c ON a.SampleRequestTradeID = c.SampleRequestTradeID
INNER JOIN pStyleSeasonYear d ON c.StyleSeasonYearID = d.StyleSeasonYearID
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL e ON c.TradePartnerRelationshipLevelID = e.TradePartnerRelationshipLevelID
WHERE a.StyleID IN ( SELECT wi.StyleID FROM pWorkFlowItemLinked link
	INNER JOIN pWorkflowItem wi ON wi.WorkFlowItemID = link.WorkFlowItemID
	INNER JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = link.StyleID
	WHERE wi.WorkflowID = ''40000000-0000-0000-0000-000000000050''
	AND sdi.StyleDevelopmentID = ''' + 
CAST (@StyleDevelopmentID AS NVARCHAR(50)) + ''' )
	AND d.SeasonYearID = ''' + CAST(@SeasonYearID AS VARCHAR(40)) + '''
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
VALUES ('DB_Version', '0.5.0000', '06019', GetDate())
GO
