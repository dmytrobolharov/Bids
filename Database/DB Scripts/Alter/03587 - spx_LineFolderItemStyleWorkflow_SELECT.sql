
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 05 June 2012                                                                                */
-- * WorkItem #8771                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemStyleWorkflow_SELECT]    Script Date: 06/05/2012 14:43:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemStyleWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemStyleWorkflow_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemStyleWorkflow_SELECT]    Script Date: 06/05/2012 14:43:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LineFolderItemStyleWorkflow_SELECT]
(@StyleID uniqueidentifier
,@TeamID uniqueidentifier)
AS 

DECLARE @DevelopmentId uniqueidentifier
SELECT @DevelopmentId = DevelopmentId FROM pStyleHeader WITH (NOLOCK) WHERE StyleId = @StyleId

DECLARE @StyleTypeId INT
SELECT @StyleTypeId = StyleType FROM pStyleHeader WITH (NOLOCK) WHERE StyleId = @StyleId

DECLARE @intCount INT


CREATE TABLE #TempLineWorkflow (
	[LineId] [int] IDENTITY (1, 1) NOT NULL ,
	[Map] [uniqueidentifier] NULL ,
	[MapDetail] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StyleId] [uniqueidentifier] NULL ,
	[DevelopmentId] [uniqueidentifier] NULL ,
	[Sort] [smallint] NULL 
) 


INSERT INTO #TempLineWorkflow
    (Map, MapDetail, Sort, StyleId, DevelopmentId)
SELECT Mapping.Map, Mapping.MapDetail, pStyleWorkflow.WorkSort, @StyleID, @DevelopmentID
FROM pStyleWorkflow WITH (NOLOCK) INNER JOIN
    Mapping WITH (NOLOCK) ON pStyleWorkflow.WorkflowID = Mapping.Map INNER JOIN
    pStyleHeader WITH (NOLOCK) ON pStyleWorkflow.StyleID = pStyleHeader.StyleID
WHERE     (pStyleWorkflow.StyleID = @StyleID) AND (pStyleWorkflow.StyleSet = 1)
ORDER BY pStyleWorkflow.WorkSort


SELECT @intCount=COUNT(*) FROM sAccessCosting WHERE 	StyleTypeId = @StyleTypeId 
AND TeamId = @TeamID


IF @intCount>0
BEGIN
	INSERT INTO #TempLineWorkflow
		(Map, MapDetail, StyleId, DevelopmentId)
	VALUES
		('{50000000-0000-0000-0000-000000000005}', 'Costing', @StyleId, @DevelopmentId)
END



SELECT Map, MapDetail, StyleId, DevelopmentId FROM #TempLineWorkflow



GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.1.0000', '03587', GetDate())



GO

