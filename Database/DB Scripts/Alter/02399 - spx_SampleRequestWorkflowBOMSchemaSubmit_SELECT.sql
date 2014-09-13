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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMSchemaSubmit_SELECT]    Script Date: 12/18/2011 18:31:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowBOMSchemaSubmit_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMSchemaSubmit_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMSchemaSubmit_SELECT]    Script Date: 12/18/2011 18:31:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMSchemaSubmit_SELECT](
	@SampleRequestTradeID UNIQUEIDENTIFIER,
	@SampleWorkflowID NVARCHAR(5),
	@Submit INT
)
AS

DECLARE @LastSubmit INT 

SELECT @LastSubmit = ISNULL(MAX(Submit),0) 
FROM pSampleRequestSubmitBOM WITH(NOLOCK)
WHERE SampleRequestTradeID  = @SampleRequestTradeID
AND SampleWorkflowID = @SampleWorkflowID


SELECT a.*, b.SummaryXML, b.EditXML, b.MaterialXML,	@LastSubmit AS LastSubmit
FROM pSampleRequestSubmitBOM a WITH(NOLOCK)
	INNER JOIN pSampleRequestWorkflowStatusSchema b WITH(NOLOCK) ON b.SampleWorkflowID = a.SampleWorkflowID AND b.StatusID = a.Status
	INNER JOIN dbo.pSampleWorkflow c WITH(NOLOCK) ON C.SampleWorkflowID = a.SampleWorkflowID
WHERE a.SampleRequestTradeID  = @SampleRequestTradeID
	AND a.SampleWorkflowID = @SampleWorkflowID
	AND a.Submit = @Submit 
	

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02399'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02399', GetDate())

END

GO
