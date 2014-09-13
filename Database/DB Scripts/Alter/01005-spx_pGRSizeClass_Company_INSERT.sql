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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizeClass_Company_INSERT') 
DROP PROCEDURE spx_pGRSizeClass_Company_INSERT
GO


Create PROCEDURE spx_pGRSizeClass_Company_INSERT
(@SizeClassCompanyID   uniqueidentifier,
@SizeClassGuidID  uniqueidentifier,
@CompanyGuidID uniqueidentifier,
@SizeClass nvarchar(60),
@IsLinked int,
@CreatedBy nvarchar(100),
@CreatedDate datetime)




AS INSERT INTO pGRSizeClassCompany
    (SizeClassCompanyID, CompanyGuidID, SizeClassGuidID, SizeClass,IsLinked, CUser, CDate, MUser, MDate)
VALUES (@SizeClassCompanyID, @CompanyGuidID, @SizeClassGuidID, @SizeClass, @IsLinked, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01005', GetDate())
GO
