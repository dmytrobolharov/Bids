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

IF EXISTS (select * from sysobjects where id = object_id('spx_pGRSizeRangeDetailLinked_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_pGRSizeRangeDetailLinked_INSERT
GO


CREATE PROCEDURE spx_pGRSizeRangeDetailLinked_INSERT
(@SizeRangeId   uniqueidentifier,
@ClassRangeId nvarchar (50))

AS 

INSERT INTO pGRSizeRangeDetail
    (SizeRangeDetailId, SizeRangeId, SizeCount, SizeName, SizeDesc, Sample, ClassRangeId)
 (SELECT NEWID(), @SizeRangeId, SizeCount, SizeName,SizeDesc, Sample, @ClassRangeId FROM pGRSizeRangeDetail WHERE 
  SizeRangeId = @SizeRangeId and ClassRangeId = '00000000-0000-0000-0000-000000000000')
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01223', GetDate())
GO
