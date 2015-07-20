-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 11 August 2010                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */                                                                     */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS                                                                                    
--
--
--set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


IF EXISTS (select * from sysobjects where id = object_id('spx_pGRCompany_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_pGRCompany_DELETE
GO

CREATE PROCEDURE [dbo].[spx_pGRCompany_DELETE]
(@CompanyGuidId uniqueidentifier)
AS 

DELETE FROM  dbo.pGRCompany WHERE CompanyGuidId= @CompanyGuidId
DELETE FROM  dbo.pGRPOMCompany WHERE CompanyGuidId= @CompanyGuidId
 

DELETE FROM  dbo.pGRAlternates WHERE (CompanyGuidId= @CompanyGuidId)


DELETE FROM  dbo.pGRGarment WHERE (CompanyGuidId= @CompanyGuidId)


DELETE FROM  dbo.pGRSizeClassCompany WHERE (CompanyGuidId= @CompanyGuidId)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '396', GetDate())
GO