-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 July 2010                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */                                                                     */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS                                                                                    
--
--
--set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRSizeRange_DELETE') 
DROP PROCEDURE spx_pGRSizeRange_DELETE
GO

CREATE PROCEDURE [dbo].[spx_pGRSizeRange_DELETE]
(@SizeRangeGuidId uniqueidentifier)
AS 

DELETE FROM dbo.pGRSizeRange WHERE SizeRangeGuidId=@SizeRangeGuidId

DELETE FROM dbo.pGRSizeRangeDetail WHERE SizeRangeId=@SizeRangeGuidId
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '252', GetDate())
GO

