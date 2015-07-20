-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 11 August 2010                                                                             */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_pGRSizerange_SELECT') and sysstat & 0xf = 4)
    drop procedure  spx_pGRSizerange_SELECT
GO


CREATE PROCEDURE [dbo].[ spx_pGRSizerange_SELECT]
(
@SizeClassGuidId uniqueidentifier
)
AS 

BEGIN
	
SELECT DISTINCT SizeRangeGuidId,  a.SizeRange,  
(SELECT SizeName from  pgrsizerangedetail b  
WHERE Sizecount = 1 and sizerangeid = '0C39398F-E54B-4A7E-A0F2-271E6D5BF582' ) as '1', 
(SELECT SizeName from  pgrsizerangedetail b  
WHERE Sizecount = 2 and sizerangeid = '0C39398F-E54B-4A7E-A0F2-271E6D5BF582' ) AS '2', 
(SELECT SizeName from  pgrsizerangedetail b 
 WHERE Sizecount = 3 and sizerangeid = '0C39398F-E54B-4A7E-A0F2-271E6D5BF582' ) AS '3', 
(SELECT SizeName from  pgrsizerangedetail b  
WHERE Sizecount = 4 and sizerangeid = '0C39398F-E54B-4A7E-A0F2-271E6D5BF582' ) AS '4', 
(SELECT SizeName from  pgrsizerangedetail b  
WHERE Sizecount = 5 and sizerangeid = '0C39398F-E54B-4A7E-A0F2-271E6D5BF582' ) AS '5', 
(SELECT SizeName from  pgrsizerangedetail b  
WHERE Sizecount = 6 and sizerangeid = '0C39398F-E54B-4A7E-A0F2-271E6D5BF582' ) AS '6', 
(SELECT SizeName from  pgrsizerangedetail b   
WHERE Sizecount = 7 and sizerangeid = '0C39398F-E54B-4A7E-A0F2-271E6D5BF582' ) AS '7' 
FROM pgrsizerange a inner join pgrsizerangedetail b 
ON a.sizerangeguidid = b.sizerangeid 
WHERE b.SizeRangeId IN (SELECT     SizeRangeGuidId
FROM         pGRClassRange
WHERE     SizeClassGuidId = @SizeClassGuidId)
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '395', GetDate())
GO
