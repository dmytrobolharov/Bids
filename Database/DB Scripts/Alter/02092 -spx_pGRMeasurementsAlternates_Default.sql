SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsAlternates_Default')
   DROP PROCEDURE spx_pGRMeasurementsAlternates_Default
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_pGRMeasurementsAlternates_Default]
as
begin

IF NOT EXISTS (SELECT * FROM pGRMeasurementsAlternates WHERE AlternatesId='00000000-0000-0000-0000-000000000000' and (AlternatesCode='' OR  AlternatesCode IS NULL) AND AlternatesDesc='NONE')
	BEGIN
		INSERT INTO pGRMeasurementsAlternates(AlternatesId,AlternatesCode,AlternatesDesc, Sort, Active)
		VALUES('00000000-0000-0000-0000-000000000000', '', 'NONE',0,1)
	END
END

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02092'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02092', GetDate())
	END
GO