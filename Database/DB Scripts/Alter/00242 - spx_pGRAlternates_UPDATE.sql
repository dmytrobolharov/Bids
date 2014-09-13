-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 15 July 2010                                                                                */
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
--


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MeasurementLibraryVariation_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MeasurementLibraryVariation_UPDATE]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRGradeType_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pGRGradeType_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_pGRAlternates_UPDATE]
(@AlternatesGuidID uniqueidentifier,
@CompanyGuidID uniqueidentifier,
@AlternatesCode nvarchar(4),
@AlternatesDesc nvarchar(100),
@Muser nvarchar(200),
@MDate datetime)
AS 


UPDATE    pGRAlternates
SET  AlternatesGuidID = @AlternatesGuidID, CompanyGuidID = @CompanyGuidID, AlternatesCode= @AlternatesCode, AlternatesDesc=@AlternatesDesc, MUser = @MUser,  MDate = @MDate
WHERE     (AlternatesGuidID = @AlternatesGuidID)


Go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '242', GetDate())
GO

