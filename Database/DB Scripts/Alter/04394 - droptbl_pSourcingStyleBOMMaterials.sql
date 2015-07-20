

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_StyleMaterialID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_StyleMaterialID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MainMaterial]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MainMaterial]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_Artwork]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_Artwork]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_License]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_License]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_Colorway]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_Colorway]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSort]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialTrack]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialTrack]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialLinked]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialLinked]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialDimension]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialDimension]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeA19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeA19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB0]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB6]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB7]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB7]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB8]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB10]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB10]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB12]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB12]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB13]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB13]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB14]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB15]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB15]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB16]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB16]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialSizeB19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialSizeB19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialLining]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialLining]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MaterialBOM]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MaterialBOM]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_MultiCloth]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_MultiCloth]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingStyleBOMMaterials_AUTOCOLOR]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingStyleBOMMaterials] DROP CONSTRAINT [DF_pSourcingStyleBOMMaterials_AUTOCOLOR]
END

GO



/****** Object:  Table [dbo].[pSourcingStyleBOMMaterials]    Script Date: 11/20/2012 15:49:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingStyleBOMMaterials]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingStyleBOMMaterials]
GO





INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04394', GetDate())
GO
