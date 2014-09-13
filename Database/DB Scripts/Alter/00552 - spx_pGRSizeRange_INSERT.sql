-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 9 September 2010                                                                               */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_pGRSizeRange_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_pGRSizeRange_INSERT
GO

CREATE PROCEDURE spx_pGRSizeRange_INSERT
(@SizeRangeGuidId  uniqueidentifier,
@SizeRange nvarchar(60),
@Active int,
@CUser nvarchar(200),
@CDate datetime)

AS INSERT INTO pGRSizeRange
    (SizeRangeGuidId, SizeRange,Active, CUser, CDate)
VALUES (@SizeRangeGuidId, @SizeRange, @Active, @CUser, @CDate)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '552', GetDate())
GO
