
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 30 January 2012                                                                            */
-- * WorkItem #6868                                                                             */
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

/****** Object:  View [dbo].[vwx_SampleRequestBOMSubmitItem_SEL]    Script Date: 01/30/2012 20:26:25 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestBOMSubmitItem_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestBOMSubmitItem_SEL]
GO



/****** Object:  View [dbo].[vwx_SampleRequestBOMSubmitItem_SEL]    Script Date: 01/30/2012 20:26:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[vwx_SampleRequestBOMSubmitItem_SEL]
AS
	SELECT  pSampleRequestSubmitBOM.*,pSampleRequestWorkflowBOM.FinalDate,pSampleRequestWorkflowBOM.SampleWorkflowFinalDate,pSampleRequestSubmitStatus.Status AS 'StatusName'
	FROM	pSampleRequestSubmitBOM 
	INNER JOIN	pSampleRequestSubmitStatus	ON pSampleRequestSubmitBOM.Status = pSampleRequestSubmitStatus.StatusID
	LEFT OUTER JOIN	pSampleRequestWorkflowBOM	ON pSampleRequestSubmitBOM.SampleRequestWorkflowID = pSampleRequestWorkflowBOM.SampleRequestWorkflowID 




GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03047'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03047', GetDate())

END

GO 
