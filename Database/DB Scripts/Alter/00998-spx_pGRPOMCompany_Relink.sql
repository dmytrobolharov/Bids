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

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRPOMCompany_Relink') 
DROP PROCEDURE spx_pGRPOMCompany_Relink
GO


Create PROCEDURE [dbo].[spx_pGRPOMCompany_Relink]
(@PomCompanyId uniqueidentifier,
@IsLinked int,
@MUser nvarchar(100),
@MDate datetime)


AS 
UPDATE pGRPomCompany
    	SET RefCode = (select RefCode from pgrPOM WHERE  POMGuidId 
	IN (SELECT distinct  POMGuidId FROM pGRPOMAlternates WHERE 
	POMAlternatesId IN (SELECT POMAlternatesId FROM pGRPOMCompany WHERE 
	POMCompanyId=@PomCompanyId))),
 POMDesc = (select POMDesc from pgrPOM WHERE  POMGuidId 
	IN (SELECT distinct  POMGuidId FROM pGRPOMAlternates WHERE 
	POMAlternatesId IN (SELECT POMAlternatesId FROM pGRPOMCompany WHERE 
	POMCompanyId=@PomCompanyId))),
 How2MeasText = (select How2MeasText from pgrPOM WHERE  POMGuidId 
	IN (SELECT distinct  POMGuidId FROM pGRPOMAlternates WHERE 
	POMAlternatesId IN (SELECT POMAlternatesId FROM pGRPOMCompany WHERE 
	POMCompanyId=@PomCompanyId))),
 How2MeasName = (select How2MeasName from pgrPOM WHERE  POMGuidId 
	IN (SELECT distinct  POMGuidId FROM pGRPOMAlternates WHERE 
	POMAlternatesId IN (SELECT POMAlternatesId FROM pGRPOMCompany WHERE 
	POMCompanyId=@PomCompanyId))),
 SortField = (select SortField from pgrPOM WHERE  POMGuidId 
	IN (SELECT distinct  POMGuidId FROM pGRPOMAlternates WHERE 
	POMAlternatesId IN (SELECT POMAlternatesId FROM pGRPOMCompany WHERE 
	POMCompanyId=@PomCompanyId))),
 CnvtPOMDesc= (select CnvtPOMDesc from pgrPOM WHERE  POMGuidId 
	IN (SELECT distinct  POMGuidId FROM pGRPOMAlternates WHERE 
	POMAlternatesId IN (SELECT POMAlternatesId FROM pGRPOMCompany WHERE 
	POMCompanyId=@PomCompanyId))),
 ImageId = (select ImageId from pgrPOM WHERE  POMGuidId 
	IN (SELECT distinct  POMGuidId FROM pGRPOMAlternates WHERE 
	POMAlternatesId IN (SELECT POMAlternatesId FROM pGRPOMCompany WHERE 
	POMCompanyId=@PomCompanyId))),

	 IsLinked = @IsLinked, 
	 MUser = @MUser, 
	 MDate = @MDate
	
WHERE PomCompanyId=@PomCompanyId
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '00998', GetDate())
GO
