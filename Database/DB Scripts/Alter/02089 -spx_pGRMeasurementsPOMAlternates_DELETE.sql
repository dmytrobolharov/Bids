SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMAlternates_DELETE')
   DROP PROCEDURE spx_pGRMeasurementsPOMAlternates_DELETE
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMAlternates_DELETE]
(@POMId uniqueidentifier
)
AS 

DELETE FROM pGRMeasurementsPOMAlternates WHERE (POMId= @POMId)

DELETE FROM pGRMeasurementsPOM WHERE POMId = @POMId

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02089'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02089', GetDate())
	END
GO