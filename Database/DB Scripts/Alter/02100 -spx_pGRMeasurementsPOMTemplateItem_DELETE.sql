SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplateItem_DELETE')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplateItem_DELETE
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItem_DELETE]
(@POMTempItemID uniqueidentifier)
AS 

Begin
DELETE FROM dbo.pGRMeasurementsPOMTemplateItem  WHERE POMTempItemID = @POMTempItemID
end 

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02100'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02100', GetDate())
	END
GO