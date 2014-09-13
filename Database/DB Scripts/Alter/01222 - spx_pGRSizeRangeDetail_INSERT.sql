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
(@SizeRangeId   uniqueidentifier,
@SizeCount  int,
@ClassRangeId nvarchar (50))



AS 
DECLARE @SizeRangeDetailId   uniqueidentifier
DECLARE @SizeName varchar(50)
DECLARE @SizeDesc varchar(50)
DECLARE @Sample int

SET @SizeName=''
SET @SizeDesc =''
SET @Sample =0
INSERT INTO pGRSizeRangeDetail
    (SizeRangeDetailId, SizeRangeId, SizeCount, SizeName, SizeDesc, Sample, ClassRangeId)
VALUES (NEWID(), @SizeRangeId, @SizeCount, @SizeName,@SizeDesc, @Sample, @ClassRangeId)
GO

go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01222', GetDate())
GO
