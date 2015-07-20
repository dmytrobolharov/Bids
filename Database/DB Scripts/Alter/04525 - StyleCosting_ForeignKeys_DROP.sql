IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pStyleCostingBOM_pStyleCostingScenarioItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[pStyleCostingBOM]'))
ALTER TABLE [dbo].[pStyleCostingBOM] DROP CONSTRAINT [FK_pStyleCostingBOM_pStyleCostingScenarioItems]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pStyleCostingBOL_pStyleCostingScenarioItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[pStyleCostingBOL]'))
ALTER TABLE [dbo].[pStyleCostingBOL] DROP CONSTRAINT [FK_pStyleCostingBOL_pStyleCostingScenarioItems]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '5.0.0000', '04525', GetDate())
GO
