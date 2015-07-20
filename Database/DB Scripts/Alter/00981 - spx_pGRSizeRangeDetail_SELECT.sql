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


IF EXISTS (select * from sysobjects where id = object_id('spx_pGRSizeRangeDetail_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_pGRSizeRangeDetail_SELECT
GO


CREATE  PROCEDURE [dbo].[spx_pGRSizeRangeDetail_SELECT]
(@cols NVARCHAR(2000),
@Where NVARCHAR(2000))
AS 



--select @cols as Sizecols

DECLARE @query NVARCHAR(4000)
DECLARE @localguid nvarchar(36)

SET @localguid = '00000000-0000-0000-0000-000000000000'

if len(@Where) > 0
	begin
		SET @query = N'SELECT sizerangeid, sizerange, '  + @cols + ', MUser, MDate
                               FROM 
                              (SELECT  pgrsizerangedetail.sizerangeid, sizerange, sizecount, SizeName, MUser, MDate      
                                 FROM   pgrsizerangedetail, pgrsizerange  WHERE pgrsizerangedetail.sizerangeid = pgrsizerange.sizerangeGuidid
                                 AND pGRSizeRangeDetail.ClassRangeId= ' + @localguid + '
            AND ' + @Where + ' ) p
            PIVOT
            (
            MAX([SizeName])
            FOR sizecount IN
            ('+ @cols +' )
            ) AS pvt
            Order by sizerange;'

		--Order by sizerange;'
	end
else
	begin
		SET @query = N'SELECT sizerangeid, sizerange, '  + @cols + ', MUser, MDate
		FROM 
		(SELECT  pgrsizerangedetail.sizerangeid, sizerange, sizecount, SizeName, MUser, MDate      
		FROM   pgrsizerangedetail, pgrsizerange  where pgrsizerangedetail.sizerangeid = pgrsizerange.sizerangeGuidid
		) p
		PIVOT
		(
		MAX([SizeName])
		FOR sizecount IN
		('+ @cols +' )
		) AS pvt
		Order by sizerange;'
	end


Execute(@query)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '981', GetDate())
GO
