-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 September2010                                                                               */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_pGRSizeRangeDetail_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_pGRSizeRangeDetail_INSERT
GO






CREATE PROCEDURE spx_pGRSizeRangeDetail_INSERT
(@SizeRangeDetailId   uniqueidentifier,
@SizeRangeId   uniqueidentifier,
@SizeCount  int,
@SizeName nvarchar (50),
@SizeDesc nvarchar (50),
@Sample int)



AS 

INSERT INTO pGRSizeRangeDetail
    (SizeRangeDetailId, SizeRangeId, SizeCount, SizeName, SizeDesc, Sample)
VALUES (@SizeRangeDetailId, @SizeRangeId, @SizeCount, @SizeName,@SizeDesc, @Sample)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '448', GetDate())
GO
