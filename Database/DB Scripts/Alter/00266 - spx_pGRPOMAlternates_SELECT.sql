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
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF EXISTS (select * from sysobjects where id = object_id('spx_pGRPOMGrades_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_pGRPOMGrades_SELECT
GO
IF EXISTS (select * from sysobjects where id = object_id('spx_pGRPOMAlternates_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_pGRPOMAlternates_SELECT
GO


CREATE PROCEDURE [dbo].[spx_pGRPOMAlternates_SELECT]

AS 

BEGIN
	SELECT     a.POMGuidId, a.RefCode, a.POMDesc, a.How2MeasText, a.VideoSerialNumber, a.SortField, a.CnvtPOMDesc, a.ImageSerialNumber, 
                      a.CUser, a.CDate, a.Muser, a.MDate, b.AlternatesGuidId, b.POMAlternatesId, c.AlternatesCode AS Alternates, d.POMCompanyId
	FROM         pGRPOM AS a INNER JOIN
                      pGRPOMAlternates AS b ON a.POMGuidId = b.POMGuidId INNER JOIN
                      pGRAlternates AS c ON b.AlternatesGuidId = c.AlternatesGuidId INNER JOIN
                      pGRPOMCompany AS d ON b.POMAlternatesId = d.POMAlternatesId
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '266', GetDate())
GO
