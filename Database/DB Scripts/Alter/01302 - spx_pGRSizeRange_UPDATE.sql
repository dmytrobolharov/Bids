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

IF EXISTS(select * from information_schema.routines where specific_name = N'spx_pGRSizeRange_UPDATE')
DROP PROCEDURE spx_pGRSizeRange_UPDATE
GO


CREATE PROCEDURE [dbo].[spx_pGRSizeRange_UPDATE]
@SizeRangeGuidId UNIQUEIDENTIFIER, 
@SizeRange NVARCHAR (60), 
@Active INT, 
@Muser NVARCHAR (200), 
@MDate DATETIME
AS
       UPDATE pGRSizeRange
          SET SizeRange= @SizeRange,
                Active = @Active, 
                 MUser = @MUser,  
                 MDate = @MDate
        WHERE SizeRangeGuidId = @SizeRangeGuidId

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01302', GetDate())
GO

