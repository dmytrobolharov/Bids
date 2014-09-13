/****** Object:  StoredProcedure [dbo].[spx_Sourcing_SampleWorkflowBOMGridTable_SELECT]    Script Date: 04/17/2013 15:28:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_SampleWorkflowBOMGridTable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_SampleWorkflowBOMGridTable_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_SampleWorkflowBOMGridTable_SELECT]    Script Date: 04/17/2013 15:28:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Sourcing_SampleWorkflowBOMGridTable_SELECT] (
@SourcingHeaderID UNIQUEIDENTIFIER,
@Filter NVARCHAR (4000) 
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
WHERE a.StyleID IN ( SELECT StyleID FROM  pSourcingStyle WHERE SourcingHeaderID  = ''' + 
CAST (@SourcingHeaderID AS NVARCHAR(50)) + ''' )
'

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
VALUES     ('DB_Version', '0.5.0000', '05590', GetDate())
GO
