--Drop foreign keys

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pStyleCostingScenarioItems_pStyleCosting]') AND parent_object_id = OBJECT_ID(N'[dbo].[pStyleCostingScenarioItems]'))
ALTER TABLE [dbo].[pStyleCostingScenarioItems] DROP CONSTRAINT [FK_pStyleCostingScenarioItems_pStyleCosting]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pstyleCostingBOM_pStyleCostingScenarioItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[pstyleCostingBOM]'))
ALTER TABLE [dbo].[pstyleCostingBOM] DROP CONSTRAINT [FK_pstyleCostingBOM_pStyleCostingScenarioItems]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pStyleCostingBOL_pStyleCostingScenarioItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[pStyleCostingBOL]'))
ALTER TABLE [dbo].[pStyleCostingBOL] DROP CONSTRAINT [FK_pStyleCostingBOL_pStyleCostingScenarioItems]
GO


--Create tables:
--pStyleCostingScenarioItems---------------


ALTER TABLE [dbo].[pStyleCostingScenarioItems]  WITH CHECK ADD  CONSTRAINT [FK_pStyleCostingScenarioItems_pStyleCosting] FOREIGN KEY([StyleCostingID])
REFERENCES [dbo].[pStyleCosting] ([StyleCostingID])
GO

ALTER TABLE [dbo].[pStyleCostingScenarioItems] CHECK CONSTRAINT [FK_pStyleCostingScenarioItems_pStyleCosting]
GO


--pstyleCostingBOM-----------------------


ALTER TABLE [dbo].[pstyleCostingBOM]  WITH CHECK ADD  CONSTRAINT [FK_pstyleCostingBOM_pStyleCostingScenarioItems] FOREIGN KEY([StytleCostingScenarioItemsID])
REFERENCES [dbo].[pStyleCostingScenarioItems] ([StytleCostingScenarioItemsID])
GO

ALTER TABLE [dbo].[pstyleCostingBOM] CHECK CONSTRAINT [FK_pstyleCostingBOM_pStyleCostingScenarioItems]
GO


--pStyleCostingBOL-----------------------------------


ALTER TABLE [dbo].[pStyleCostingBOL]  WITH CHECK ADD  CONSTRAINT [FK_pStyleCostingBOL_pStyleCostingScenarioItems] FOREIGN KEY([StytleCostingScenarioItemsID])
REFERENCES [dbo].[pStyleCostingScenarioItems] ([StytleCostingScenarioItemsID])
GO

ALTER TABLE [dbo].[pStyleCostingBOL] CHECK CONSTRAINT [FK_pStyleCostingBOL_pStyleCostingScenarioItems]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03882', GetDate())
GO
