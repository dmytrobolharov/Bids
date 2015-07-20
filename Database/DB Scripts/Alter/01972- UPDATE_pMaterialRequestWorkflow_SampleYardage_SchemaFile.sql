-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 28 September 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
Go 


IF EXISTS(SELECT MaterialRequestWorkflowID from pMaterialRequestWorkflow WHERE MaterialRequestWorkflowID='A94' AND MaterialRequestWorkflow='Sample Yardage')
BEGIN

	UPDATE pMaterialRequestWorkflow 
	SET MaterialRequestWorkflowSchema='Material_RequestSubmitItemSampleYardage.xml' 
	WHERE MaterialRequestWorkflowID='A94' 
	AND MaterialRequestWorkflow='Sample Yardage'
	
END


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01972'))
BEGIN
	INSERT INTO sVersion
		(
			AppName
			,[Version]
			,LastScriptRun
			,[TimeStamp]
		)
	VALUES     
		(
			'DB_Version'
			,'4.1.0000'
			,'01972'
			,GetDate()
		)
END	
GO

 