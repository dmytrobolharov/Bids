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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizeClassCompany_Relink') 
DROP PROCEDURE spx_pGRSizeClassCompany_Relink
GO


Create PROCEDURE spx_pGRSizeClassCompany_Relink
(@SizeClassCompanyId uniqueidentifier,
@IsLinked int,
@MUser nvarchar(100),
@MDate datetime)


AS 
UPDATE pGRSizeClassCompany
    SET SizeClass = (select SizeClass from pGRSizeClass where SizeClassGuidId = pGRSizeClassCompany.SizeClassGuidId),
	IsLinked = @IsLinked, 
	 MUser = @MUser, 
	 MDate = @MDate
	
WHERE SizeClassCompanyId=@SizeClassCompanyId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01001', GetDate())
GO
