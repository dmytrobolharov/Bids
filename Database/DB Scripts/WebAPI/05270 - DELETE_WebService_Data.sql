-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 08 March 2013                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
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

-- Style Text-Image
IF EXISTS(SELECT WebServiceItemName FROM sWebServiceItem WHERE UPPER(WebServiceItemName) = UPPER('Style Text-Image'))
BEGIN
	-- Style Text-Image
	DELETE FROM sWebServiceItem WHERE WebServiceItemID='9BE36D5E-52A7-46DC-8CAF-E9F0E45268D3'	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05270', GetDate())
GO

SET NOCOUNT Off
GO
