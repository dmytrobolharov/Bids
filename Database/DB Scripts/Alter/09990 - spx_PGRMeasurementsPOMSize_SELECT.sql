IF OBJECT_ID(N'[dbo].[spx_PGRMeasurementsPOMSize_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_PGRMeasurementsPOMSize_SELECT]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09990', GetUTCDate())
GO
