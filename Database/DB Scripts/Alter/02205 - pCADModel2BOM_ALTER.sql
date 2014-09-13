ALTER TABLE [dbo].[pCADModel2BOM] DROP COLUMN [WorkflowItemId]
GO

ALTER TABLE [dbo].[pCADModel2BOM] ALTER COLUMN PieceLength DECIMAL(10, 2)
GO

ALTER TABLE [dbo].[pCADModel2BOM] ALTER COLUMN PieceWidth DECIMAL(10, 2)
GO

ALTER TABLE [dbo].[pCADModel2BOM] ALTER COLUMN Warp DECIMAL(10, 2)
GO

ALTER TABLE [dbo].[pCADModel2BOM] ALTER COLUMN Weft DECIMAL(10, 2)
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02205'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02205', GetDate())
END	
GO

