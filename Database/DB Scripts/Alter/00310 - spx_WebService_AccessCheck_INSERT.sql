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


IF EXISTS (select * from sysobjects where id = object_id('spx_WebService_AccessCheck_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_WebService_AccessCheck_INSERT
GO


CREATE PROCEDURE spx_WebService_AccessCheck_INSERT
(
@WSClientID uniqueidentifier ,
@CreatedBy nvarchar(200) = NULL,
@CreatedDate datetime = NULL
)
AS

DECLARE @I as int
DECLARE @Row_Count int
DECLARE @WebServiceID uniqueidentifier 
DECLARE @AccessRoleID int

SET @AccessRoleID = 0
SET @I = 1

	BEGIN
	CREATE TABLE #TempWebServiceAccess (
		Id int IDENTITY (1, 1) NOT NULL , 
		WebServiceID uniqueidentifier NOT NULL 
	) 
	END


	BEGIN
	INSERT INTO #TempWebServiceAccess
		(WebServiceID)
	SELECT WebServiceID FROM sWebService WITH (NOLOCK) 

	SET @Row_Count = (SELECT COUNT(*) FROM #TempWebServiceAccess)

	WHILE @I <= @Row_Count 
		BEGIN
			SELECT @WebServiceID = WebServiceID FROM #TempWebServiceAccess WHERE ID = @I

			IF (SELECT COUNT(*) FROM sAccessWebService WITH (NOLOCK) WHERE WebServiceID = @WebServiceID AND WSClientID = @WSClientID) = 0
			BEGIN
				INSERT INTO sAccessWebService
					(WebServiceID, WebServiceSchema, AccessRoleID, WSClientID, CUser, CDate, MUser, MDate)
				SELECT WebServiceID, WebServiceDefaultSchema, @AccessRoleID, @WSClientID,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
				FROM sWebService WITH (NOLOCK) WHERE WebServiceID = @WebServiceID
			END

			SET @I = @I + 1
		END

		SELECT * FROM #TempWebServiceAccess

	END


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '310', GetDate())
GO
