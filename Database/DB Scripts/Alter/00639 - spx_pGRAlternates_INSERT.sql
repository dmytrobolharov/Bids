-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 1 November 2010                                                                               */
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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRAlternates_INSERT') 
DROP PROCEDURE spx_pGRAlternates_INSERT
GO



Create PROCEDURE spx_pGRAlternates_INSERT
(@AlternatesGuidId  uniqueidentifier,
@AlternatesCode nvarchar (4),
@AlternatesDesc nvarchar (100),
@CUser nvarchar(200),
@CDate datetime)
AS INSERT INTO pGRAlternates
    (AlternatesGuidId, AlternatesCode, AlternatesDesc, MUser,MDate,CUser,CDate)
VALUES (@AlternatesGuidId, @AlternatesCode, @AlternatesDesc, @CUser,@CDate,@CUser,@CDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '639', GetDate())
GO
