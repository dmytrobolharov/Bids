-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 9 March 2011                                                                               */
-- *                                                                                            */
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
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF NOT EXISTS (SELECT * FROM pBOLApprove WHERE UPPER(CustomKey) = '0')
BEGIN

    INSERT INTO pBOLApprove ([CustomKey], [Custom], [CustomBoolean], [Active]) 
    VALUES
			('0'
			,'No' 
			,0 
			,'True')
END

IF NOT EXISTS (SELECT * FROM pBOLApprove WHERE UPPER(CustomKey) = '1')
BEGIN

    INSERT INTO pBOLApprove ([CustomKey], [Custom], [CustomBoolean], [Active]) 
    VALUES
			('1'
			,'Yes' 
			,1 
			,'True')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01750', GetDate())
GO

SET NOCOUNT Off
GO
