/****** Object:  StoredProcedure [dbo].[spx_LineFolder_SampleWorkflowBOMGridTable_SELECT]    Script Date: 07/09/2013 16:36:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SampleWorkflowBOMGridTable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SampleWorkflowBOMGridTable_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_SampleWorkflowBOMGridTable_SELECT]    Script Date: 07/09/2013 16:36:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LineFolder_SampleWorkflowBOMGridTable_SELECT] (
@LineFolderID UNIQUEIDENTIFIER,
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
WHERE a.StyleID IN ( SELECT DISTINCT StyleID FROM  pLineFolderItem WHERE LineFolderID  = ''' + 
CAST (@LineFolderID AS NVARCHAR(50)) + ''' )
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
VALUES ('DB_Version', '0.5.0000', '06012', GetDate())
GO
