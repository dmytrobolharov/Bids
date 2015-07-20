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

/****** Object:  View [dbo].[vwx_SampleRequestSubmitItem_SEL]    Script Date: 12/18/2011 17:55:43 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestSubmitItem_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestSubmitItem_SEL]
GO



/****** Object:  View [dbo].[vwx_SampleRequestSubmitItem_SEL]    Script Date: 12/18/2011 17:55:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[vwx_SampleRequestSubmitItem_SEL]
AS

	SELECT a.* , b.Status AS StatusName
	FROM pSampleRequestSubmit a
	INNER JOIN pSampleRequestSubmitStatus b  ON a.Status =  b.StatusID


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02360'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02360', GetDate())

END

GO