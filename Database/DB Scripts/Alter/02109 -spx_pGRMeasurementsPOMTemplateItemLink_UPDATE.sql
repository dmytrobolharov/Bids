SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplateItemLink_UPDATE')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplateItemLink_UPDATE
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemLink_UPDATE]
(@POMTempItemID uniqueidentifier, @Linked int)
AS 

Begin
	IF @Linked = 1
		BEGIN
			--UPDATE dbo.pGRMeasurementsPOMTemplateItem SET IsLinked=1 WHERE POMTempItemID = @POMTempItemID			
			update pGRMeasurementsPOMTemplateItem set active=1, IsLinked=1, POMCode=a.POMCode, POMDesc=a.POMDesc, AlternatesCode=a.AlternatesCode, AlternatesDesc=a.AlternatesDesc,
			AlternatesSort=a.AlternateSort,AlternatesId=a.AlternatesId, POMID=a.Pomid,
			ImageId=a.ImageId, How2MeasName=a.How2MeasName, How2MeasText=a.How2MeasText
			from pGRMeasurementsPOMTemplateItem p INNER JOIN pGRMeasurementsPOMAlternates a ON p.POMAlternatesID = a.POMAlternatesId
			where POMTempItemID=@POMTempItemID 
		end
end

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02109'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02109', GetDate())
	END
GO