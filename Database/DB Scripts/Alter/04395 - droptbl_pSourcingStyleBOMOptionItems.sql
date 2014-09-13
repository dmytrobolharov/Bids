
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_StyleOptionItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_StyleOptionItemID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MainMaterial]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MainMaterial]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_Artwork]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_Artwork]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_License]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_License]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_Colorway]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_Colorway]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSort]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialTrack]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialTrack]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialLinked]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialLinked]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialDimension]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialDimension]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeA19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeA19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB12]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialSizeB19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialSizeB19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialLining]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialLining]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MaterialBOM]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MaterialBOM]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_MultiCloth]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_MultiCloth]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMOptionItems_AUTOCOLOR]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMOptionItems] DROP CONSTRAINT [DF_pSourcingStyleBOMOptionItems_AUTOCOLOR]
END

GO


/****** Object:  Table [dbo].[pSourcingStyleBOMOptionItems]    Script Date: 11/20/2012 15:52:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingStyleBOMOptionItems]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingStyleBOMOptionItems]
GO







INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04395', GetDate())
GO
