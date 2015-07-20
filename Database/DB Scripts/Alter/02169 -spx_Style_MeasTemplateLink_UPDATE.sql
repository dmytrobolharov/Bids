IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_MeasTemplateLink_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_MeasTemplateLink_UPDATE]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_Style_MeasTemplateLink_UPDATE]
(@Amlmeaspomid uniqueidentifier,
@AmlmeasHdrid uniqueidentifier,
@Linked int)
AS 

declare @POMTempItemID uniqueidentifier

Begin
	select @POMTempItemID=GRPOMCompanyId from pAMLMeasPOM where Amlmeaspomid=@Amlmeaspomid and AmlmeasHdrid=@AmlmeasHdrid 
	
	IF @Linked = 1
		BEGIN			
			update pamlmeaspom set IsLinked=1, refCode=a.POMCode, 
			[description]=a.POMDesc + case a.Alternatescode when '' then '' else '--' + AlternatesDesc end, 
			POMGuidId=a.Pomid, POMAlternatesId=a.POMAlternatesId, GRPOMCompanyId = a.POMTempItemID,
			ImageId=a.ImageId, How2MeasName=a.How2MeasName, How2MeasText=a.How2MeasText,
			tolplus=a.TolPlus, tolminus=a.tolminus, SortId=a.POMSort, Flag4QA=a.IsOnQA,
			critical=a.Critical
			from pamlmeaspom p INNER JOIN pGRMeasurementsPOMTemplateItem a ON p.POMAlternatesID = a.POMAlternatesId
			and p.GRPOMCompanyId = a.POMTempItemID and a.POMTempItemID=@POMTempItemID
			where Amlmeaspomid=@Amlmeaspomid and AmlmeasHdrid=@AmlmeasHdrid 
		end
end
Go
 
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02169'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02169', GetDate())
END	
GO
