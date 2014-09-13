SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplate_DELETE')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplate_DELETE
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplate_DELETE]
(@POMTempID uniqueidentifier)
AS 

DELETE FROM dbo.pGRMeasurementsPOMTemplate
WHERE POMTempID = @POMTempID

DELETE FROM dbo.pGRMeasurementsPOMTemplateItem
WHERE POMTempID = @POMTempID

DELETE FROM dbo.pGRMeasurementsPOMTemplateGroup
WHERE POMTempID = @POMTempID

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02099'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02099', GetDate())
	END
GO