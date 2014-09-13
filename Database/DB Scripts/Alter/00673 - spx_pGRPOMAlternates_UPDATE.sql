-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 6 November 2010                                                                               */
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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRPOMAlternates_UPDATE') 
DROP PROCEDURE spx_pGRPOMAlternates_UPDATE
GO



Create PROCEDURE spx_pGRPOMAlternates_UPDATE
(@POMAlternatesId  uniqueidentifier,
@AlternatesGuidId uniqueidentifier)

AS 

UPDATE    pGRPOMAlternates
SET  AlternatesGuidId = @AlternatesGuidId
WHERE    POMAlternatesId = @POMAlternatesId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '673', GetDate())
GO
