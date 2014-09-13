-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 22 July 2010                                                                               */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_pGRPOM_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_pGRPOM_INSERT
GO


CREATE PROCEDURE [dbo].[spx_pGRPOM_INSERT]
(@POMGuidID  uniqueidentifier,
@RefCode nvarchar (12),
@POMDesc nvarchar (100),
@CompanyGuidId  uniqueidentifier,
@How2MeasText nvarchar (500),
@SortField int,
@MUser nvarchar (200),
@MDate datetime,
@CUser nvarchar(200),
@CDate datetime)
AS 

BEGIN

INSERT INTO pGRPOM
    (POMGuidID, RefCode, POMDesc, CompanyGuidId, How2MeasText, SortField, MUser,MDate,CUser,CDate)
VALUES (@POMGuidID, @RefCode, @POMDesc, @CompanyGuidId, @How2MeasText, @SortField, @MUser,@MDate,@CUser,@CDate)

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '840', GetDate())
GO
