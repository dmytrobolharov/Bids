-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 2 November 2010                                                                               */
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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRPOMAlternates_INSERT') 
DROP PROCEDURE spx_pGRPOMAlternates_INSERT
GO



Create PROCEDURE spx_pGRPOMAlternates_INSERT
(@POMAlternatesId  uniqueidentifier,
@POMGuidId uniqueidentifier,
@AlternatesGuidId uniqueidentifier)

AS INSERT INTO pGRPOMAlternates
    (POMAlternatesId, POMGuidId, AlternatesGuidId)
VALUES (@POMAlternatesId, @POMGuidId, @AlternatesGuidId)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '670', GetDate())
GO
