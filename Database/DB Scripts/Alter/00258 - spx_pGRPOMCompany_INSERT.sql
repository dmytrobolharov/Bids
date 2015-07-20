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

IF EXISTS (select * from sysobjects where id = object_id('spx_pGRPOMCompany_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_pGRPOMCompany_INSERT
GO

CREATE PROCEDURE spx_pGRPOMCompany_INSERT
(@POMCompanyId  uniqueidentifier,
@CompanyGuidID uniqueidentifier,
@POMAlternatesId uniqueidentifier,
@CUser nvarchar(200),
@CDate datetime)
AS INSERT INTO pGRPOMCompany
    (POMCompanyId, CompanyGuidID, POMAlternatesId, CUser,CDate)
VALUES (@POMCompanyId, @CompanyGuidID, @POMAlternatesId,@CUser,@CDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '255', GetDate())
GO
