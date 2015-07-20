-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 22 July 2010                                                                               */
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


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' and COLUMN_NAME = N'IsLinked')
       BEGIN 
             ALTER TABLE pGRClassRange ADD IsLinked Integer NULL
       END
GO


IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRClassRange_Link') 
DROP PROCEDURE spx_pGRClassRange_Link
GO


Create PROCEDURE spx_pGRClassRange_Link
(@ClassRangeId uniqueidentifier,
@SizeRangeGuidId uniqueidentifier,
@IsLinked int,
@MUser nvarchar(100),
@MDate datetime)


AS 



UPDATE pGRClassRange
set SizeRange=s.SizeRange, Active=s.Active , IsLinked=1,MUser = @MUser,  MDate = @MDate 
from pGRClassRange t  inner join pgrSizeRange s on 
t.SizeRangeGuidId=s.SizeRangeGuidId WHERE t.ClassRangeId=@ClassRangeId AND s.SizeRangeGuidId=@SizeRangeGuidId


delete from pGRSizeRangeDetail where ClassRangeId=@ClassRangeId 

insert pGRSizeRangeDetail (SizeRangeDetailId,sizerangeid, sizecount,sizename, sizedesc, sample, ClassRangeId) 
(select NEWID(), sizerangeid, sizecount,sizename, sizedesc, sample, @ClassRangeId from pGRSizeRangeDetail 
where SizeRangeId= @SizeRangeGuidId AND classrangeid='00000000-0000-0000-0000-000000000000')



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '00984', GetDate())
GO
