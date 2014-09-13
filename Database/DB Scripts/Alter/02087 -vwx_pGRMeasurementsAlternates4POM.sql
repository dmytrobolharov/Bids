SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pGRMeasurementsAlternates4POM]'))
DROP VIEW [dbo].[vwx_pGRMeasurementsAlternates4POM]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create VIEW [dbo].[vwx_pGRMeasurementsAlternates4POM]
AS
SELECT     TOP (100) PERCENT pGRMeasurementsAlternates.AlternatesCode, pGRMeasurementsAlternates.AlternatesId, pGRMeasurementsAlternates.AlternatesDesc, 
                      pGRMeasurementsPOMAlternates.POMAlternatesId,  pGRMeasurementsPOMAlternates.POMId
FROM         pGRMeasurementsPOMAlternates INNER JOIN
                      pGRMeasurementsAlternates ON pGRMeasurementsPOMAlternates.AlternatesId = pGRMeasurementsAlternates.AlternatesId
ORDER BY pGRMeasurementsAlternates.AlternatesCode



GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02087'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02087', GetDate())
	END
GO