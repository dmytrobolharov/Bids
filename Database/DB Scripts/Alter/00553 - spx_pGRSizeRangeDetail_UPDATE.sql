-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 September 2010                                                                             */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_pGRSizeRangeDetail_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_pGRSizeRangeDetail_UPDATE
GO


CREATE  PROCEDURE [dbo].[spx_pGRSizeRangeDetail_UPDATE]
(@SizeRangeDetailId uniqueidentifier,
@SizeRangeId uniqueidentifier,
@SizeCount int,
 @SizeName nvarchar(60),
@SizeDesc nvarchar(60),
@Sample int)
AS 


UPDATE    pGRSizeRangeDetail
SET   SizeRangeId =@SizeRangeId, SizeCount= @SizeCount, SizeName = @SizeName, SizeDesc = @SizeDesc,  Sample = @Sample
WHERE     SizeRangeDetailId = @SizeRangeDetailId
GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '553', GetDate())
GO

