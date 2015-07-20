-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 August 2010                                                                             */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_WSClient_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_WSClient_INSERT
GO


CREATE PROCEDURE spx_WSClient_INSERT
(
@WSClientID uniqueidentifier ,
@WSClientName nvarchar(200),
@CreatedBy nvarchar(200) = NULL,
@CreatedDate datetime = NULL
)
AS

INSERT INTO uWebServiceClient (WSClientID, WSClientName, UserName, CUser, CDate)
VALUES (@WSClientID, @WSClientName, @WSClientName, @CreatedBy, @CreatedDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '319', GetDate())
GO
