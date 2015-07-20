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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecItemLinked_SELECT]    Script Date: 12/18/2011 19:01:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMSpecItemLinked_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMSpecItemLinked_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMSpecItemLinked_SELECT]    Script Date: 12/18/2011 19:01:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMSpecItemLinked_SELECT]
(@SampleRequestWorkflowID uniqueidentifier,
@SampleRequestTradeID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int,
@Submit int)
AS 
SELECT * FROM  pSampleRequestSpecItemBOM WITH (NOLOCK)
WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND 
		(SampleRequestTradeID = @SampleRequestTradeID) AND 
		(StyleID = @StyleID) AND 
		(StyleSet = @StyleSet)AND 
		(Submit = @Submit)AND 
		(POMTempID IS NOT NULL)
ORDER BY Sort, POM

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02447'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02447', GetDate())

END

GO