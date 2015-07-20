SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMAlt_DELETE')
   DROP PROCEDURE spx_pGRMeasurementsPOMAlt_DELETE
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMAlt_DELETE]
(@AlternatesId uniqueidentifier,
@POMId uniqueidentifier)
AS 



DELETE FROM dbo.pGRMeasurementsPOMAlternates WHERE (AlternatesId= @AlternatesId and POMId=@POMId)


 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02090'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02090', GetDate())
	END
GO