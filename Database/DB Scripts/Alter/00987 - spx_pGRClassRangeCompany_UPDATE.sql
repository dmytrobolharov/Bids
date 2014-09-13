
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 11 November 2010                                                                                */
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



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRClassRangeCompany_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pGRClassRangeCompany_UPDATE]
GO


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go



CREATE PROCEDURE [dbo].[spx_pGRClassRangeCompany_UPDATE]
(@ClassRangeId uniqueidentifier,
@SizeRange nvarchar(100),
@Active int,
@IsLinked int,
@Muser nvarchar(200),
@MDate datetime)
AS 


UPDATE    pGRClassRange
SET   SizeRange = @SizeRange, Active = @Active, IsLinked= @IsLinked, MUser = @MUser,  MDate = @MDate
WHERE     ClassRangeId= @ClassRangeId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '00987', GetDate())
GO


