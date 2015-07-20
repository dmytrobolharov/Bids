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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRProductCompany_INSERT') 
DROP PROCEDURE spx_pGRProductCompany_INSERT
GO


Create PROCEDURE spx_pGRProductCompany_INSERT
(@ProductCompanyId  uniqueidentifier,
@CompanyGuidId uniqueidentifier,
@ProductId uniqueidentifier
)

AS INSERT INTO pGRProductCompany
    (ProductCompanyId, CompanyGuidId, ProductId)
VALUES (@ProductCompanyId, @CompanyGuidId, @ProductId)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '733', GetDate())
GO
