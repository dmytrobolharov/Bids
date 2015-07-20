-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 1 September2010                                                                               */
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

IF EXISTS(select * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRGradeRule_INSERT')
DROP PROCEDURE spx_pGRGradeRule_INSERT
GO


CREATE PROCEDURE spx_pGRGradeRule_INSERT
(@GradeRuleGuidID   uniqueidentifier,
@ClassRangeId uniqueidentifier,
@POMCompanyId uniqueidentifier,
@CUser nvarchar (200), 
@CDate datetime)



AS INSERT INTO pGRGradeRule
    (GradeRuleGuidID, ClassRangeId, POMCompanyId, CUser, CDate)
VALUES (@GradeRuleGuidID, @ClassRangeId, @POMCompanyId, @CUser,@CDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '568', GetDate())
GO
