IF OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_Metric]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Metric]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09353', GetDate())
GO
