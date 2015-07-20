IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleCADModel2BOM_CADModel2BOMId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleCADModel2BOM] DROP CONSTRAINT [DF_pStyleCADModel2BOM_CADModel2BOMId]
END

GO

/****** Object:  Table [dbo].[pStyleCADModel2BOM]    Script Date: 11/22/2011 11:10:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCADModel2BOM]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleCADModel2BOM]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02204'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02204', GetDate())
END	
GO