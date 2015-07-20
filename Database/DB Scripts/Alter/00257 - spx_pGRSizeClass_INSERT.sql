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


Alter PROCEDURE spx_pGRSizeClass_INSERT
(@SizeClassCompanyID   uniqueidentifier,
@SizeClassGuidID  uniqueidentifier,
@CompanyGuidID uniqueidentifier)



AS INSERT INTO pGRSizeClassCompany
    (SizeClassCompanyID, CompanyGuidID, SizeClassGuidID)
VALUES (@SizeClassCompanyID, @CompanyGuidID, @SizeClassGuidID)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '256', GetDate())
GO
