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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRPOM_UpdateLinked') 
DROP PROCEDURE spx_pGRPOM_UpdateLinked
GO


Create PROCEDURE [dbo].[spx_pGRPOM_UpdateLinked]
(@PomGuidId uniqueidentifier,
@MUser nvarchar(100),
@MDate datetime)


AS 
UPDATE pGRPomCompany
  SET	RefCode = (select RefCode from pGRPom	where POMGuidid=@PomGuidId),
		POMDesc = (select POMDesc from pGRPom	where POMGuidid=@PomGuidId),
		How2MeasText = (select How2MeasText from pGRPom where POMGuidid=@PomGuidId),
		How2MeasName = (select How2MeasName from pGRPom where POMGuidid=@PomGuidId),
		SortField = (select SortField from pGRPom	where POMGuidid=@PomGuidId),
		CnvtPOMDesc= (select CnvtPOMDesc from pGRPom	where POMGuidid=@PomGuidId),
		ImageId = (select ImageId from pGRPom	where POMGuidid=@PomGuidId),
		MUser = @MUser, 
		MDate = @MDate
	
WHERE POMALternatesId IN (select POMALternatesId from pGRPOMAlternates 
	where POMGuidid=@PomGuidId) AND IsLinked =1
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01073', GetDate())
GO
