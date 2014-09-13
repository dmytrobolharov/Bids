-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 July 2010                                                                                */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_pGRPOMCompany_Delete') and sysstat & 0xf = 4)
    drop procedure spx_pGRPOMCompany_Delete
GO

CREATE PROCEDURE [dbo].[spx_pGRPOMCompany_Delete]
(@POMCompanyID uniqueidentifier)
AS 

DELETE FROM dbo.pGRPOMCompany WHERE POMCompanyID= @POMCompanyID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '01000', GetDate())
GO

