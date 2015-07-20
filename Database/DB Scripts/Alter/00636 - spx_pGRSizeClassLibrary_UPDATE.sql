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


CREATE PROCEDURE spx_pGRSizeClassLibrary_UPDATE
(@SizeClassGuidId  uniqueidentifier,
@SizeClass nvarchar(50),
@MUser nvarchar(25),
@MDate datetime  
)



AS 

UPDATE pGRSizeClass
SET   SizeClass =@SizeClass, MUser= @MUser, MDate = @MDate 
WHERE     (SizeClassGuidId = @SizeClassGuidId)


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '636', GetDate())
GO
