SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplateItemUnLink_UPDATE')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplateItemUnLink_UPDATE
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateItemUnLink_UPDATE]
(@POMTempItemID uniqueidentifier, @Linked int)
AS 

Begin
	IF @Linked = 0
		BEGIN
			UPDATE dbo.pGRMeasurementsPOMTemplateItem SET IsLinked=0 WHERE POMTempItemID = @POMTempItemID			
		end
end



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02112'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02112', GetDate())
	END
GO