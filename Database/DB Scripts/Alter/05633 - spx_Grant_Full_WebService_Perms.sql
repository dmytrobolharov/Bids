-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 30 April 2013                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
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


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Grant_Full_WebService_Perms]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_Grant_Full_WebService_Perms]
GO

CREATE  PROCEDURE [dbo].[spx_Grant_Full_WebService_Perms]
(
	@WSClientID nvarchar(50)
)
AS
	DECLARE @AccessRoleID int
	SET @AccessRoleID = 3

	-----------------------
	-- sAccessWebService --
	-----------------------
	DELETE FROM sAccessWebService
	WHERE [WSClientID] = @WSClientID

	INSERT INTO sAccessWebService
		([WebServiceID], [WebServiceSchema], [AccessRoleID], 
		[WSClientID], [AccessView], [CUser], [CDate], [MUser], [MDate])
	SELECT [WebServiceID], [WebServiceDefaultSchema], @AccessRoleID,
		@WSClientID, 1, [CUser], [CDate], [MUser], [MDate]
	FROM  sWebService
	WHERE Active = 1


	---------------------------
	-- sAccessWebServiceItem --
	---------------------------
	DELETE FROM sAccessWebServiceItem
	WHERE [WSClientID] = @WSClientID

	INSERT INTO sAccessWebServiceItem
		([WebServiceID], [WebServiceItemID], [WebServiceItemSchema],
		[AccessRoleID], [AccessView], [WSClientID], [CUser], [CDate], [MUser], [MDate])
	SELECT [WebServiceID], [WebServiceItemID],  [WebServiceItemDefaultSchema],
		@AccessRoleID, 1, @WSClientID, [CUser], [CDate], [MUser], [MDate]
	FROM  sWebServiceItem
	WHERE Active = 1
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05633', GetDate())
GO

SET NOCOUNT Off
GO
