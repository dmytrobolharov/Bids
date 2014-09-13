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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMQASizeIndex_SELECT]    Script Date: 12/18/2011 18:52:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMQASizeIndex_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMQASizeIndex_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMQASizeIndex_SELECT]    Script Date: 12/18/2011 18:52:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMQASizeIndex_SELECT]
(
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleRequestTradeID uniqueidentifier,
	@StyleID uniqueidentifier
)
AS 

BEGIN
	SELECT TOP 1 ID FROM ( 
	SELECT 0 AS 'ID', Size0 AS 'Size', Sel0 AS Sel, Col0 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel0 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 1 AS 'ID', Size1 AS 'Size', Sel1 AS Sel, Col1 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel1 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 2 AS 'ID', Size2 AS 'Size', Sel2 AS Sel, Col2 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel2 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 3 AS 'ID', Size3 AS 'Size', Sel3 AS Sel, Col3 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel3 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 4 AS 'ID', Size4 AS 'Size', Sel4 AS Sel, Col4 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel4 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION 
	SELECT 5 AS 'ID', Size5 AS 'Size', Sel5 AS Sel, Col5 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel5 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 6 AS 'ID', Size6 AS 'Size', Sel6 AS Sel, Col6 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel6 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 7 AS 'ID', Size7 AS 'Size', Sel7 AS Sel, Col7 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel7 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 8 AS 'ID', Size8 AS 'Size', Sel8 AS Sel, Col8 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel8 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 9 AS 'ID', Size9 AS 'Size', Sel9 AS Sel, Col9 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel9 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 10 AS 'ID', Size10 AS 'Size', Sel10 AS Sel, Col10 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel10 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 11 AS 'ID', Size11 AS 'Size', Sel11 AS Sel, Col11 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel11 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 12 AS 'ID', Size12 AS 'Size', Sel12 AS Sel, Col12 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel12 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 13 AS 'ID', Size13 AS 'Size', Sel13 AS Sel, Col13 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel13 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 14 AS 'ID', Size14 AS 'Size', Sel14 AS Sel, Col14 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel14 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION 
	SELECT 15 AS 'ID', Size15 AS 'Size', Sel15 AS Sel, Col15 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel15 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 16 AS 'ID', Size16 AS 'Size', Sel16 AS Sel, Col16 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel16 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 17 AS 'ID', Size17 AS 'Size', Sel17 AS Sel, Col17 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel17 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 18 AS 'ID', Size18 AS 'Size', Sel18 AS Sel, Col18 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel18 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	UNION
	SELECT 19 AS 'ID', Size19 AS 'Size', Sel19 AS Sel, Col19 AS Col FROM pSampleRequestQASizeBOM WITH (NOLOCK) WHERE Sel19 = 1 AND (SampleRequestTradeID = @SampleRequestTradeID) AND (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleID = @StyleID)
	) AS tmpSampleRequestQASize 
	WHERE LEN (ID) > 0
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02432'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02432', GetDate())

END

GO
