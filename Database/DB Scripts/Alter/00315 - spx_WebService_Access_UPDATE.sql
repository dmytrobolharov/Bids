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


IF EXISTS (select * from sysobjects where id = object_id('spx_WebService_Access_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_WebService_Access_UPDATE
GO

CREATE PROCEDURE spx_WebService_Access_UPDATE
(
@AccessWebServiceID uniqueidentifier, 
@WebServiceSchema nvarchar (200) = NULL, 
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

IF @WebServiceSchema IS NULL
BEGIN
	UPDATE sAccessWebService  
	SET AccessRoleId = @AccessRoleId, 
	AccessView = @AccessView,  
	AccessCreate = @AccessCreate,  
	AccessModify = @AccessModify, 
	AccessDelete = @AccessDelete, 
	AccessPrint = @AccessPrint,  
	MUser = @MUser,  
	MDate = @MDate  
	WHERE AccessWebServiceID = @AccessWebServiceID
END

ELSE
BEGIN
	UPDATE sAccessWebService  
	SET WebServiceSchema = @WebServiceSchema, 
	AccessRoleId = @AccessRoleId, 
	AccessView = @AccessView,  
	AccessCreate = @AccessCreate,  
	AccessModify = @AccessModify, 
	AccessDelete = @AccessDelete, 
	AccessPrint = @AccessPrint,  
	MUser = @MUser,  
	MDate = @MDate  
	WHERE AccessWebServiceID = @AccessWebServiceID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '315', GetDate())
GO
