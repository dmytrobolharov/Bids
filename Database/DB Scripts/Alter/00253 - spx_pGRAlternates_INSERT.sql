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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRGradeType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pGRGradeType_INSERT]
GO

Create PROCEDURE spx_pGRAlternates_INSERT
(@AlternatesGuidID  uniqueidentifier,
@CompanyGuidID uniqueidentifier,
@AlternatesCode nvarchar (4),
@AlternatesDesc nvarchar (100),
@MUser nvarchar (200),
@MDate datetime,
@CUser nvarchar(200),
@CDate datetime)
AS INSERT INTO pGRAlternates
    (CompanyGuidID, AlternatesGuidID, AlternatesCode, AlternatesDesc, MUser,MDate,CUser,CDate)
VALUES (@CompanyGuidID, @AlternatesGuidID, @AlternatesCode, @AlternatesDesc, @MUser,@MDate,@CUser,@CDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '253', GetDate())
GO
