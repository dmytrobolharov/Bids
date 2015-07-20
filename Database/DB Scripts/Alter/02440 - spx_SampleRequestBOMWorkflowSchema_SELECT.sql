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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflowSchema_SELECT]    Script Date: 12/18/2011 18:56:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMWorkflowSchema_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowSchema_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMWorkflowSchema_SELECT]    Script Date: 12/18/2011 18:56:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


Create PROCEDURE [dbo].[spx_SampleRequestBOMWorkflowSchema_SELECT](
	@SampleRequestWorkflowID UNIQUEIDENTIFIER
)
AS 


SELECT TOP 1 b.Submit, b.SampleRequestSubmitID, d.MaterialXML
FROM pSampleRequestWorkflow a
	INNER JOIN dbo.pSampleRequestSubmitBOM b ON a.SampleRequestWorkflowID   = b.SampleRequestWorkflowID
	INNER JOIN dbo.pSampleWorkflow c ON c.SampleWorkflowID = b.SampleWorkflowID
	INNER JOIN pSampleRequestWorkflowStatusSchema d  ON d.StatusID = b.Status 
		AND d.SampleWorkflowID = c.SampleWorkflowID
WHERE a.SampleRequestWorkflowID = @SampleRequestWorkflowID
ORDER BY b.Submit desc



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02440'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02440', GetDate())

END

GO

