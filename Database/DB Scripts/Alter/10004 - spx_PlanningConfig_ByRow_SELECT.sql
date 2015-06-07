IF OBJECT_ID(N'[dbo].[spx_PlanningConfig_ByRow_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_PlanningConfig_ByRow_SELECT]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10004', GetUTCDate())
GO

