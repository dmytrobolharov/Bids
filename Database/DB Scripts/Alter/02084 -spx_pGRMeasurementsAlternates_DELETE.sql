SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsAlternates_DELETE')
   DROP PROCEDURE spx_pGRMeasurementsAlternates_DELETE
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_pGRMeasurementsAlternates_DELETE]
(@AlternatesID uniqueidentifier)
AS 

DELETE FROM dbo.pGRMeasurementsAlternates WHERE AlternatesID= @AlternatesID
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02084'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02084', GetDate())
	END
GO