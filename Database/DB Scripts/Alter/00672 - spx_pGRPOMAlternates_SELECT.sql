set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


IF EXISTS (select * from sysobjects where id = object_id('spx_pGRPOMAlternates_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_pGRPOMAlternates_SELECT
GO


CREATE PROCEDURE [dbo].[spx_pGRPOMAlternates_SELECT]
	(@where AS varchar(1000))
AS 
DECLARE @query nvarchar(4000)



set @query = 'SELECT pGRPOM.POMGuidId, pGRPOM.RefCode,'
set @query = @query + 'pGRAlternates.AlternatesCode as Code,pGRPOM.POMDesc,'
set @query = @query + 'pGRPOM.How2MeasText, pGRPOM.SortField AS Sort, pGRPOM.ImageId,'
set @query = @query + 'pGRPOM.Muser, pGRPOM.MDate,pGRAlternates.AlternatesGuidId,'
set @query = @query + 'pGRAlternates.AlternatesDesc'
set @query = @query + 'FROM  pGRPOM INNER JOIN pGRPOMAlternates' 
set @query = @query + 'ON pGRPOM.POMGuidId = pGRPOMAlternates.POMGuidId INNER JOIN pGRAlternates' 
set @query = @query + 'ON pGRPOMAlternates.AlternatesGuidId = pGRAlternates.AlternatesGuidId '
set @query = @query + @where  + ''

select @query 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '672', GetDate())
GO