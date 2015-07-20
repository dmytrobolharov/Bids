

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


CREATE PROCEDURE [dbo].[spx_pGRPOMGradesRules_SELECT]
(@Where nvarchar(500),
@cols nvarchar(2000))
AS 

DECLARE @query NVARCHAR(4000)

begin
        set @query = NULL
		SET @query = N'SELECT pGRGradeRule.GradeRuleGuidID, pGRPOMCompany.POMCompanyId, pGRPOM.RefCode, pGRPOM.POMDesc, pGRPOM.SortField, '
        SET @query = @query  + ' pGRAlternates.AlternatesCode, '  + @cols + ' '
        set @query = @query +  ' FROM pGRPOMAlternates INNER JOIN '
        set @query = @query +  ' pGRPOMCompany ON pGRPOMAlternates.POMAlternatesId = pGRPOMCompany.POMAlternatesId '
        set @query = @query +  ' INNER JOIN pGRGradeRule ON pGRPOMCompany.POMCompanyId = pGRGradeRule.POMCompanyId '
        set @query = @query +  ' INNER JOIN pGRPOM ON pGRPOMAlternates.POMGuidId = pGRPOM.POMGuidId '
        set @query = @query +  ' INNER JOIN pGRAlternates ON '
        set @query = @query +  ' pGRPOMAlternates.AlternatesGuidId = pGRAlternates.AlternatesGuidId '
        set @query = @query +  @Where
        set @query = @query +  ' ORDER BY pGRPOM.SortField,pGRPOM.RefCode,pGRAlternates.AlternatesCode'

end
exec (@query)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '572', GetDate())
GO