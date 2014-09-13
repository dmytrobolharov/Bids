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


IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRCompany_DELETE') 
DROP PROCEDURE spx_pGRCompany_DELETE
GO


Create PROCEDURE spx_pGRCompany_DELETE
(@CompanyGuidId uniqueidentifier)


AS 

DELETE FROM  dbo.pGRCompany WHERE CompanyGuidId= @CompanyGuidId
DELETE FROM  dbo.pGRPOMCompany WHERE CompanyGuidId= @CompanyGuidId
DELETE FROM  dbo.pGRProductCompany WHERE (CompanyGuidId= @CompanyGuidId)
DELETE FROM  dbo.pGRSizeClassCompany WHERE (CompanyGuidId= @CompanyGuidId)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01034', GetDate())
GO
