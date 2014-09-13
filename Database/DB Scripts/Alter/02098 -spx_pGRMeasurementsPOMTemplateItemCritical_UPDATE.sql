SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplateItemCritical_UPDATE')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplateItemCritical_UPDATE
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemCritical_UPDATE]
(@POMTempItemID uniqueidentifier, @Critical int)
AS 
	
BEGIN
	UPDATE dbo.pGRMeasurementsPOMTemplateItem SET Critical = @Critical
	WHERE POMTempItemID = @POMTempItemID			
end

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02098'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02098', GetDate())
	END
GO