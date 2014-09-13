-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecItem_DELETE]    Script Date: 12/18/2011 18:49:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowBOMGridTable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowBOMGridTable_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecItem_DELETE]    Script Date: 12/18/2011 18:49:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create  PROCEDURE [dbo].[spx_SampleWorkflowBOMGridTable_SELECT] (
@StyleDevelopmentID	UNIQUEIDENTIFIER, 
@UserID	INT, 
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
WHERE a.StyleID IN ( SELECT StyleID FROM  pStyleDevelopmentItem WHERE StyleDevelopmentID  = ''' + 
CAST (@StyleDevelopmentID AS NVARCHAR(50)) + ''' )
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

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02461'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02461', GetDate())

END
