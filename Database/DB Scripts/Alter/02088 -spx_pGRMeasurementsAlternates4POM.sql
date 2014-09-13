SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsAlternates4POM')
   DROP PROCEDURE spx_pGRMeasurementsAlternates4POM
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_pGRMeasurementsAlternates4POM]

AS 
SELECT * FROM vwx_pGRMeasurementsAlternates4POM

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02088'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02088', GetDate())
	END
GO