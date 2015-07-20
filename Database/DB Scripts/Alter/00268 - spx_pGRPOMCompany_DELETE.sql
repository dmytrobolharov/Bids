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


IF EXISTS (select * from sysobjects where id = object_id('spx_pGRPOMCompany_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_pGRPOMCompany_DELETE
GO

CREATE PROCEDURE [dbo].[spx_pGRPOMCompany_DELETE]
(@POMAlternatesId uniqueidentifier,
 @CompanyGuidId uniqueidentifier)
AS 

DELETE FROM  dbo.pGRPOMCompany WHERE (POMAlternatesId = @POMAlternatesId AND CompanyGuidId=@CompanyGuidId)
go 


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '268', GetDate())
GO