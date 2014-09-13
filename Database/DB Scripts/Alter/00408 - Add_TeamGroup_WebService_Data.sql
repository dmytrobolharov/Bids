-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 9 September 2010                                                                           */
-- *                                                                                            */
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
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Team and Group
INSERT INTO sWebService(WebServiceID, WebServiceName, WebServiceDefaultSchema, Active)
VALUES ('D8ADF7C0-3DB4-4eaf-92BE-EC5A44E999F4', 'Team and Group', 'WebService_TeamGroup_Default.xml', 1)
GO

    -- Team
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('D8ADF7C0-3DB4-4eaf-92BE-EC5A44E999F4', '3EEB4CAA-9AFE-4f02-9EC8-00865DD18146', 'Team', 'WebService_TeamGroup_Team_Default.xml', 1)
    GO

    -- Group
    INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemID, WebServiceItemName, WebServiceItemDefaultSchema, Active)
    VALUES ('D8ADF7C0-3DB4-4eaf-92BE-EC5A44E999F4', '715AF9F3-6901-430f-A18E-05B84E6758E8', 'Group', 'WebService_TeamGroup_Group_Default.xml', 1)
    GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '408', GetDate())
GO
