-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 1 October 2010                                                                             */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_pGRPOM_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_pGRPOM_SELECT
GO







CREATE  PROCEDURE [dbo].[spx_pGRPOM_SELECT]
(@CompanyId nvarchar (50),
@Where NVARCHAR(2000))
AS 


DECLARE @query NVARCHAR(4000)
BEGIN

	    SET @query = N'SELECT a.POMGuidId, a.RefCode, a.POMDesc, a.How2MeasText, a.VideoSerialNumber, a.SortField, a.CnvtPOMDesc, a.ImageSerialNumber, 
                      a.CUser, a.CDate, a.Muser, a.MDate, b.AlternatesGuidId, b.POMAlternatesId, 
					  c.AlternatesCode AS Alternates, d.POMCompanyId, d.CompanyGuidId 
	FROM         pGRPOM a INNER JOIN
                      pGRPOMAlternates b ON a.POMGuidId = b.POMGuidId INNER JOIN
                      pGRAlternates c ON b.AlternatesGuidId = c.AlternatesGuidId INNER JOIN
                      pGRPOMCompany d ON b.POMAlternatesId = d.POMAlternatesId
					  WHERE      d.CompanyGuidID =''' + @CompanyId + ''' 
					  '+ @Where + ' ORDER BY SortField, RefCode, Alternates ASC;'
END




Execute(@query)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '532', GetDate())
GO

