-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 6 November 2010                                                                               */
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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRPOM_UPDATE') 
DROP PROCEDURE spx_pGRPOM_UPDATE
GO



Create PROCEDURE spx_pGRPOM_UPDATE
(@POMGuidID  uniqueidentifier,
@RefCode nvarchar (12),
@POMDesc nvarchar (100),
@How2MeasText nvarchar (500),
@SortField int,
@MUser nvarchar (200),
@MDate datetime
)
AS 


UPDATE    pGRPOM
SET  RefCode = @RefCode,
POMDesc =@POMDesc, 
How2MeasText = @How2MeasText,
SortField = @SortField,
MUser = @MUser,
MDate = @MDate


WHERE    POMGuidID = @POMGuidID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '674', GetDate())
GO
