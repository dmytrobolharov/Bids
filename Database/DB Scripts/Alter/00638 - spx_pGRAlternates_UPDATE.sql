-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 1 November 2010                                                                                */
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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRAlternates_UPDATE') 
DROP PROCEDURE spx_pGRAlternates_UPDATE
GO

CREATE PROCEDURE [dbo].[spx_pGRAlternates_UPDATE]
(@AlternatesGuidId uniqueidentifier,
@AlternatesCode nvarchar(4),
@AlternatesDesc nvarchar(100),
@MUser nvarchar(200),
@MDate datetime)
AS 


UPDATE    pGRAlternates
SET  AlternatesCode = @AlternatesCode, AlternatesDesc=@AlternatesDesc,
 MUser = @MUser,  MDate = @MDate
WHERE     AlternatesGuidId = @AlternatesGuidId
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '638', GetDate())
GO

