IF OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_Imperial]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Imperial]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09352', GetDate())
GO
