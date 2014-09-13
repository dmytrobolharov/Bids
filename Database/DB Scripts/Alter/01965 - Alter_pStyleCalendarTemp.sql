-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 23 September 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */

/*------------------------------------------------------------------------------------------------                               
* Name        : spx_Material_SampleRequestWorkflowAgentLate_SELECT
*
* Description : Alter script for pstylecalendartemp for material sample
*
* Change History:                  
* ------------------
* Date			Version			Author			Comment
* 09/23/2011	  --			Yogesh Lad		Alter script for pstylecalendartemp for material
												sample.
-------------------------------------------------------------------------------------------------*/ 
GO

ALTER TABLE pStyleCalendarTemp 
ALTER COLUMN PKeyId VARCHAR(200) NULL

ALTER TABLE pStyleCalendarTemp
ADD CalendarLinkSubId1 uniqueIdentifier NULL


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01965'))
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
			,'01965'
			,GetDate()
		)
END	
GO

 