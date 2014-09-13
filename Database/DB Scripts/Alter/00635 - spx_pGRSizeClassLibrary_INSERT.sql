-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 26 October 2010                                                                               */
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


CREATE PROCEDURE spx_pGRSizeClassLibrary_INSERT
(@SizeClassGuidId  uniqueidentifier,
@SizeClass nvarchar(50),
@CUser nvarchar(25),
@CDate datetime,
@MUser nvarchar(25),
@MDate datetime  
)



AS 

INSERT INTO pGRSizeClass
    (SizeClassGuidId, SizeClass, CDate, CUser, MUser, MDate)
VALUES (@SizeClassGuidId, @SizeClass, @CDate, @CUser, @MUser, @MDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '635', GetDate())
GO
