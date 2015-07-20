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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMMaterialTemplateSchema_SELECT]    Script Date: 12/18/2011 19:02:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMMaterialTemplateSchema_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMMaterialTemplateSchema_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMMaterialTemplateSchema_SELECT]    Script Date: 12/18/2011 19:02:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[spx_SampleRequestBOMMaterialTemplateSchema_SELECT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER
)
AS 

DECLARE 
	@SampleWorkflowID  NVARCHAR(5)
	
SELECT @SampleWorkflowID  = a.SampleWorkflowID
FROM pSampleRequestSubmitBOM a WITH(NOLOCK)
WHERE a.SampleRequestSubmitID = @SampleRequestSubmitID

SELECT TOP 1  b.ControlPanelSchema AS SchemaGridDefault, a.ControlPanelItemSchema AS SchemaTemplateItemGrid,
	a.SampleRequestSubmitGroupSearch, a.SampleRequestSubmitGroupDefault, a.SPXSampleRequestSubmitGroupInsert,
	a.SampleRequestSubmitGroupXML
FROM pStyleDetailGridControl a
	INNER JOIN dbo.pControlPanel b ON a.ControlPanelID =  b.ControlPanelID
WHERE a.SampleWorkflowID  = @SampleWorkflowID 



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02450'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02450', GetDate())

END

GO