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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRTolerance_INSERT') 
DROP PROCEDURE spx_pGRTolerance_INSERT
GO


Create PROCEDURE spx_pGRTolerance_INSERT
(@ToleranceGuidId  uniqueidentifier,
@ProductClassImageId uniqueidentifier,
@POMCompanyId uniqueidentifier,
@CUser nvarchar(100),
@CDate datetime)


AS 
INSERT INTO pGRTolerance
    (ToleranceGuidId, ProductClassImageId, POMCompanyId, CUser, CDate, MUser, MDate)
VALUES (@ToleranceGuidId, @ProductClassImageId, @POMCompanyId, @CUser, @CDate, @CUser, @CDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01023', GetDate())
GO
