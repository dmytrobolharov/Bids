
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



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pGRPOMGradesRules_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pGRPOMGradesRules_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_pGRPOMGradesRules_SELECT]
(@Where nvarchar(500),
@cols nvarchar(2000))
AS 

DECLARE @query NVARCHAR(4000)

begin
        set @query = NULL
		SET @query = N'SELECT pGRGradeRule.GradeRuleGuidID, pGRPOMCompany.POMCompanyId, RefCode, POMDesc, SortField, '
        SET @query = @query  + ' pGRAlternates.AlternatesCode, '  + @cols + ' '
        set @query = @query +  ' FROM pGRPOMAlternates INNER JOIN '
        set @query = @query +  ' pGRPOMCompany ON pGRPOMAlternates.POMAlternatesId = pGRPOMCompany.POMAlternatesId '
        set @query = @query +  ' INNER JOIN pGRGradeRule ON pGRPOMCompany.POMCompanyId = pGRGradeRule.POMCompanyId '
        set @query = @query +  ' INNER JOIN pGRAlternates ON '
        set @query = @query +  ' pGRPOMAlternates.AlternatesGuidId = pGRAlternates.AlternatesGuidId '
        set @query = @query +  @Where
        set @query = @query +  ' ORDER BY SortField,RefCode,AlternatesCode'

end
exec (@query)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01301', GetDate())
GO