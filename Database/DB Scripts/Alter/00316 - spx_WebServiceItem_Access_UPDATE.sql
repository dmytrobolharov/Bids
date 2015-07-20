-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 August 2010                                                                             */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_WebServiceItem_Access_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_WebServiceItem_Access_UPDATE
GO

CREATE PROCEDURE spx_WebServiceItem_Access_UPDATE
(
@AccessWebServiceItemID uniqueidentifier, 
@WebServiceItemSchema nvarchar (200) = NULL, 
@AccessRoleId int, 
@AccessView int, 
@AccessCreate int, 
@AccessModify int, 
@AccessDelete int, 
@AccessPrint int, 
@MUser nvarchar (200), 
@MDate datetime
)
AS 

IF @WebServiceItemSchema IS NULL
BEGIN
	UPDATE sAccessWebServiceItem 
	SET AccessRoleId = @AccessRoleId, 
	AccessView = @AccessView,  
	AccessCreate = @AccessCreate,  
	AccessModify = @AccessModify, 
	AccessDelete = @AccessDelete, 
	AccessPrint = @AccessPrint,  
	MUser = @MUser,  
	MDate = @MDate  
	WHERE AccessWebServiceItemID = @AccessWebServiceItemID
END

ELSE
BEGIN
	UPDATE sAccessWebServiceItem 
	SET WebServiceItemSchema = @WebServiceItemSchema, 
	AccessRoleId = @AccessRoleId, 
	AccessView = @AccessView,  
	AccessCreate = @AccessCreate,  
	AccessModify = @AccessModify, 
	AccessDelete = @AccessDelete, 
	AccessPrint = @AccessPrint,  
	MUser = @MUser,  
	MDate = @MDate  
	WHERE AccessWebServiceItemID = @AccessWebServiceItemID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '316', GetDate())
GO
