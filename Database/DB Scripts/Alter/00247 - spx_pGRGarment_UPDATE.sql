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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRGarment_UPDATE') 
DROP PROCEDURE spx_pGRGarment_UPDATE
GO

CREATE PROCEDURE [dbo].[spx_pGRGarment_UPDATE]
(@GarmentGuidID uniqueidentifier,
@CompanyGuidID uniqueidentifier,
@Garment nvarchar(100),
@Muser nvarchar(200),
@MDate datetime)
AS 


UPDATE    pGRGarment
SET  CompanyGuidID = @CompanyGuidID, Garment = @Garment, MUser = @MUser,  MDate = @MDate
WHERE     GarmentGuidID = @GarmentGuidID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '247', GetDate())
GO

