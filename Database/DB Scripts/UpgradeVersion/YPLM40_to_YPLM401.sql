--
-- First Upgrade Tables
--

/*
Run this script on:

        KJOHANNSEN3\KJ2008R2.GA40_to_401    -  This database will be modified

to synchronize it with:

        KJOHANNSEN3\KJ2008R2.GA401

You are recommended to back up your database before running this script

Script created by SQL Compare version 8.50.10 from Red Gate Software Ltd at 6/20/2011 1:34:30 PM

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Altering [dbo].[sSystemButtons]'
GO
ALTER TABLE [dbo].[sSystemButtons] ADD
[el_GR] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[pComponentType]'
GO
ALTER TABLE [dbo].[pComponentType] ADD
[ComponentLinePlanSearchSchema] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CComponentLinePlanSchema] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ComponentLinePlanSchema] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sSystemServerStorageSetting]'
GO
ALTER TABLE [dbo].[sSystemServerStorageSetting] ADD
[XmlSchemaPath] [uniqueidentifier] NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bBatchQueuMaterialSizeReplaceTmp]'
GO
CREATE TABLE [dbo].[bBatchQueuMaterialSizeReplaceTmp]
(
[BatchQMaterialSizeReplaceTmpID] [uniqueidentifier] NULL CONSTRAINT [DF_bBatchQueuMaterialSizeReplaceTmp_BatchQMaterialSizeReplaceTmpID] DEFAULT (newsequentialid()),
[BachQTransactionID] [uniqueidentifier] NULL,
[MaterialSizeFindID] [uniqueidentifier] NULL,
[MaterialSizeReplaceID] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bBatchQueuMaterialReplaceTransactionTmp]'
GO
CREATE TABLE [dbo].[bBatchQueuMaterialReplaceTransactionTmp]
(
[BachQTransactionID] [uniqueidentifier] NULL CONSTRAINT [DF_bBatchQueuMaterialReplaceTransactionTmp_BachQTransactionID] DEFAULT (newsequentialid()),
[BatchQueueMaterialReplaceID] [uniqueidentifier] NULL,
[CDate] [datetime] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TeamID] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bBatchQueuMaterialColorReplaceTmp]'
GO
CREATE TABLE [dbo].[bBatchQueuMaterialColorReplaceTmp]
(
[BatchQMaterialColorReplaceTmpID] [uniqueidentifier] NULL CONSTRAINT [DF_bBatchQueuMaterialColorReplaceTmp_BatchQMaterialColorReplaceTmpID] DEFAULT (newsequentialid()),
[BachQTransactionID] [uniqueidentifier] NULL,
[MaterialColorFindID] [uniqueidentifier] NULL,
[MaterialColorReplaceID] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sUserStrings]'
GO
ALTER TABLE [dbo].[sUserStrings] ADD
[el_GR] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[sSystemStrings]'
GO
ALTER TABLE [dbo].[sSystemStrings] ADD
[el_GR] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO

--
-- End of Table Upgrades
--

--
-- Now for Views
--

/*
Run this script on:

        KJOHANNSEN3\KJ2008R2.GA40_to_401    -  This database will be modified

to synchronize it with:

        KJOHANNSEN3\KJ2008R2.GA401

You are recommended to back up your database before running this script

Script created by SQL Compare version 8.50.10 from Red Gate Software Ltd at 6/20/2011 1:37:48 PM

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Dropping extended properties'
GO
EXEC sp_dropextendedproperty N'MS_DiagramPane1', 'SCHEMA', N'dbo', 'VIEW', N'vwx_StyleMaterialBOM_SELECT', NULL, NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_dropextendedproperty N'MS_DiagramPane2', 'SCHEMA', N'dbo', 'VIEW', N'vwx_StyleMaterialBOM_SELECT', NULL, NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
EXEC sp_dropextendedproperty N'MS_DiagramPaneCount', 'SCHEMA', N'dbo', 'VIEW', N'vwx_StyleMaterialBOM_SELECT', NULL, NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[vwx_StyleHeader_SEL]'
GO


ALTER VIEW [dbo].[vwx_StyleHeader_SEL]
AS

SELECT     dbo.pStyleHeader.StyleID, dbo.pStyleHeader.StyleMasterID, dbo.pStyleHeader.StyleWorkflowID, dbo.pStyleHeader.StyleType, dbo.pStyleHeader.WorkflowType, 
                      dbo.pStyleHeader.RefNo, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.TempID, dbo.pStyleHeader.TempNo, dbo.pStyleHeader.CustomerNo, 
                      dbo.pStyleHeader.DevelopmentID, dbo.pStyleHeader.DevelopmentNo, dbo.pStyleHeader.ConceptID, dbo.pStyleHeader.ConceptNo, dbo.pStyleHeader.SpecNo, 
                      dbo.pStyleHeader.Description, dbo.pStyleHeader.StyleCategory, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.StyleSet, 
                      dbo.pStyleHeader.TechPackId, dbo.pStyleHeader.TechPackDate, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, dbo.pStyleHeader.Customer, 
                      dbo.pStyleHeader.Buyer, dbo.pStyleHeader.Designer, dbo.pStyleHeader.SampleMaker, dbo.pStyleHeader.PatternMaker, dbo.pStyleHeader.ProductionManager, 
                      dbo.pStyleHeader.TechnicalDesigner, dbo.pStyleHeader.StyleStatus, dbo.pStyleHeader.StyleLocation, dbo.pStyleHeader.WashType, dbo.pStyleHeader.Pitch, 
                      dbo.pStyleHeader.MaterialID, dbo.pStyleHeader.MaterialImageID, dbo.pStyleHeader.MaterialImageVersion, dbo.pStyleHeader.MaterialNo, 
                      dbo.pStyleHeader.MaterialName, dbo.pStyleHeader.POMTempGroupID1, dbo.pStyleHeader.POMTempGroupID2, dbo.pStyleHeader.POMTempGroupID3, 
                      dbo.pStyleHeader.POMTempGroupID4, dbo.pStyleHeader.POMTempID1, dbo.pStyleHeader.POMTempVersion1, dbo.pStyleHeader.POMTempSizeClass1, 
                      dbo.pStyleHeader.POMTempID2, dbo.pStyleHeader.POMTempVersion2, dbo.pStyleHeader.POMTempSizeClass2, dbo.pStyleHeader.POMTempID3, 
                      dbo.pStyleHeader.POMTempVersion3, dbo.pStyleHeader.POMTempSizeClass3, dbo.pStyleHeader.POMTempID4, dbo.pStyleHeader.POMTempVersion4, 
                      dbo.pStyleHeader.POMTempSizeClass4, dbo.pStyleHeader.StyleMaterialID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.TechSketchID, 
                      dbo.pStyleHeader.ConceptSketchID, dbo.pStyleHeader.ColorSketchID, dbo.pStyleHeader.DesignSketchVersion, dbo.pStyleHeader.TechSketchVersion, 
                      dbo.pStyleHeader.ConceptSketchVersion, dbo.pStyleHeader.ColorSketchVersion, dbo.pStyleHeader.DetailSketchID1, dbo.pStyleHeader.DetailSketchID2, 
                      dbo.pStyleHeader.DetailSketchID3, dbo.pStyleHeader.DetailSketchID4, dbo.pStyleHeader.DetailSketchVersion1, dbo.pStyleHeader.DetailSketchVersion2, 
                      dbo.pStyleHeader.DetailSketchVersion3, dbo.pStyleHeader.DetailSketchVersion4, dbo.pStyleHeader.SpecSketchID1, dbo.pStyleHeader.SpecSketchID2, 
                      dbo.pStyleHeader.SpecSketchID3, dbo.pStyleHeader.SpecSketchID4, dbo.pStyleHeader.SpecSketchVersion1, dbo.pStyleHeader.SpecSketchVersion2, 
                      dbo.pStyleHeader.SpecSketchVersion3, dbo.pStyleHeader.SpecSketchVersion4, dbo.pStyleHeader.Markup, dbo.pStyleHeader.TargetPrice, 
                      dbo.pStyleHeader.SellingPrice, dbo.pStyleHeader.CustomField1, dbo.pStyleHeader.CustomField2, dbo.pStyleHeader.CustomField3, dbo.pStyleHeader.CustomField4, 
                      dbo.pStyleHeader.CustomField5, dbo.pStyleHeader.CustomField6, dbo.pStyleHeader.CustomField7, dbo.pStyleHeader.CustomField8, dbo.pStyleHeader.CustomField9,
                       dbo.pStyleHeader.CustomField10, dbo.pStyleHeader.CustomField11, dbo.pStyleHeader.CustomField12, dbo.pStyleHeader.CustomField13, 
                      dbo.pStyleHeader.CustomField14, dbo.pStyleHeader.CustomField15, dbo.pStyleHeader.Pc1, dbo.pStyleHeader.Pc2, dbo.pStyleHeader.Pc3, dbo.pStyleHeader.Pc4, 
                      dbo.pStyleHeader.CUser, dbo.pStyleHeader.CDate, dbo.pStyleHeader.MUser, dbo.pStyleHeader.MDate, dbo.pStyleHeader.Active, dbo.pStyleHeader.Change, 
                      dbo.pStyleHeader.Action, dbo.pStyleHeader.NoColorCombo, dbo.pStyleHeader.StyleVersion, dbo.pStyleHeader.StyleDetail, dbo.pStyleHeader.StyleDetail1, 
                      dbo.pStyleHeader.StyleDetail2, dbo.pStyleHeader.StyleAttribute, dbo.pStyleHeader.LinePlanID, dbo.pStyleHeader.LinePlanNo, dbo.pStyleHeader.LinePlanSketchID, 
                      dbo.pStyleHeader.LinePlanSketchVersion, dbo.pStyleHeader.CustomField16, dbo.pStyleHeader.CustomField17, dbo.pStyleHeader.CustomField18, 
                      dbo.pStyleHeader.CustomField19, dbo.pStyleHeader.CustomField20, dbo.pStyleHeader.CustomField21, dbo.pStyleHeader.CustomField22, 
                      dbo.pStyleHeader.CustomField23, dbo.pStyleHeader.CustomField24, dbo.pStyleHeader.CustomField25, dbo.pStyleHeader.CustomField26, 
                      dbo.pStyleHeader.CustomField27, dbo.pStyleHeader.CustomField28, dbo.pStyleHeader.CustomField29, dbo.pStyleHeader.CustomField30, 
                      dbo.pStyleHeader.PackagingNo, dbo.pStyleHeader.StyleCopyID, dbo.pStyleHeader.LinePlanItemID, dbo.pStyleHeader.StyleStatusID, dbo.pStyleHeader.BodyID, 
                      dbo.pStyleHeader.TradePartnerID, dbo.pStyleHeader.TradePartnerVendorID, dbo.pSeasonYear.Year, dbo.pSeasonYear.Season, dbo.pStyleHeader.HeaderLocked, 
                      dbo.pStyleSeasonYear.StyleSeasonYearID, dbo.pStyleSeasonYear.SeasonYearID, dbo.pStyleHeader.IntroSeasonYearID,
                      dbo.pStyleHeader.StyleLinkID
FROM         dbo.pStyleHeader LEFT OUTER JOIN
                      dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID LEFT OUTER JOIN
                      dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[vwx_StyleSourcing_MaterialSummary_SELECT]'
GO

ALTER VIEW [dbo].[vwx_StyleSourcing_MaterialSummary_SELECT]
AS
SELECT     a.StyleSourcingItemID, a.StyleSourcingID, a.CDate, a.CUser, a.MDate, a.MUser, a.StyleMaterialID, a.TradePartnerVendorID, b.UOM AS Expr1, b.Qty, 
                      a.MaterialPrice, a.Sort, a.StyleColorID, a.StyleSet, a.BOM, b.MainMaterial, b.MaterialType, '' AS GroupName, c.ComponentDescription, b.MaterialNo, 
                      b.MaterialName, b.UOM, b.MaterialID, '<img src=''http://' + @@SERVERNAME + '/plmOnImageServer/ImageStream.ashx?S=50&V=' + CAST(ISNULL(b.MaterialImageVersion, 0) 
                      AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(b.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '''  />' AS MaterialImage, ISNULL(b.MaterialSize, 'NA*') AS MaterialSize, 
                      '<img src=''http://' + @@SERVERNAME + '/plmOnImageServer/ColorStream.ashx?S=40&CFID=' + CAST(ISNULL(e.ColorFolderID, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(e.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '''  />' AS Color, 
                      e.ColorPaletteID, ISNULL(b.MaterialSizeID, '00000000-0000-0000-0000-000000000000') AS MaterialSizeID, b.StyleID, b.MaterialSort, 
                      CASE WHEN b.MaterialSizeID IS NULL OR
                      b.MaterialSizeID = '00000000-0000-0000-0000-000000000000' THEN '*NA' ELSE f.MaterialSize END AS Expr2, a.CustomField1, h.SeasonYearID, 
                      e.MaterialColorID
FROM         dbo.pStyleSourcingItem AS a INNER JOIN
                      dbo.pStyleSourcing AS g ON g.StyleSourcingID = a.StyleSourcingID INNER JOIN
                      dbo.pStyleSeasonYear AS h ON g.StyleSeasonYearID = h.StyleSeasonYearID INNER JOIN
                      dbo.pStyleMaterials AS b ON a.StyleMaterialID = b.StyleMaterialID INNER JOIN
                      dbo.pComponentType AS c ON b.MaterialType = c.ComponentTypeID LEFT OUTER JOIN
                      dbo.pStyleColorwayItem AS d ON d.StyleColorID = a.StyleColorID AND d.StyleMaterialID = a.StyleMaterialID LEFT OUTER JOIN
                      dbo.pMaterialColor AS e ON e.MaterialColorID = d.MaterialColorID LEFT OUTER JOIN
                      dbo.pMaterialSize AS f ON b.MaterialSizeID = f.MaterialSizeID

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[vwx_StyleSourcing_SeasonYear_SEL]'
GO

ALTER VIEW [dbo].[vwx_StyleSourcing_SeasonYear_SEL]
AS
SELECT a.StyleSourcingID, a.StyleID, a.SourcingName, a.CDate, a.CUser, a.MDate, a.MUser, a.Custom1, 
	a.Custom2, a.Active, 
	a.TradePartnerID, a.TradePartnerVendorID, a.StyleSeasonYearID, b.SeasonYearID, b.StyleSeason + ' - ' + b.StyleYear AS SeasonYear, 
    CASE 
		WHEN a.TradePartnerVendorID = b.TradePartnerVendorID THEN 1 
		ELSE 0 END 
	AS MostLikelyVendor
FROM dbo.pStyleSourcing a WITH(NOLOCK)
	INNER JOIN dbo.pStyleSeasonYear b ON a.StyleSeasonYearID = b.StyleSeasonYearID		
	--LEFT OUTER JOIN sExchangeRate c ON CAST(c.ExchangeRateID AS NVARCHAR(40)) = a.Custom2

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[vwx_MaterialLinePlanSearch_SEL]'
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW dbo.vwx_MaterialLinePlanSearch_SEL
AS
SELECT a.MaterialID, a.MaterialType, a.MaterialNo, a.MaterialName, 
a.A, a.B, a.C, a.D, a.F, a.G, a.Source, a.Notes, a.VolumePrice, a.CUser,
a.CDate, a.Active,
'<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(a.MaterialImageVersion AS NVARCHAR(10)) + 
'&IID=' + CAST(a.MaterialImageID AS NVARCHAR(40)) +  '" />'
 AS ImagePath
FROM dbo.pMaterial a WITH(NOLOCK)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[vwx_MaterialSearch_SEL]'
GO

CREATE VIEW [dbo].[vwx_MaterialSearch_SEL]
AS
SELECT     a.MaterialID, a.TempID, a.TempNo, a.MaterialImageID, a.MaterialImageVersion, a.MaterialImageDetailID, a.MaterialImageDetailVersion, 
                      a.NoColorMatch, a.SupplierID, a.MaterialType, a.MaterialNo, a.MaterialName, a.A, a.B, a.C, a.D, a.E, a.F, a.G, a.H, a.I, a.J, a.K, a.L, a.M, a.N, a.O, a.P, 
                      a.Q, a.R, a.S, a.T, a.U, a.V, a.W, a.X, a.Y, a.Z, a.Source, a.Notes, a.VendorPrice, a.VolumePrice, a.VolumePriceMinimum, a.VendorProductionMin, 
                      a.VendorProductionLeadTime, a.MaterialPlacement, a.DetailYesNo, a.ImageType1, a.height, a.width, a.Action, a.Status, a.Active, a.MultiDimension, 
                      a.UOM, a.MaterialCode, a.MaterialCodeNo, a.SAPCode, a.SAPControl, a.MaterialColorRequired, a.FactorySourced, b.TradepartnerId, 
                      b.TradepartnerVendorId, b.MaterialTradePartnerCustom1, b.MaterialTradePartnerCustom2, b.MaterialTradePartnerCustom3, 
                      b.MaterialTradePartnerCustom4, b.MaterialTradePartnerCustom5, b.MaterialTradePartnerCustom6, b.MaterialTradePartnerCustom7, 
                      b.MaterialTradePartnerCustom8, b.MaterialTradePartnerCustom9, b.MaterialTradePartnerCustom10, b.MaterialTradePartnerCustom11, 
                      b.MaterialTradePartnerCustom12, b.MaterialTradePartnerCustom13, b.MaterialTradePartnerCustom14, b.MaterialTradePartnerCustom15, 
                      b.MaterialTradePartnerCustom16, b.MaterialTradePartnerCustom17, b.MaterialTradePartnerCustom18, b.MaterialTradePartnerCustom19, 
                      b.MaterialTradePartnerCustom20, b.MaterialTradePartnerCustom21, b.MaterialTradePartnerCustom22, b.MaterialTradePartnerCustom23, 
                      b.MaterialTradePartnerCustom24, b.MaterialTradePartnerCustom25, b.SeasonYearID,
                      f.Season, f.Year, a.MUser, a.MDate, a.CDate, a.CUser, a.MChange, 
					  '<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(a.MaterialImageVersion AS NVARCHAR(10)) 
                      + '&IID=' + CAST(a.MaterialImageID AS NVARCHAR(40)) + '" />' AS ImagePath
FROM dbo.pMaterial AS a WITH(NOLOCK) 
	LEFT OUTER JOIN dbo.pMaterialTradePartner AS b WITH (NOLOCK) ON a.MaterialID = b.MaterialId 
	LEFT OUTER JOIN dbo.pSeasonYear AS f WITH (NOLOCK) ON f.SeasonYearID = b.SeasonYearID 
	

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[vwx_pBodyPatternSheetPiece_Metric]'
GO

CREATE VIEW [dbo].[vwx_pBodyPatternSheetPiece_Metric]
AS
			select ID, 			
			Piece_Code, 			 			
			Piece_Name, 			
			Piece_Description,			
			Piece_Image_Name,			
			Piece_Category,			
			Round([Piece_Area]*6.4516,4) as Piece_Area,				
			Round([Piece_Perimeter]*2.54,4) as Piece_Perimeter										 
			from pBodyPatternSheetPiece 	

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[vwx_StyleMaterialBOM_SELECT]'
GO


ALTER VIEW [dbo].[vwx_StyleMaterialBOM_SELECT]
AS
SELECT DISTINCT 
                      dbo.pStyleMaterials.Artwork, dbo.pStyleMaterials.License, dbo.pStyleMaterials.Colorway, dbo.uTradePartnerVendor.VendorName, 
                      dbo.pStyleMaterials.StyleMaterialID, dbo.pStyleMaterials.StyleMaterialMasterID, dbo.pStyleMaterials.CopyStyleMaterialID, 
                      dbo.pStyleMaterials.MainMaterial, dbo.pStyleMaterials.Development, dbo.pStyleMaterials.MiscColor, dbo.pStyleMaterials.StyleSet, 
                      dbo.pStyleMaterials.StyleID, dbo.pStyleMaterials.UOM, dbo.pStyleMaterials.Qty, dbo.pStyleMaterials.MaterialPrice, dbo.pStyleMaterials.Ext, 
                      dbo.pStyleMaterials.MaterialSize, dbo.pStyleMaterials.MaterialID, dbo.pStyleMaterials.MaterialPlacement, 
                      dbo.pStyleMaterials.MaterialPlacementCode, dbo.pStyleMaterials.MaterialPlacementDetail, dbo.pStyleMaterials.MaterialImageID, 
                      dbo.pStyleMaterials.MaterialImageVersion, dbo.pStyleMaterials.NoColorMatch, dbo.pStyleMaterials.SupplierID, 
                      dbo.pStyleMaterials.ComponentTypeID, dbo.pStyleMaterials.MaterialType, dbo.pStyleMaterials.MaterialNo, dbo.pStyleMaterials.MaterialName, 
                      dbo.pStyleMaterials.A, dbo.pStyleMaterials.B, dbo.pStyleMaterials.C, dbo.pStyleMaterials.D, dbo.pStyleMaterials.E, dbo.pStyleMaterials.F, 
                      dbo.pStyleMaterials.G, dbo.pStyleMaterials.I, dbo.pStyleMaterials.H, dbo.pStyleMaterials.J, dbo.pStyleMaterials.K, dbo.pStyleMaterials.L, 
                      dbo.pStyleMaterials.M, dbo.pStyleMaterials.N, dbo.pStyleMaterials.O, dbo.pStyleMaterials.P, dbo.pStyleMaterials.Q, dbo.pStyleMaterials.R, 
                      dbo.pStyleMaterials.S, dbo.pStyleMaterials.T, dbo.pStyleMaterials.U, dbo.pStyleMaterials.V, dbo.pStyleMaterials.W, dbo.pStyleMaterials.X, 
                      dbo.pStyleMaterials.Y, dbo.pStyleMaterials.Z, dbo.pStyleMaterials.Source, dbo.pStyleMaterials.Notes, dbo.pStyleMaterials.Placement, 
                      dbo.pStyleMaterials.VendorPrice, dbo.pStyleMaterials.VolumePrice, dbo.pStyleMaterials.VolumePriceMinimum, 
                      dbo.pStyleMaterials.VendorProductionMin, dbo.pStyleMaterials.VendorProductionLeadTime, dbo.pStyleMaterials.DetailYesNo, 
                      dbo.pStyleMaterials.ImageType, dbo.pStyleMaterials.height, dbo.pStyleMaterials.width, dbo.pStyleMaterials.CDate, dbo.pStyleMaterials.CUser, 
                      dbo.pStyleMaterials.MDate, dbo.pStyleMaterials.MUser, dbo.pStyleMaterials.MChange, dbo.pStyleMaterials.SChange, dbo.pStyleMaterials.DChange, 
                      dbo.pStyleMaterials.CChange, dbo.pStyleMaterials.Action, dbo.pStyleMaterials.ColorPlacement, dbo.pStyleMaterials.MaterialSort, 
                      dbo.pStyleMaterials.MaterialTrack, dbo.pStyleMaterials.MaterialLinked, dbo.pStyleMaterials.MaterialDimension, dbo.pStyleMaterials.MaterialSizeA0, 
                      dbo.pStyleMaterials.MaterialSizeA1, dbo.pStyleMaterials.MaterialSizeA2, dbo.pStyleMaterials.MaterialSizeA3, dbo.pStyleMaterials.MaterialSizeA4, 
                      dbo.pStyleMaterials.MaterialSizeA5, dbo.pStyleMaterials.MaterialSizeA6, dbo.pStyleMaterials.MaterialSizeA7, dbo.pStyleMaterials.MaterialSizeA8, 
                      dbo.pStyleMaterials.MaterialSizeA9, dbo.pStyleMaterials.MaterialSizeA10, dbo.pStyleMaterials.MaterialSizeA11, dbo.pStyleMaterials.MaterialSizeA12, 
                      dbo.pStyleMaterials.MaterialSizeA13, dbo.pStyleMaterials.MaterialSizeA14, dbo.pStyleMaterials.MaterialSizeA15, 
                      dbo.pStyleMaterials.MaterialSizeA16, dbo.pStyleMaterials.MaterialSizeA17, dbo.pStyleMaterials.MaterialSizeA18, 
                      dbo.pStyleMaterials.MaterialSizeA19, dbo.pStyleMaterials.MaterialSizeB0, dbo.pStyleMaterials.MaterialSizeB1, dbo.pStyleMaterials.MaterialSizeB2, 
                      dbo.pStyleMaterials.MaterialSizeB3, dbo.pStyleMaterials.MaterialSizeB4, dbo.pStyleMaterials.MaterialSizeB5, dbo.pStyleMaterials.MaterialSizeB6, 
                      dbo.pStyleMaterials.MaterialSizeB7, dbo.pStyleMaterials.MaterialSizeB8, dbo.pStyleMaterials.MaterialSizeB9, dbo.pStyleMaterials.MaterialSizeB10, 
                      dbo.pStyleMaterials.MaterialSizeB11, dbo.pStyleMaterials.MaterialSizeB12, dbo.pStyleMaterials.MaterialSizeB13, 
                      dbo.pStyleMaterials.MaterialSizeB14, dbo.pStyleMaterials.MaterialSizeB15, dbo.pStyleMaterials.MaterialSizeB16, 
                      dbo.pStyleMaterials.MaterialSizeB18, dbo.pStyleMaterials.MaterialSizeB17, dbo.pStyleMaterials.MaterialSizeB19, dbo.pStyleMaterials.MaterialLining,
                       dbo.pStyleMaterials.MaterialSizeID, dbo.pStyleMaterials.MaterialPackLabelGroupID, dbo.pStyleMaterials.MaterialBOM, 
                      dbo.uTradePartnerVendor.TradePartnerID, dbo.pMaterial.MultiDimension, dbo.pComponentType.ComponentPackLabel,
                          (SELECT     COUNT(*) AS NoComments
                            FROM          dbo.pMaterialComment
                            WHERE      (MaterialID = dbo.pStyleMaterials.MaterialID)) AS NoComments, dbo.pMaterial.MaterialColorRequired, dbo.pMaterial.FactorySourced, 
                      dbo.pMaterial.MaterialCode
FROM         dbo.uTradePartnerVendor RIGHT OUTER JOIN
                      dbo.pStyleMaterials INNER JOIN
                      dbo.pMaterial ON dbo.pMaterial.MaterialID = dbo.pStyleMaterials.MaterialID INNER JOIN
                      dbo.pComponentType ON dbo.pStyleMaterials.MaterialType = dbo.pComponentType.ComponentTypeID ON 
                      dbo.uTradePartnerVendor.TradePartnerVendorID = dbo.pStyleMaterials.TradePartnerVendorID
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO


--
-- End of View Upgrades
-- 


--
-- Stored Procedures
--

/*
Run this script on:

        KJOHANNSEN3\KJ2008R2.GA40_to_401    -  This database will be modified

to synchronize it with:

        KJOHANNSEN3\KJ2008R2.GA401

You are recommended to back up your database before running this script

Script created by SQL Compare version 8.50.10 from Red Gate Software Ltd at 6/20/2011 1:53:06 PM

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Altering [dbo].[spx_ReportMaterialHeader_INSERT]'
GO
SET QUOTED_IDENTIFIER OFF
GO


ALTER PROCEDURE [dbo].[spx_ReportMaterialHeader_INSERT](
	@DataXmlID VARCHAR(40),
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialTradePartnerID VARCHAR(40),
	@MaterialRequestSubmitID VARCHAR(40),
	@DataXmlFile XML
)
AS 

DECLARE @SQL AS NVARCHAR(MAX)
DECLARE @ParmDefinition AS NVARCHAR(500)
DECLARE @tableName AS NVARCHAR(200)
DECLARE @ViewName AS NVARCHAR(200)

BEGIN
	-- Import Schema File to #tmpXmlImportFile
	CREATE TABLE #tmpXmlImportFile(
		[xmlFileName] VARCHAR(300) NULL,
		[xmlData] XML NOT NULL
	)
	INSERT INTO #tmpXmlImportFile([xmlData]) VALUES (@DataXmlFile)
END

BEGIN
	-- Import table schema values to #tmpXmlDocTable

	CREATE TABLE #tmpXmlDoc(
					[XmlDocId] [int] IDENTITY(1,1) NOT NULL,
					[Name] [nvarchar](200) NULL,
					[formcolumns] VARCHAR(5),
					[gridcolumns] VARCHAR(5),
					[FormSQL] VARCHAR(2000),	
					[GridReadSQL] VARCHAR(2000),
					[GridSQL] VARCHAR(2000),
					[CDate] [datetime]
					)


	CREATE TABLE #tmpXmlDocTable(
					[XmlDocId] [int] IDENTITY(1,1) NOT NULL,
					[Name] [nvarchar](200) NULL,
					[Alias] [nvarchar](200) NULL,	
					[Type] VARCHAR(200),
					[datatype] VARCHAR(200),
					[column] VARCHAR(2),
					[order] VARCHAR(3),
					[lookupquery] VARCHAR(800),
					[ValueField] VARCHAR(200),
					[Visible] [varchar](5) NULL,
					[CDate] [datetime]
					)


	DECLARE @idoc INT
	DECLARE @idoc1 INT
	DECLARE @doc XML
	SELECT @doc = xmlData FROM #tmpXmlImportFile

	EXEC sp_xml_preparedocument @idoc OUTPUT, @doc
	INSERT INTO #tmpXmlDocTable([Name], alias, Visible, CDate, [Type], datatype, lookupquery, ValueField, [column], [order])
	SELECT [Name], alias, Visible, GETDATE(), [Type], datatype, lookupquery, ValueField, [column], [order]
	FROM       OPENXML (@idoc, '/Table/column',1)
				WITH (	[Name]  VARCHAR(200),
						alias VARCHAR(200),
						[Type] VARCHAR(200),
						[column] VARCHAR(2),
						[order] VARCHAR(3),
						datatype VARCHAR(200),
						lookupquery VARCHAR(800),
						ValueField VARCHAR(200),
						Visible VARCHAR(200)				
				)
	WHERE Visible='true'
	EXEC sp_xml_removedocument @idoc --Clean Cache
	--SELECT * FROM #tmpXmlDocTable


	EXEC sp_xml_preparedocument @idoc1 OUTPUT, @doc
	INSERT INTO #tmpXmlDoc([Name], FormSQL, GridReadSQL, GridSQL)
	SELECT [Name], FormSQL, GridReadSQL, GridSQL
	FROM       OPENXML (@idoc1, '/Table', 0)
				WITH (	[Name]  VARCHAR(200),
						FormSQL VARCHAR(2000),
						GridReadSQL VARCHAR(2000),
						GridSQL VARCHAR(2000)				
				)
	WHERE FormSQL <> ''
	EXEC sp_xml_removedocument @idoc1 --Clean Cache
	
	SELECT TOP 1 @ViewName = NAME FROM #tmpXmlDoc

END

BEGIN
	--Select table to import
	SET @tableName = '##tmpMaterialHeader_' + REPLACE ( CAST(NEWID() AS NVARCHAR(40)), '-' , ''  )
	
	SELECT TOP 1 @SQL = 'SELECT * INTO ' + @tableName + ' FROM ' + Name + ' WHERE MaterialTradePartnerID = ''' +  
		CAST(@MaterialTradePartnerID AS NVARCHAR(40)) + ''' ' 
	FROM #tmpXmlDoc
	
	EXECUTE sp_executesql @SQL 
	
	SET @SQL =  'ALTER TABLE ' + @tableName + ' ADD RecID int NOT NULL IDENTITY (1, 1) '
	EXECUTE sp_executesql @SQL 
	
END

BEGIN
		
	DECLARE @TotalCountM INT
	DECLARE @RowCounterM INT


	SET @SQL = 'SELECT @pTotalCountM = COUNT(*) FROM ' + @tableName
	SET @ParmDefinition = '@pTotalCountM INT OUTPUT'
	
	EXECUTE sp_executesql @SQL, @ParmDefinition, 
		@pTotalCountM = @TotalCountM OUTPUT
	
	
	SET @RowCounterM = 1

	DECLARE @tmpMaterialID VARCHAR(40)

	WHILE(@RowCounterM <= @TotalCountM)
		BEGIN
		
			SET @SQL = 'SELECT @ptmpMaterialID = MaterialID FROM ' + @tableName + ' WHERE RecID = ' + CAST(@RowCounterM AS NVARCHAR(5))
			SET @ParmDefinition = '@ptmpMaterialID UNIQUEIDENTIFIER OUTPUT'
			
			EXECUTE sp_executesql @SQL, @ParmDefinition, 
				@ptmpMaterialID = @tmpMaterialID OUTPUT
				

			DECLARE @TotalCount INT
			DECLARE @RowCounter INT

			SELECT @TotalCount = COUNT(*) FROM #tmpXmlDocTable
			SET @RowCounter = 1

			DECLARE @tmpName VARCHAR(200)
			DECLARE @tmpAlias VARCHAR(200)	
			DECLARE @tmpType VARCHAR(200)
			DECLARE @tmpDataType VARCHAR(200)
			DECLARE @tmpLookup VARCHAR(800)
			DECLARE @tmpValueField VARCHAR(200)
			DECLARE @tmpColumn VARCHAR(2)
			DECLARE @tmpOrder VARCHAR(3)

			WHILE(@RowCounter <= @TotalCount)
				BEGIN

					SELECT @tmpAlias = REPLACE(Alias,'''',''''''), @tmpName = [Name], @tmpType = [Type], @tmpDataType = datatype, 
						@tmpLookup = lookupquery, @tmpValueField = ValueField, @tmpColumn = [column], @tmpOrder = [order]
						FROM #tmpXmlDocTable WHERE XmlDocId = @RowCounter
					
					PRINT @tmpAlias + '  ' +  @tmpDataType  
					
					IF @tmpDataType = 'query'
						BEGIN

							CREATE TABLE #tmpTable (FieldID VARCHAR(200), FieldValue VARCHAR(200))
							CREATE TABLE #tmpVar (FieldValue VARCHAR(200))

							DECLARE @tmpReturnValue VARCHAR(100)

							EXEC ('INSERT INTO #tmpTable (FieldID, FieldValue) ' + @tmpLookup) 
							EXEC ('INSERT INTO #tmpVar(FieldValue) SELECT ' + @tmpName + ' FROM pMaterial WHERE MaterialID = ''' + @tmpMaterialID + '''')

							SET @tmpReturnValue = (SELECT REPLACE(FieldValue,'''','''''') FROM #tmpTable WHERE FieldID = (SELECT FieldValue FROM #tmpVar))

							DROP TABLE #tmpTable
							DROP TABLE #tmpVar

							EXEC('
								INSERT INTO rReportMaterialHeaderTemp(DataXmlId, DataColumnNumber, DataColumnName, DataHeader, DataValue, DataSort)
									SELECT ''' + @DataXmlId + ''', ' + @tmpColumn + ',''' + @tmpName + ''',''' + @tmpAlias + ''', ''' + @tmpReturnValue + ''', ''' + @tmpOrder +
									''' FROM ' + @ViewName + '  WHERE MaterialTradePartnerID = ''' + @MaterialTradePartnerID + ''' 
								')

						END
					ELSE
						BEGIN
							
							EXEC('
								INSERT INTO rReportMaterialHeaderTemp(DataXmlId, DataColumnNumber, DataColumnName, DataHeader, DataValue, DataSort)
									SELECT ''' + @DataXmlId + ''', ' + @tmpColumn + ',''' + @tmpName + ''', ''' + @tmpAlias + ''', ' + @tmpName + ', ''' + @tmpOrder + 
									''' FROM ' + @ViewName + '  WHERE MaterialTradePartnerID = ''' + @MaterialTradePartnerID + ''' 
								')
						END
					

					SET @RowCounter = @RowCounter + 1
				END
		SET @RowCounterM = @RowCounterM + 1

	END
END


BEGIN
	--Clean up
	--DELETE FROM rReportMaterialHeaderTemp WHERE DataXmlID = @DataXmlID
	SET @SQL = 'DROP TABLE ' + @tableName
	EXECUTE sp_executesql	@SQL
	
	DROP TABLE #tmpXmlDocTable
	DROP TABLE #tmpXmlDoc
	DROP TABLE #tmpXmlImportFile
END


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_StyleSpecHowToMeasure_SELECT]'
GO


ALTER PROCEDURE [dbo].[spx_StyleSpecHowToMeasure_SELECT](
	@StyleID uniqueidentifier,
	@StyleSet INT
)
AS 

SELECT a.SpecID, a.StyleID, a.POMTempItemID, a.POMLibraryID, a.ModelSpecID, a.ModelID, a.POMTempID, a.StyleSet, 
	a.Critical, a.POM, a.PointMeasur, a.TOL, a.TOLN, a.Spec, 
	a.Proto0, a.Proto1, a.Proto2, a.Proto3, a.Proto4, a.Proto5, a.Proto6, a.Proto7, a.Proto8, a.Proto9, a.Proto10, a.Proto11, 
	a.Grade0, a.Grade1, a.Grade2, a.Grade3, a.Grade4, a.Grade5, a.Grade6, a.Grade7, a.Grade8, a.Grade9, a.Grade10, a.Grade11, 
	a.Size0, a.Size1, a.Size2, a.Size3, a.Size4, a.Size5, a.Size6, a.Size7, a.Size8, a.Size9, a.Size10, a.Size11, 
	a.CDate, a.CUser, a.MDate, a.MUser, a.Change, a.Sort, b.HowToMeasurText, a.HowToMeasurImage
FROM dbo.pStyleSpec a WITH (NOLOCK) 
	LEFT OUTER JOIN	dbo.pPOMLibrary b WITH(NOLOCK) ON a.POMLibraryID = b.POMLibraryID
WHERE a.StyleID = @StyleID
	AND a.StyleSet = @StyleSet
	AND a.POMLibraryID IS NOT NULL
ORDER BY a.Sort, a.POM, a.PointMeasur

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_Style_Marker_4Delete]'
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC  [dbo].[spx_Style_Marker_4Delete]
(
 @StyleID uniqueidentifier,
 @StyleSet int,
 @Imperial nvarchar(2)
)
AS

BEGIN
if Len(@Imperial)= 0

		begin

		select	ID, Marker_Code, Marker_Name,Marker_Description 
			,ISNULL(CAST(ROUND(Marker_Width, 4) AS NVARCHAR(20)), '') + ' IN' AS Width
	        ,ISNULL(CAST(ROUND(Marker_Length / 36, 4) AS NVARCHAR(20)), '') + ' YD' AS [Length]
		
		 
			from pBodyMarker where StyleId =@StyleID AND StyleSet = @StyleSet and IsActive =1 
			group by  Marker_Name,Marker_Width, Marker_Length, ID,Marker_Code,Marker_Description
			
		end
		
	else
		begin
			select	ID, Marker_Code, Marker_Name,Marker_Description 			
			,ISNULL(CAST(ROUND(Marker_Width * 2.54, 4) AS NVARCHAR(20)), '') + ' CM' AS Width
			,ISNULL(CAST(ROUND((Marker_Length / 36) * 0.9144, 4) AS NVARCHAR(20)), '') + ' M' AS [Length]
	
			
		 
			from pBodyMarker where StyleId =@StyleID AND StyleSet = @StyleSet and IsActive =1 
			group by Marker_Name,Marker_Width, Marker_Length, ID,Marker_Code,Marker_Description
			
		end
		
		
End
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_BodyPatternSheetPiece_GET_UPDATE]'
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROC  [dbo].[spx_BodyPatternSheetPiece_GET_UPDATE]
(
  @ModelID uniqueidentifier, 
  @CADDB varchar(50),
  @Catalog varchar(50)
)
AS

DECLARE @Model_Code  int
DECLARE @RowCnt int
DECLARE @Piece_Code int
DECLARE @MaxRows int
DECLARE @strCADsql nvarchar(max)

BEGIN

DECLARE  @ID uniqueidentifier


SELECT ROW_NUMBER() OVER(ORDER BY Piece_Code DESC) AS 'rownum', *
INTO #tempTblPBody
FROM pBodyPatternSheetPiece where ModelID=@ModelID

SELECT @RowCnt = 1
SELECT @MaxRows=count(*) from #tempTblPBody

WHILE @RowCnt <= @MaxRows
BEGIN

------------------------------------------------
set @Model_Code = (select Model_Code from #tempTblPBody where rownum = @RowCnt) 
--set @BodyID =  (select BodyID from #tempTblPBody where rownum = @RowCnt)
Set @ID =  (select ID from #tempTblPBody where rownum = @RowCnt)
Set @Piece_Code = (select Piece_Code from #tempTblPBody where rownum = @RowCnt)
------------------------------------------------
CREATE TABLE [dbo].[#tempTBLpCAD]
(
[Piece_Code] [int] NOT NULL DEFAULT (0),
	[Piece_Name] [varchar](64)  NULL,
	[Last_Updated] [datetime] NULL,
	[IsActive] [int] NULL DEFAULT ((1)),
	[IsLinked] [int] NULL DEFAULT (1),
	[ClassifierId] [int] NULL,
	[SystemId] [int] NULL,
	[Model_Code] [int] NULL DEFAULT (0),
	[Material_Code] [int] NULL,
	[Piece_Description] [varchar](510) NULL,
	[Piece_Category] [varchar] (510) NULL,
	[Rule_Table_Name] [varchar] (64) NULL,
	[Piece_CrOpId] [varchar](100) NULL,
	[Piece_Create] [datetime] NULL,
	[Piece_RevOp1] [varchar](100) NULL,
	[Piece_Rev1] [datetime] NULL,
	[Piece_RevOp2] [varchar](100) NULL,
	[Piece_Rev2] [datetime] NULL,
	[Piece_Message] [varchar](510) NULL,
	[Piece_HPTable] [varchar](100) NULL,
	[Piece_Bias] [int] NULL DEFAULT (0),
	[Piece_Flip] [int] NULL DEFAULT (0),
	[Piece_Nap] [int] NULL DEFAULT (0),
	[Piece_Ign_Splice] [int] NULL DEFAULT (0),
	[Piece_Standard] [int] NULL,
	[Piece_Buffering] [int] NULL,
	[Piece_nSplits] [int] NULL,
	[Piece_Tilt_CW] [float] NULL,
	[Piece_DieBlock] [float] NULL,
	[Piece_Pri_XBlock] [float] NULL,
	[Piece_Pri_XBlkType] [int] NULL,
	[Piece_Pri_YBlock] [float] NULL,
	[Piece_Pri_YBlkType] [int] NULL,
	[Piece_Sec_XBlock] [float] NULL,
	[Piece_Sec_XBlkType] [int] NULL,
	[Piece_Sec_YBlock] [float] NULL,
	[Piece_Sec_YBlkType] [int] NULL,
	[Piece_XVariance] [float] NULL,
	[Piece_XVar_Type] [int] NULL,
	[Piece_YVariance] [float] NULL,
	[Piece_YVar_Type] [int] NULL,
	[Piece_nUnflipped] [int] NULL,
	[Piece_nOpposite] [int] NULL,
	[Piece_nFilpY] [int] NULL,
	[Piece_nFlipXY] [int] NULL,
	[Piece_IsMirror] [int] NULL DEFAULT (0),
	[Piece_Area] [float] NULL,
	[Piece_Perimeter] [float] NULL,
	[Piece_PreRotation] [float] NULL,
	[Piece_Image_SN] [int] NULL,
	[Piece_Image_Name] [varchar](100) NULL,
	[Piece_Comments] [text] NULL,
	[UserDefined1] [varchar](100) NULL,
	[UserDefined2] [varchar](100) NULL,
	[UserDefined3] [varchar](100) NULL,
	[UserDefined4] [varchar](100) NULL,
	[UserDefined5] [varchar](100) NULL,
	[Piece_Size] [varchar](64) NULL,
	[Piece_Tilt_CCW] [float] NULL,
	[Piece_CW_Type] [int] NULL,
	[Piece_CCW_Type] [int] NULL,
	[Piece_PreRotationType] [int] NULL,
	[PiecePosition] [int] NOT NULL DEFAULT (0),
	[mPiece_Area] [float] NULL,
	[mPiece_Perimeter] [float] NULL
 

)
SELECT  @strCADsql = 'INSERT
INTO #tempTBLpCAD 
SELECT [Piece_Code]
      ,[Piece_Name]
      ,[Last_Updated]
      ,[IsActive]
      ,[IsLinked]
      ,[ClassifierId]
      ,[SystemId]
      ,[Model_Code]
      ,[Material_Code]
      ,[Piece_Description]
      ,[Piece_Category]
      ,[Rule_Table_Name]
      ,[Piece_CrOpId]
      ,[Piece_Create]
      ,[Piece_RevOp1]
      ,[Piece_Rev1]
      ,[Piece_RevOp2]
      ,[Piece_Rev2]
      ,[Piece_Message]
      ,[Piece_HPTable]
      ,[Piece_Bias]
      ,[Piece_Flip]
      ,[Piece_Nap]
      ,[Piece_Ign_Splice]
      ,[Piece_Standard]
      ,[Piece_Buffering]
      ,[Piece_nSplits]
      ,[Piece_Tilt_CW]
      ,[Piece_DieBlock]
      ,[Piece_Pri_XBlock]
      ,[Piece_Pri_XBlkType]
      ,[Piece_Pri_YBlock]
      ,[Piece_Pri_YBlkType]
      ,[Piece_Sec_XBlock]
      ,[Piece_Sec_XBlkType]
      ,[Piece_Sec_YBlock]
      ,[Piece_Sec_YBlkType]
      ,[Piece_XVariance]
      ,[Piece_XVar_Type]
      ,[Piece_YVariance]
      ,[Piece_YVar_Type]
      ,[Piece_nUnflipped]
      ,[Piece_nOpposite]
      ,[Piece_nFilpY]
      ,[Piece_nFlipXY]
      ,[Piece_IsMirror]
      ,[Piece_Area]
      ,[Piece_Perimeter]
      ,[Piece_PreRotation]
      ,[Piece_Image_SN]
      ,[Piece_Image_Name]
      ,[Piece_Comments]
      ,[UserDefined1]
      ,[UserDefined2]
      ,[UserDefined3]
      ,[UserDefined4]
      ,[UserDefined5]
      ,[Piece_Size]
      ,[Piece_Tilt_CCW]
      ,[Piece_CW_Type]
      ,[Piece_CCW_Type]
      ,[Piece_PreRotationType]
      ,[PiecePosition]
      ,[mPiece_Area]
      ,[mPiece_Perimeter]
FROM ' + @CADDB + '.' + @Catalog + '.dbo.Cad_Piece_Details WHERE  Model_Code = ' + Convert(varchar(50),@Model_Code) +'  and Piece_Code = ' + Convert(varchar(50), @Piece_Code )

EXEC (@strCADsql)

Update pBodyPatternSheetPiece
SET	 
	[Piece_Code] = (SELECT Piece_Code from  #tempTBLpCAD ),
	[Piece_Name] = (SELECT Piece_Name from  #tempTBLpCAD ),
	[Last_Updated]= (SELECT Last_Updated from  #tempTBLpCAD ),
--	[Active] = (SELECT IsActive from  #tempTBLpCAD ),
	[IsLinked] = (SELECT IsLinked from  #tempTBLpCAD ),
--	[ClassifierId] = (SELECT ClassifierId from  #tempTBLpCAD ),
--	[SystemId] = (SELECT SystemId from  #tempTBLpCAD ),
	[Model_Code] = (SELECT Model_Code from  #tempTBLpCAD ),
	[Material_Code] = (SELECT Material_Code from  #tempTBLpCAD ),
	[Piece_Description] = (SELECT Piece_Description from  #tempTBLpCAD ),
	[Piece_Category] = (SELECT Piece_Category from  #tempTBLpCAD ),
	[Rule_Table_Name] = (SELECT Rule_Table_Name from  #tempTBLpCAD ),
	[Piece_CrOpId] = (SELECT Piece_CrOpId from  #tempTBLpCAD ),
	[Piece_Create] = (SELECT Piece_Create from  #tempTBLpCAD ),
	[Piece_RevOp1] = (SELECT Piece_RevOp1 from  #tempTBLpCAD ),
	[Piece_Rev1] = (SELECT Piece_Rev1 from  #tempTBLpCAD ),
	[Piece_RevOp2] = (SELECT Piece_RevOp2 from  #tempTBLpCAD ),
	[Piece_Rev2] = (SELECT Piece_Rev2 from  #tempTBLpCAD ),
	[Piece_Message] = (SELECT Piece_Message from  #tempTBLpCAD ),
	[Piece_HPTable] = (SELECT Piece_HPTable from  #tempTBLpCAD ),
	[Piece_Bias] = (SELECT Piece_Bias from  #tempTBLpCAD ),
	[Piece_Flip] = (SELECT Piece_Flip from  #tempTBLpCAD ),
	[Piece_Nap] = (SELECT Piece_Nap from  #tempTBLpCAD ),
	[Piece_Ign_Splice] = (SELECT Piece_Ign_Splice from  #tempTBLpCAD ),
	[Piece_Standard] = (SELECT Piece_Standard from  #tempTBLpCAD ),
	[Piece_Buffering] = (SELECT Piece_Buffering from  #tempTBLpCAD ),
	[Piece_nSplits] = (SELECT Piece_nSplits from  #tempTBLpCAD ),
	[Piece_Tilt_CW] = (SELECT Piece_Tilt_CW from  #tempTBLpCAD ),
	[Piece_DieBlock] = (SELECT Piece_DieBlock from  #tempTBLpCAD ),
	[Piece_Pri_XBlock] = (SELECT Piece_Pri_XBlock from  #tempTBLpCAD ),
	[Piece_Pri_XBlkType] = (SELECT Piece_Pri_XBlkType from  #tempTBLpCAD ),
	[Piece_Pri_YBlock] = (SELECT Piece_Pri_YBlock from  #tempTBLpCAD ),
	[Piece_Pri_YBlkType] = (SELECT Piece_Pri_YBlkType from  #tempTBLpCAD ),
	[Piece_Sec_XBlock] = (SELECT Piece_Sec_XBlock from  #tempTBLpCAD ),
	[Piece_Sec_XBlkType] = (SELECT Piece_Sec_XBlkType from  #tempTBLpCAD ),
	[Piece_Sec_YBlock] = (SELECT Piece_Sec_YBlock from  #tempTBLpCAD ),
	[Piece_Sec_YBlkType] = (SELECT Piece_Sec_YBlkType from  #tempTBLpCAD ),
	[Piece_XVariance] = (SELECT Piece_XVariance from  #tempTBLpCAD ),
	[Piece_XVar_Type] = (SELECT Piece_XVar_Type from  #tempTBLpCAD ),
	[Piece_YVariance] = (SELECT Piece_YVariance from  #tempTBLpCAD ),
	[Piece_YVar_Type] = (SELECT Piece_YVar_Type from  #tempTBLpCAD ),
	[Piece_nUnflipped] = (SELECT Piece_nUnflipped from  #tempTBLpCAD ),
	[Piece_nOpposite] = (SELECT Piece_nOpposite from  #tempTBLpCAD ),
	[Piece_nFilpY] = (SELECT Piece_nFilpY from  #tempTBLpCAD ),
	[Piece_nFlipXY] = (SELECT Piece_nFlipXY from  #tempTBLpCAD ),
	[Piece_IsMirror] = (SELECT Piece_IsMirror from  #tempTBLpCAD ),
	[Piece_Area] = (SELECT Piece_Area from  #tempTBLpCAD ),
	[Piece_Perimeter] = (SELECT Piece_Perimeter from  #tempTBLpCAD ),
	[Piece_PreRotation] = (SELECT Piece_PreRotation from  #tempTBLpCAD ),
	[Piece_Image_SN] = (SELECT Piece_Image_SN from  #tempTBLpCAD ),
	[Piece_Image_Name] = (SELECT Piece_Image_Name from  #tempTBLpCAD ),
--	[Piece_Comments] = (SELECT Piece_Comments from  #tempTBLpCAD ),
--	[UserDefined1] = (SELECT UserDefined1 from  #tempTBLpCAD ),
--	[UserDefined2] = (SELECT UserDefined2 from  #tempTBLpCAD ),
--	[UserDefined3] = (SELECT UserDefined3 from  #tempTBLpCAD ),
--	[UserDefined4] = (SELECT UserDefined4 from  #tempTBLpCAD ),
--	[UserDefined5] = (SELECT UserDefined5 from  #tempTBLpCAD ),
	[Piece_Size] = (SELECT Piece_Size from  #tempTBLpCAD ),
	[Piece_Tilt_CCW] = (SELECT Piece_Tilt_CCW from  #tempTBLpCAD ),
	[Piece_CW_Type] = (SELECT Piece_CW_Type from  #tempTBLpCAD ),
	[Piece_CCW_Type] = (SELECT Piece_CCW_Type from  #tempTBLpCAD ),
	[Piece_PreRotationType] = (SELECT Piece_PreRotationType from  #tempTBLpCAD ),
	[PiecePosition] = (SELECT PiecePosition from  #tempTBLpCAD ),
	[mPiece_Area] = (SELECT mPiece_Area from  #tempTBLpCAD ),
	[mPiece_Perimeter] = (SELECT mPiece_Perimeter from  #tempTBLpCAD )
--	ImageID = (SELECT Piece_Image_SN from  #tempTBLpCAD )
	
Where pBodyPatternSheetPiece.Piece_Code = (select Piece_Code from #tempTblPBody where rownum = @RowCnt) AND ModelID=@ModelID

     
Select @RowCnt = @RowCnt + 1
Drop Table #tempTBLpCAD
END

Drop Table #tempTBLPBody
END


----------------------------------------------------------------

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_StyleColorwayITEMS_SELECT]'
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[spx_StyleColorwayITEMS_SELECT] (
@StyleID UNIQUEIDENTIFIER ,
@StyleSet INT,
@SeasonYearID NVARCHAR(50)= NULL
)
AS 


DECLARE 
	@TOTAL INT,
	@ROW1 INT,
	@ROW2 INT, 
	@StyleColorID1 UNIQUEIDENTIFIER, 
	@StyleColorID2 UNIQUEIDENTIFIER, 
	@StyleColorID3 UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialColorID1 UNIQUEIDENTIFIER,
	@MaterialColorID2 UNIQUEIDENTIFIER,
	@MaterialColorID3 UNIQUEIDENTIFIER,
	@ItemID INT,
	@mmTOTAL INT,
	@mmROWID INT,
	@smTOTAL INT,
	@smROWID INT,
	@SubComponentID UNIQUEIDENTIFIER,
	@SubComponentItem INT,
	@MaterialColorID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER,
	@ColorFolderID UNIQUEIDENTIFIER,
	@ColorCode NVARCHAR(200), 
	@ColorName NVARCHAR(200),
	@MaterialLinkColorID UNIQUEIDENTIFIER,
	@MaterialLinkColorItemID UNIQUEIDENTIFIER

CREATE TABLE #tmpStyleColorway (
Rec_ID INT IDENTITY (1,1),
StyleColorID UNIQUEIDENTIFIER, 
StyleColorNo NVARCHAR(200), 
StyleColorName NVARCHAR(200),
MainColor NVARCHAR(100),
SAPCode NVARCHAR(200), 
PLMCode NVARCHAR(200)
)



IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
BEGIN 

	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 

	SELECT @StyleSeasonYearID  = StyleSeasonYearID 
	FROM pStyleSeasonYear
	WHERE SeasonYearID = @SeasonYearID AND StyleID = @StyleID 

	INSERT INTO #tmpStyleColorway (StyleColorID , StyleColorNo, StyleColorName, MainColor, SAPCode , PLMCode)

	SELECT b.StyleColorID , b.StyleColorNo, c.ColorName, c.ColorName, b.SAPCode, b.PLMCode 
	FROM pStyleColorwaySeasonYear a 
	INNER JOIN pStyleColorway b ON a.StyleColorwayID = b.StyleColorID
	INNER JOIN pColorPalette c ON c.ColorPaletteID = b.ColorPaletteID 
	WHERE  a.StyleID = @StyleID
	AND a.StyleSeasonYearID = @StyleSeasonYearID
	--AND b.StyleSet = @StyleSet  #02
	ORDER BY b.Sort, b.MainColor

END
ELSE 
BEGIN

	INSERT INTO #tmpStyleColorway (StyleColorID , StyleColorNo, StyleColorName, MainColor, SAPCode , PLMCode)
	SELECT StyleColorID , StyleColorNo, b.ColorName AS StyleColorName, b.ColorName AS MainColor, SAPCode, PLMCode 
	FROM pStyleColorway a 
	INNER JOIN pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID 
	WHERE StyleID = @StyleID 
	--AND StyleSet = @StyleSet #02
	ORDER BY a.Sort, a.MainColor

END



SELECT @TOTAL  = COUNT(*) FROM #tmpStyleColorway 
SET @ROW1 = 1

DECLARE @NUMBER_COLUMNS INT
SET @NUMBER_COLUMNS = 3 


SELECT * FROM #tmpStyleColorway
DECLARE @SQL NVARCHAR(4000)

CREATE TABLE  #tmp1 ( 
	ROWID INT IDENTITY (1,1),
	MaterialNo NVARCHAR(10), 
	MaterialName NVARCHAR(200), 
	MainMaterial int,
	MultiDimension INT, 
	StyleMaterialID UNIQUEIDENTIFIER, 
	MaterialType INT, 
	Placement NVARCHAR(4000),
	MaterialID1 UNIQUEIDENTIFIER, 
	StyleColorItemID1 UNIQUEIDENTIFIER, 
	StyleMaterialID1 UNIQUEIDENTIFIER, 
	MaterialColorID1 UNIQUEIDENTIFIER,		
	MaterialColorImageID1 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion1 int, 
	ColorFolderId1 UNIQUEIDENTIFIER, 
	ColorPaletteID1 UNIQUEIDENTIFIER, 
	ColorCode1 NVARCHAR(200),
	ColorName1 NVARCHAR(200),
	MaterialColorNote1 NVARCHAR(4000), 
	MaterialSort NVARCHAR(5), 
	ComponentOrder NVARCHAR(5)
)

CREATE TABLE #tmp2 (
	ROWID INT IDENTITY(1,1),
	MaterialID2 UNIQUEIDENTIFIER, 
	StyleColorItemID2 UNIQUEIDENTIFIER, 
	StyleMaterialID2 UNIQUEIDENTIFIER, 
	MaterialColorID2 UNIQUEIDENTIFIER,		
	MaterialColorImageID2 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion2 int, 
	ColorFolderId2 UNIQUEIDENTIFIER, 
	ColorPaletteID2 UNIQUEIDENTIFIER, 
	ColorCode2 NVARCHAR(200),
	ColorName2 NVARCHAR(200),
	MaterialColorNote2 NVARCHAR(4000)
)
CREATE TABLE #tmp3 (
	ROWID INT IDENTITY(1,1),
	MaterialID3 UNIQUEIDENTIFIER, 
	StyleColorItemID3 UNIQUEIDENTIFIER, 
	StyleMaterialID3 UNIQUEIDENTIFIER, 
	MaterialColorID3 UNIQUEIDENTIFIER,		
	MaterialColorImageID3 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion3 int, 
	ColorFolderId3 UNIQUEIDENTIFIER, 
	ColorPaletteID3 UNIQUEIDENTIFIER, 
	ColorCode3 NVARCHAR(200),
	ColorName3 NVARCHAR(200),
	MaterialColorNote3 NVARCHAR(4000)
)


CREATE TABLE  #output ( 
	ROWID INT IDENTITY(1,1),
	SubComponent INT,
	SubComponentName NVARCHAR(200),
	SubComponentID UNIQUEIDENTIFIER,
	SubComponentItem INT DEFAULT(0),
	MaterialNo NVARCHAR(10), 
	MaterialName NVARCHAR(200), 
	MainMaterial int,
	MultiDimension INT, 
	StyleMaterialID UNIQUEIDENTIFIER, 
	MaterialType INT, 
	Placement NVARCHAR(4000),
	MaterialID1 UNIQUEIDENTIFIER, 
	StyleColorItemID1 UNIQUEIDENTIFIER, 
	StyleMaterialID1 UNIQUEIDENTIFIER, 
	MaterialColorID1 UNIQUEIDENTIFIER,		
	MaterialColorImageID1 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion1 int, 
	ColorFolderId1 UNIQUEIDENTIFIER, 
	ColorPaletteID1 UNIQUEIDENTIFIER, 
	ColorCode1 NVARCHAR(200),
	ColorName1 NVARCHAR(200),
	MaterialColorNote1 NVARCHAR(200),
	
	MaterialID2 UNIQUEIDENTIFIER, 
	StyleColorItemID2 UNIQUEIDENTIFIER, 
	StyleMaterialID2 UNIQUEIDENTIFIER, 
	MaterialColorID2 UNIQUEIDENTIFIER,		
	MaterialColorImageID2 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion2 int, 
	ColorFolderId2 UNIQUEIDENTIFIER, 
	ColorPaletteID2 UNIQUEIDENTIFIER, 
	ColorCode2 NVARCHAR(200),
	ColorName2 NVARCHAR(200),
	MaterialColorNote2 NVARCHAR(200),
	
	MaterialID3 UNIQUEIDENTIFIER, 
	StyleColorItemID3 UNIQUEIDENTIFIER, 
	StyleMaterialID3 UNIQUEIDENTIFIER, 
	MaterialColorID3 UNIQUEIDENTIFIER,		
	MaterialColorImageID3 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion3 int, 
	ColorFolderId3 UNIQUEIDENTIFIER, 
	ColorPaletteID3 UNIQUEIDENTIFIER, 
	ColorCode3 NVARCHAR(200),
	ColorName3 NVARCHAR(200),
	MaterialColorNote3 NVARCHAR(200)
)

CREATE TABLE #MultiMaterial(
	ROWID INT IDENTITY(1,1),
	ItemID INT,
	MaterialID UNIQUEIDENTIFIER,
	MaterialColorID1 UNIQUEIDENTIFIER,
	MaterialColorID2 UNIQUEIDENTIFIER,
	MaterialColorID3 UNIQUEIDENTIFIER
)


WHILE @ROW1 <= @TOTAL
BEGIN

	DELETE FROM #tmp1
	DELETE FROM #tmp2
	DELETE FROM #tmp3
	DELETE FROM #output
	DELETE FROM #MultiMaterial

	IF @ROW1 + @NUMBER_COLUMNS - 1  >  @TOTAL 
		SET @ROW2  = @TOTAL		
	ELSE
		SET @ROW2 = @ROW1 + @NUMBER_COLUMNS - 1


	SET @StyleColorID1 =  NULL
	SET @StyleColorID2 =  NULL
	SET @StyleColorID3 =  NULL


	SELECT @StyleColorID1 = StyleColorID FROM #tmpStyleColorway WHERE Rec_ID = @Row1
	SELECT @StyleColorID2 = StyleColorID FROM #tmpStyleColorway WHERE Rec_ID = @Row1 + 1 
	SELECT @StyleColorID3 = StyleColorID FROM #tmpStyleColorway WHERE Rec_ID = @Row1 + 2 


	IF	@StyleColorID1 IS NOT NULL 
	BEGIN
	
	
		INSERT INTO #tmp1 ( 
			MaterialNo, MaterialName, MainMaterial, MultiDimension, StyleMaterialID, 
			MaterialType, Placement, MaterialID1, StyleColorItemID1,StyleMaterialID1, 
			MaterialColorID1, MaterialColorImageID1, MaterialColorImageVersion1, 
			ColorFolderId1,ColorPaletteID1, ColorCode1, ColorName1,
			MaterialColorNote1, MaterialSort, ComponentOrder )
		SELECT d.MaterialNo, d.MaterialName , d.MainMaterial, e.MultiDimension , d.StyleMaterialID, 
			d.MaterialType, d.Placement, e.MaterialID AS MaterialID1, a.StyleColorItemID AS StyleColorItemID1, a.StyleMaterialID AS StyleMaterialID1, 
			a.MaterialColorID  AS MaterialColorID1,b.MaterialColorImageID AS MaterialColorImageID1 , b.MaterialColorImageVersion AS MaterialColorImageVersion1, 
			b.ColorFolderId AS ColorFolderId1,  b.ColorPaletteID AS ColorPaletteID1, 
			CASE 
				WHEN b.ColorCode IS NULL THEN ''
				ELSE b.ColorCode 
			END AS ColorCode1, b.ColorName AS ColorName1,
			b.MaterialColorNote AS MaterialColorNote1 , d.MaterialSort, f.ComponentOrder
		FROM pStyleColorWayItem  a LEFT OUTER  JOIN  pMaterialColor b ON a.MaterialColorID = b.MaterialColorID 
		INNER JOIN pStyleMaterials d ON d.StyleMaterialID  =  a.StyleMaterialID  
		INNER JOIN pMaterial e ON d.MaterialID = e.MaterialID 
		INNER JOIN pComponentType f ON d.MaterialType = f.ComponentTypeID 
		WHERE a.StyleColorID = @StyleColorID1
		AND a.StyleSet = @StyleSet 
	END


	IF	@StyleColorID2 IS NOT NULL 
	BEGIN
	
		INSERT INTO #tmp2 ( 
			MaterialID2, StyleColorItemID2,StyleMaterialID2, 
			MaterialColorID2, MaterialColorImageID2, MaterialColorImageVersion2, 
			ColorFolderId2,ColorPaletteID2, ColorCode2, ColorName2,
			MaterialColorNote2)
		SELECT b.MaterialID AS MaterialID2, a.StyleColorItemID AS StyleColorItemID2, a.StyleMaterialID AS StyleMaterialID2 , a.MaterialColorID  AS MaterialColorID2 ,	--Comment #01
		b.MaterialColorImageID AS MaterialColorImageID2 , b.MaterialColorImageVersion AS MaterialColorImageVersion2, b.ColorFolderId AS ColorFolderId2,  b.ColorPaletteID AS ColorPaletteID2, 
		CASE 
			WHEN b.ColorCode IS NULL THEN ''
			ELSE b.ColorCode 
		END 
			AS ColorCode2, b.ColorName AS ColorName2, 
			b.MaterialColorNote AS MaterialColorNote2
		FROM pStyleColorWayItem  a LEFT OUTER  JOIN  pMaterialColor b ON a.MaterialColorID = b.MaterialColorID 
		WHERE a.StyleColorID = @StyleColorID2
		AND a.StyleSet = @StyleSet 
	END 


	IF @StyleColorID3 IS NOT NULL
	BEGIN 
	
		INSERT INTO #tmp3 ( 
			MaterialID3, StyleColorItemID3,StyleMaterialID3, 
			MaterialColorID3, MaterialColorImageID3, MaterialColorImageVersion3, 
			ColorFolderId3,ColorPaletteID3, ColorCode3, ColorName3,
			MaterialColorNote3)	
		SELECT b.MaterialID AS MaterialID3, a.StyleColorItemID AS StyleColorItemID3, a.StyleMaterialID AS StyleMaterialID3 , a.MaterialColorID  AS MaterialColorID3 ,		--Comment #01
		b.MaterialColorImageID AS MaterialColorImageID3 , b.MaterialColorImageVersion AS MaterialColorImageVersion3, b.ColorFolderId AS ColorFolderId3,  b.ColorPaletteID AS ColorPaletteID3, 
		CASE 
			WHEN b.ColorCode IS NULL THEN ''
			ELSE b.ColorCode 
		END 
			AS ColorCode3, b.ColorName AS ColorName3, 
			b.MaterialColorNote AS MaterialColorNote3
		FROM pStyleColorWayItem  a LEFT OUTER  JOIN  pMaterialColor b ON a.MaterialColorID = b.MaterialColorID 
		WHERE a.StyleColorID = @StyleColorID3	
		AND a.StyleSet = @StyleSet 
	END


	IF @StyleColorID3 IS NOT NULL
	BEGIN	
		INSERT INTO  #output ( 
			MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1,
			
			MaterialID2,StyleColorItemID2, StyleMaterialID2, MaterialColorID2,
			MaterialColorImageID2,MaterialColorImageVersion2, ColorFolderId2, 
			ColorPaletteID2, ColorCode2, ColorName2,
			
			MaterialID3,StyleColorItemID3, StyleMaterialID3, MaterialColorID3,
			MaterialColorImageID3,MaterialColorImageVersion3, ColorFolderId3, 
			ColorPaletteID3, ColorCode3, ColorName3 ) 
	
		SELECT MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1,
			
			MaterialID2,StyleColorItemID2, StyleMaterialID2, MaterialColorID2,
			MaterialColorImageID2,MaterialColorImageVersion2, ColorFolderId2, 
			ColorPaletteID2, ColorCode2, ColorName2,
			
			MaterialID3,StyleColorItemID3, StyleMaterialID3, MaterialColorID3,
			MaterialColorImageID3,MaterialColorImageVersion3, ColorFolderId3, 
			ColorPaletteID3, ColorCode3, ColorName3 
		from #tmp1 a INNER JOIN #tmp2  b ON a.StyleMaterialID1 = b.StyleMaterialID2  
			INNER JOIN #tmp3 c ON a.StyleMaterialID1 = c.StyleMaterialID3  
		ORDER BY a.MainMaterial DESC, a.ComponentOrder, 
			a.MaterialSort, a.MaterialNo, a.MaterialName, a.StyleMaterialId  

			--DROP TABLE  #tmp1
			--DROP TABLE  #tmp2
			--DROP TABLE  #tmp3
	END
	ELSE IF ( @StyleColorID1 IS NOT NULL ) AND ( @StyleColorID2 IS NOT NULL  )  
	BEGIN
		
		INSERT INTO  #output ( 
			MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1,
			
			MaterialID2,StyleColorItemID2, StyleMaterialID2, MaterialColorID2,
			MaterialColorImageID2,MaterialColorImageVersion2, ColorFolderId2, 
			ColorPaletteID2, ColorCode2, ColorName2 ) 
					
		SELECT 	MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1,
			
			MaterialID2,StyleColorItemID2, StyleMaterialID2, MaterialColorID2,
			MaterialColorImageID2,MaterialColorImageVersion2, ColorFolderId2, 
			ColorPaletteID2, ColorCode2, ColorName2 
		
		FROM #tmp1 a INNER JOIN #tmp2  b ON a.StyleMaterialID1 = b.StyleMaterialID2  
			ORDER BY a.MainMaterial DESC, a.ComponentOrder, 
			a.MaterialSort, a.MaterialNo, a.MaterialName, a.StyleMaterialId  

			--DROP TABLE  #tmp1
			--DROP TABLE  #tmp2
	END 
	ELSE
	BEGIN 
	
		INSERT INTO  #output ( 
			MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1 ) 
					
		SELECT MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1
		FROM #tmp1 a 
			ORDER BY a.MainMaterial DESC, a.ComponentOrder, 
			a.MaterialSort, a.MaterialNo, a.MaterialName, a.StyleMaterialId  

			--DROP TABLE  #tmp1
	END
	
	
	UPDATE #output SET SubComponent = ROWID		
	
	--***
	--** Get multi materials
	--***
	INSERT INTO #MultiMaterial ( ItemID, MaterialID,MaterialColorID1,MaterialColorID2,MaterialColorID3 )
	SELECT ROWID, MaterialID1,MaterialColorID1,MaterialColorID2,MaterialColorID3
	FROM #output a
	WHERE a.MultiDimension = 1 
				
	
	SELECT @mmROWID = ISNULL(MIN(ROWID),1)  FROM #MultiMaterial 
	SELECT @mmTOTAL = COUNT(*) FROM #MultiMaterial 
	
	SET @mmTOTAL = @mmTOTAL + @mmROWID - 1

	WHILE @mmROWID <= @mmTOTAL 
	BEGIN 
	
		SELECT @MaterialID = MaterialID, @MaterialColorID1 = MaterialColorID1,
			@MaterialColorID2 = MaterialColorID2, @MaterialColorID3 = MaterialColorID3,
			@ItemID = ItemID
		FROM #MultiMaterial WHERE ROWID	= @mmROWID
		
		
		CREATE TABLE #subComponent (
			ROWID INT IDENTITY (1,1),
			SubComponentID UNIQUEIDENTIFIER
		)
	
		--** Get sub Components	
		INSERT INTO #subComponent (SubComponentID)
		SELECT b.MaterialID
		FROM dbo.pMaterialLink a 
			INNER JOIN dbo.pMaterial b  ON a.MaterialID = b.MaterialID
		WHERE a.MaterialGroupID = @MaterialID
		

		-- ** Insert subComponents
		INSERT INTO #output ( SubComponentName, SubComponentID, SubComponent, SubComponentItem, MaterialID1 ) 
		SELECT b.MaterialName, b.MaterialID, @ItemID, 1, @MaterialID
		FROM dbo.pMaterialLink a 
			INNER JOIN dbo.pMaterial b  ON a.MaterialID = b.MaterialID
		WHERE a.MaterialGroupID = @MaterialID
		
		
		SELECT @smTOTAL = COUNT(*) FROM #subComponent
		SET @smROWID  = 1 
		
		WHILE @smROWID <= @smTOTAL
		BEGIN
		
			SELECT @SubComponentID = SubComponentID
			FROM #subComponent WHERE ROWID = @smROWID
		
			/*
			-- Insert subcomponents
			INSERT INTO #output (SubComponentName, SubComponentID, SubComponent ) 
			SELECT a.MaterialName, a.MaterialID, @ItemID
			FROM dbo.pMaterial a  
			WHERE a.MaterialID = @SubComponentID
			*/
			
			IF @MaterialColorID1 IS NOT NULL
			BEGIN
				SELECT @MaterialColorID = NULL, @ColorPaletteID = NULL, @ColorFolderID = NULL, @ColorCode =NULL, @ColorName =NULL,
				@MaterialLinkColorID = NULL, @MaterialLinkColorItemID = NULL
				
				
				SELECT @MaterialColorID = a.MaterialColorID, @ColorPaletteID= c.ColorPaletteID, @ColorFolderID = c.ColorFolderID,
					@ColorCode = d.ColorCode, @ColorName = d.ColorName,
					@MaterialLinkColorID= b.MaterialLinkColorwayID, @MaterialLinkColorItemID = a.MaterialLinkColorwayItemID
				FROM dbo.pMaterialLinkColorwayItem a 
					INNER JOIN pMaterialLinkColorway b ON a.MaterialLinkColorwayID =  b.MaterialLinkColorwayID
					LEFT OUTER JOIN dbo.pMaterialColor c ON c.MaterialColorId =  a.MaterialColorID
					LEFT OUTER JOIN dbo.pColorPalette d ON d.ColorPaletteID =  c.ColorPaletteID
				WHERE a.MaterialID = @SubComponentID
				AND b.MaterialGroupID  = @MaterialID
				AND b.MaterialColorID = @MaterialColorID1

				
				UPDATE #output 
				SET MaterialColorID1 = @MaterialColorID, ColorPaletteID1 = @ColorPaletteID, ColorFolderID1 = @ColorFolderID,
				ColorCode1 = @ColorCode, ColorName1 = @ColorName,
				StyleMaterialID1 =@MaterialLinkColorID, StyleColorItemID1 = @MaterialLinkColorItemID
				WHERE SubComponentID  = @SubComponentID AND SubComponent = @ItemID
			END 

			IF @MaterialColorID2 IS NOT NULL
			BEGIN
				SELECT @MaterialColorID = NULL, @ColorPaletteID = NULL, @ColorFolderID = NULL, @ColorCode =NULL, @ColorName =NULL,
				@MaterialLinkColorID = NULL, @MaterialLinkColorItemID = NULL
				
				
				SELECT @MaterialColorID = a.MaterialColorID, @ColorPaletteID= c.ColorPaletteID, @ColorFolderID = c.ColorFolderID,
					@ColorCode = d.ColorCode, @ColorName = d.ColorName,
					@MaterialLinkColorID= b.MaterialLinkColorwayID, @MaterialLinkColorItemID = a.MaterialLinkColorwayItemID
				FROM dbo.pMaterialLinkColorwayItem a 
					INNER JOIN pMaterialLinkColorway b ON a.MaterialLinkColorwayID =  b.MaterialLinkColorwayID
					LEFT OUTER JOIN dbo.pMaterialColor c ON c.MaterialColorId =  a.MaterialColorID
					LEFT OUTER JOIN dbo.pColorPalette d ON d.ColorPaletteID =  c.ColorPaletteID
				WHERE a.MaterialID = @SubComponentID
				AND b.MaterialGroupID  = @MaterialID
				AND b.MaterialColorID = @MaterialColorID2
				
				
				UPDATE #output 
				SET MaterialColorID2= @MaterialColorID, ColorPaletteID2= @ColorPaletteID, ColorFolderID2= @ColorFolderID,
				ColorCode2= @ColorCode, ColorName2= @ColorName,
				StyleMaterialID2 =@MaterialLinkColorID, StyleColorItemID2 = @MaterialLinkColorItemID
				WHERE SubComponentID  = @SubComponentID AND SubComponent = @ItemID
			END 
			
			IF @MaterialColorID3 IS NOT NULL
			BEGIN
				SELECT @MaterialColorID = NULL, @ColorPaletteID = NULL, @ColorFolderID = NULL, @ColorCode =NULL, @ColorName =NULL,
				@MaterialLinkColorID = NULL, @MaterialLinkColorItemID = NULL

				SELECT @MaterialColorID = a.MaterialColorID, @ColorPaletteID= c.ColorPaletteID, @ColorFolderID = c.ColorFolderID,
					@ColorCode = d.ColorCode, @ColorName = d.ColorName,
					@MaterialLinkColorID= b.MaterialLinkColorwayID, @MaterialLinkColorItemID = a.MaterialLinkColorwayItemID
				FROM dbo.pMaterialLinkColorwayItem a 
					INNER JOIN pMaterialLinkColorway b ON a.MaterialLinkColorwayID =  b.MaterialLinkColorwayID
					LEFT OUTER JOIN dbo.pMaterialColor c ON c.MaterialColorId =  a.MaterialColorID
					LEFT OUTER JOIN dbo.pColorPalette d ON d.ColorPaletteID =  c.ColorPaletteID
				WHERE a.MaterialID = @SubComponentID
				AND b.MaterialGroupID  = @MaterialID
				AND b.MaterialColorID = @MaterialColorID3

				
				UPDATE #output 
				SET MaterialColorID3= @MaterialColorID, ColorPaletteID3= @ColorPaletteID, ColorFolderID3= @ColorFolderID,
				ColorCode3= @ColorCode, ColorName3= @ColorName,
				StyleMaterialID3 =@MaterialLinkColorID, StyleColorItemID3 = @MaterialLinkColorItemID
				WHERE SubComponentID  = @SubComponentID AND SubComponent = @ItemID
			END 

			
			SET @smROWID = @smROWID + 1 
		END  -- WHILE @smROWID <= @smTOTAL
		DROP TABLE #subComponent
	
		SET @mmROWID = @mmROWID + 1
	END 

	
	
	SELECT * FROM #output
	ORDER BY SubComponent, ROWID
		
	SET @ROW1  = @ROW2 + 1 
END 

DROP TABLE #tmpStyleColorway

DROP TABLE  #tmp1
DROP TABLE  #tmp2
DROP TABLE  #tmp3
DROP TABLE  #MultiMaterial
DROP TABLE  #output
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_User_AccessFolder_SELECT]'
GO
SET QUOTED_IDENTIFIER OFF
GO


ALTER PROCEDURE [dbo].[spx_User_AccessFolder_SELECT](
	@nDeskFolderId INT  , 
	@TeamID UNIQUEIDENTIFIER,
	@TemplateID UNIQUEIDENTIFIER,
	@TemplateItemValue UNIQUEIDENTIFIER
)
AS

IF  @nDeskFolderId  = 2  
	SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, a.AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessStyleFolder a INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
	WHERE a.TeamId = @TeamID
	ORDER BY StyleTypeOrder

ELSE IF @nDeskFolderId  = 3  
	SELECT @nDeskFolderId AS DeskFolderID, 'Line Folder' AS  TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove, a.AccessDelete, a.AccessPrint , a.AccessCreate
	FROM  sAccessLineFolder  a 
	WHERE a.TeamId = @TeamID

ELSE  IF @nDeskFolderId  = 4
	SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessQuotationFolder a INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
	WHERE a.TeamId = @TeamID
	ORDER BY StyleTypeOrder

ELSE  IF @nDeskFolderId  = 5
	SELECT @nDeskFolderId AS DeskFolderID, b.SampleWorkflow AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, a.AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessSampleFolder a INNER JOIN pSampleWorkflow b ON a.SampleTypeID = b.SampleWorkflowID
	WHERE a.TeamId = @TeamID
	ORDER BY b.SampleWorkflowSort

ELSE  IF @nDeskFolderId  = 6
	SELECT @nDeskFolderId AS DeskFolderID, b.ImageType  AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify,  0 AS AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessImageFolder a INNER JOIN pImageType b ON a.ImageTypeId = b.ImageTypeId 
	WHERE a.TeamId = @TeamID
	AND b.Active = 1
	ORDER BY b.ImageOrder

ELSE  IF @nDeskFolderId  = 7
/*
	SELECT @nDeskFolderId AS DeskFolderID, 'Color Folder' as  TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify,  0 as AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessColorFolder  a 
	WHERE a.TeamId = @TeamID
*/
	SELECT @nDeskFolderId AS DeskFolderID, b.ColorTypeDescription AS TypeDescription, a.AccessRoleID, a.AccessView, a.AccessModify, 
	a.AccessDelete, a.AccessDelete, a.AccessPrint, a.AccessCreate, 0 AS AccessRemove
	FROM  sAccessColorFolder  a 
	INNER JOIN pColorType b ON a.ColorTypeID =  b.ColorTypeID
	WHERE a.TeamID = @TeamID
	ORDER BY b.Sort


ELSE  IF @nDeskFolderId  = 8
	SELECT @nDeskFolderId AS DeskFolderID, b.ComponentDescription  AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessMaterialFolder  a INNER JOIN pComponentType  b ON a.ComponentTypeID  = b.ComponentTypeId 
	WHERE a.TeamId = @TeamID
	ORDER BY b.ComponentOrder

ELSE  IF @nDeskFolderId  = 9
	SELECT @nDeskFolderId AS DeskFolderID, b.ComplianceType AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessComplianceFolder a INNER JOIN pComplianceType  b ON a.ComplianceTypeId  = b.ComplianceTypeId 
	WHERE a.TeamId = @TeamID
	ORDER BY b.ComplianceOrder, b.ComplianceType

ELSE  IF @nDeskFolderId  = 10
	SELECT @nDeskFolderId AS DeskFolderID, b.ControlPanelName AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessControlPanel  a INNER JOIN pControlPanel  b ON a.ControlPanelId  = b.ControlPanelId
	WHERE a.TeamId = @TeamID
	ORDER BY b.ControlPanelOrder

ELSE  IF @nDeskFolderId  = 11
	SELECT @nDeskFolderId AS DeskFolderID, 'Share Folder' AS  TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify,  0 AS AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessShareFolder a 
	WHERE a.TeamId = @TeamID

ELSE  IF @nDeskFolderId  = 12
	SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessCosting  a INNER JOIN pStyleType b ON a.StyleTypeID = b.StyleTypeID
	WHERE a.TeamId = @TeamID
	ORDER BY StyleTypeOrder

ELSE  IF @nDeskFolderId  = 13  -- LinePlan
BEGIN 

	SELECT  d.LinePlanTabName AS TypeDescription,a.LinePlanTemplateID, d.LinePlanTabSort,
		MAX(a.AccessRoleId) AS AccessRoleId, MAX(a.AccessView) AS AccessView, 
		MAX(a.AccessCreate) AS AccessCreate , MAX(a.accessModify) AS accessModify, 
		MAX(a.AccessDelete) AS AccessDelete , MAX(a.AccessPrint) AS AccessPrint, MAX(a.AccessRemove) AS AccessRemove
	FROM sAccessGroupLinePlanTab a
		INNER JOIN sAccessGroupLinePlanFolder b ON b.AccessLinePlanId =  a.AccessLinePlanId
		INNER JOIN dbo.pLinePlanFolderTab c ON c.LinePlanFolderTabID =  a.LinePlanFolderTabID
		INNER JOIN dbo.pLinePlanTab d ON d.LinePlanTabID =  c.LinePlanTabID
		INNER JOIN dbo.uUserGroup e ON e.GroupID =  b.GroupID 
			AND e.TeamID = @TeamID
	WHERE  b.CustomID = @TemplateItemValue  
	AND a.LinePlanTemplateID = @TemplateID 
	GROUP BY d.LinePlanTabName,a.LinePlanTemplateID, d.LinePlanTabSort
	ORDER BY d.LinePlanTabSort

END


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[rpx_LineFolder_Image_4x0_SELECT]'
GO


/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.  Needed to add the 'Version' field to the temp table for
the image stream and get the 'Version' from 'hImage' to put in the temp table.
*/


ALTER PROCEDURE [dbo].[rpx_LineFolder_Image_4x0_SELECT]
( 
	@LineFolderID AS varchar(255)
)
AS


CREATE TABLE #tempLineFolderStyles
(
	TableRow int identity(0,1),
	StyleID varchar(50),
	StyleNo varchar(50),
	[Description] nvarchar(255),
	ImageID varchar(50),
	ImageHistoryID varchar(50),
	LineFolderItemDrop varchar(5),
	LineFolderItemDropUser nvarchar(255),
	LineFolderItemDropDate datetime,
	SizeClass nvarchar(50),
	SizeRange nvarchar(50),
	MaterialName nvarchar(100),
	MaterialNo nvarchar(50),
	[Version] int	--Comment #01
)

/*Insert info into temp table.*/
INSERT INTO #tempLineFolderStyles(StyleID, StyleNo, [Description], ImageID, ImageHistoryID,
	LineFolderItemDrop, LineFolderItemDropUser,	LineFolderItemDropDate, SizeClass, SizeRange, MaterialName,
	MaterialNo, [Version])	--Comment #01
SELECT b.StyleID, b.StyleNo, b.[Description], c.ImageID, c.ImageHistoryID,
	a.LineFolderItemDrop, a.LineFolderItemDropUser, a.LineFolderItemDropDate, b.SizeClass, b.SizeRange, d.MaterialName,
	d.MaterialNo, c.[Version]	--Comment #01
FROM pLineFolderItem a INNER JOIN pStyleHeader b ON
a.StyleID = b.StyleID LEFT OUTER JOIN hImage c ON
b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version LEFT OUTER JOIN pMaterial d ON
b.MaterialID = d.MaterialID
WHERE LineFolderID = @LineFolderID
ORDER BY a.LineFolderItemSort, b.StyleNo, b.Description


/*Select the information how you want for the report.*/
SELECT
	TableRow / 4 AS [Row],
	TableRow % 4 AS [Column],
	StyleID,
	StyleNo,
	[Description],
	dbo.fnx_GetStreamingImagePath(ImageID, [Version]) AS FilePath,	--Comment #01
	@LineFolderID AS LineFolderID,
	LineFolderItemDrop,
	'Dropped By ' + LineFolderItemDropUser + ' - ' + CAST(LineFolderItemDropDate AS varchar(50)) AS DroppedInfo,
	SizeClass,
	SizeRange,
	MaterialName,
	MaterialNo
FROM #tempLineFolderStyles

DROP TABLE #tempLineFolderStyles
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_ReportMaterialRequestSubmitItem_INSERT]'
GO

ALTER PROCEDURE [dbo].[spx_ReportMaterialRequestSubmitItem_INSERT]
(
	@DataXmlID varchar(40),
	@MaterialRequestWorkflowID varchar(5),
	@MaterialRequestSubmitID varchar(40),
	@DataXmlFile xml
)
AS 

--DECLARE @MaterialRequestWorkflowID varchar(5)
--DECLARE @MaterialRequestSubmitID uniqueidentifier
--DECLARE @DataXmlID varchar(36)

DECLARE @XmlPath varchar(400)
DECLARE @XmlFileName VARCHAR(200)
DECLARE @XmlFolderName varchar(200)

--SET @MaterialRequestSubmitID = '97dc2fc9-74a7-4530-b4fd-edceab1114e5' 
--SET @MaterialRequestWorkflowID = 'A90'
--SET @DataXmlID = newId()


BEGIN
	-- Select Schema File
	SELECT @XmlFolderName = XmlSchemaPath FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1
	SELECT @XmlFileName = MaterialRequestWorkflowSchema FROM dbo.pMaterialRequestWorkflow WHERE MaterialRequestWorkflowID = @MaterialRequestWorkflowID
	SELECT @XmlPath = @XmlFolderName + '\' + @XmlFileName
END

BEGIN
	-- Import Schema File to #tmpXmlImportFile
	CREATE TABLE #tmpXmlImportFile(
		[xmlFileName] VARCHAR(300) NULL,
		[xmlData] XML NOT NULL
	)

	INSERT INTO #tmpXmlImportFile([xmlData]) VALUES (@DataXmlFile)

--	EXEC('INSERT INTO #tmpXmlImportFile(xmlFileName, xmlData)
--		SELECT ''' + @XmlPath + ''', xmlData
--		FROM(
--		SELECT *
--		FROM OPENROWSET (BULK ''' + @XmlPath + ''' , SINGLE_BLOB) AS XMLDATA
--		) AS FileImport (XMLDATA)
--		')
END

BEGIN
	-- Import table schema values to #tmpXmlDocTable
	CREATE TABLE #tmpXmlDocTable(
					[XmlDocId] [int] IDENTITY(1,1) NOT NULL,
					[Name] [nvarchar](200) NULL,
					[Alias] [nvarchar](200) NULL,	
					[Type] varchar(200),
					[datatype] varchar(200),
					[lookupquery] varchar(800),
					[ValueField] varchar(200),
					[Visible] [varchar](5) NULL,
					[CDate] [datetime])


	DECLARE @idoc int
	DECLARE @doc XML
	SELECT @doc = xmlData FROM #tmpXmlImportFile

	EXEC sp_xml_preparedocument @idoc OUTPUT, @doc
	INSERT INTO #tmpXmlDocTable([Name], alias, Visible, CDate, [Type], datatype, lookupquery, ValueField)
	SELECT [Name], alias, Visible, getdate(), [Type], datatype, lookupquery, ValueField
	FROM       OPENXML (@idoc, '/Table/column',1)
				WITH (	[Name]  varchar(200),
						alias varchar(200),
						[Type] varchar(200),
						datatype varchar(200),
						lookupquery varchar(800),
						ValueField varchar(200),
						Visible varchar(200)				
				)
	WHERE Visible='true'
	EXEC sp_xml_removedocument @idoc --Clean Cache
	--SELECT * FROM #tmpXmlDocTable

END

BEGIN
	--Import pMaterialRequestSubmitItem values to temp table
	SELECT * INTO #tmpMaterialRequest
	FROM pMaterialRequestSubmitItem WHERE MaterialRequestSubmitID = @MaterialRequestSubmitID
	ORDER BY MaterialRequestSubmitItemSort ASC

	ALTER TABLE #tmpMaterialRequest ADD
	RecID int NOT NULL IDENTITY (1, 1)
	--SELECT * FROM #tmpMaterialRequest
END

BEGIN
		
	DECLARE @TotalCountM int
	DECLARE @RowCounterM int

	SELECT @TotalCountM = COUNT(*) FROM #tmpMaterialRequest
	SET @RowCounterM = 1

	DECLARE @tmpMaterialRequestSubmitItemID varchar(40)

	WHILE(@RowCounterM <= @TotalCountM)
		BEGIN

			SELECT @tmpMaterialRequestSubmitItemID = MaterialRequestSubmitItemID
						FROM #tmpMaterialRequest WHERE RecID = @RowCounterM

			DECLARE @TotalCount int
			DECLARE @RowCounter int

			SELECT @TotalCount = COUNT(*) FROM #tmpXmlDocTable
			SET @RowCounter = 1

			DECLARE @tmpName varchar(200)
			DECLARE @tmpAlias varchar(200)	
			DECLARE @tmpType varchar(200)
			DECLARE @tmpDataType varchar(200)
			DECLARE @tmpLookup varchar(800)
			DECLARE @tmpValueField varchar(200)

			WHILE(@RowCounter <= @TotalCount)
				BEGIN

					SELECT @tmpAlias = Alias, @tmpName = [Name], @tmpType = [Type], @tmpDataType = datatype, @tmpLookup = lookupquery, @tmpValueField = ValueField
						FROM #tmpXmlDocTable WHERE XmlDocId = @RowCounter
					
					IF @tmpDataType = 'query'
						BEGIN

							CREATE TABLE #tmpTable (FieldID varchar(200), FieldValue varchar(200))
							CREATE TABLE #tmpVar (FieldValue varchar(200))

							DECLARE @tmpReturnValue varchar(100)

							EXEC ('INSERT INTO #tmpTable (FieldID, FieldValue) ' + @tmpLookup) 
							EXEC ('INSERT INTO #tmpVar(FieldValue) SELECT ' + @tmpName + ' FROM pMaterialRequestSubmitItem WHERE MaterialRequestSubmitItemID = ''' + @tmpMaterialRequestSubmitItemID + '''')

							SET @tmpReturnValue = (SELECT FieldValue FROM #tmpTable WHERE FieldID = (SELECT FieldValue FROM #tmpVar))

							DROP TABLE #tmpTable
							DROP TABLE #tmpVar

							EXEC('
								INSERT INTO rReportMaterialRequestItemTemp(DataXmlId, MaterialRequestSubmitItemID, MaterialRequestSubmitID, DataColumnNumber, DataColumnName, DataColumnValue, DataSort)
								SELECT ''' + @DataXmlId + ''', MaterialRequestSubmitItemID, MaterialRequestSubmitID, ' + @RowCounter + ',''' + @tmpAlias + ''', ''' + @tmpReturnValue + ''', MaterialRequestSubmitItemSort FROM pMaterialRequestSubmitItem WHERE MaterialRequestSubmitItemID = ''' + @tmpMaterialRequestSubmitItemID + ''' 
								')

						END
					ELSE
						BEGIN
							EXEC('
								INSERT INTO rReportMaterialRequestItemTemp(DataXmlId, MaterialRequestSubmitItemID, MaterialRequestSubmitID, DataColumnNumber, DataColumnName, DataColumnValue, DataSort)
								SELECT ''' + @DataXmlId + ''', MaterialRequestSubmitItemID, MaterialRequestSubmitID, ' + @RowCounter + ',''' + @tmpAlias + ''', ' + @tmpName + ', MaterialRequestSubmitItemSort FROM pMaterialRequestSubmitItem WHERE MaterialRequestSubmitItemID = ''' + @tmpMaterialRequestSubmitItemID + ''' 
								')
						END
					

					SET @RowCounter = @RowCounter + 1
				END
		SET @RowCounterM = @RowCounterM + 1

	END
END

--BEGIN
--	SELECT * FROM rReportMaterialRequestItemTemp WHERE DataColumnName <> 'Sort'
--END

BEGIN
	--Clean up
	--DELETE FROM rReportMaterialRequestItemTemp WHERE DataXmlID = @DataXmlID
	DROP TABLE #tmpMaterialRequest
	DROP TABLE #tmpXmlDocTable
	DROP TABLE #tmpXmlImportFile
END


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_ReportMaterialRequestSubmitLogic_INSERT]'
GO

ALTER PROCEDURE [dbo].[spx_ReportMaterialRequestSubmitLogic_INSERT]
(
	@DataXmlID varchar(40),
	@MaterialID varchar(40),
	@MaterialTradePartnerColorID varchar(40),
	@MaterialRequestSubmitID varchar(40),
	@MaterialRequestWorkflowID varchar(5),
	@MaterialRequestHeaderXml xml,
	@MaterialRequestBodyXml xml		
)
AS 

DECLARE @MaterialTradePartnerID varchar(40)
BEGIN
	SELECT  @MaterialTradePartnerID = MaterialTradePartnerID FROM pMaterialTradePartnerColor WHERE MaterialTradePartnerColorID =  @MaterialTradePartnerColorID
END

BEGIN
	EXEC spx_ReportMaterialHeader_INSERT @DataXmlId, @MaterialID, @MaterialTradePartnerID, @MaterialRequestSubmitID, @MaterialRequestHeaderXml
	EXEC spx_ReportMaterialRequestSubmitItem_INSERT @DataXmlId, @MaterialRequestWorkflowID, @MaterialRequestSubmitID, @MaterialRequestBodyXml   
END 



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[rpx_LineFolder_Image_8x3_SELECT]'
GO


/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.  Needed to add the 'Version' field to the temp table for
the image stream and get the 'Version' from 'hImage' to put in the temp table.
*/


ALTER PROCEDURE [dbo].[rpx_LineFolder_Image_8x3_SELECT]
( 
	@LineFolderID AS varchar(255)
)
AS


CREATE TABLE #tempLineFolderStyles
(
	TableRow int identity(0,1),
	StyleID varchar(50),
	StyleNo varchar(50),
	[Description] nvarchar(255),
	ImageID varchar(50),
	ImageHistoryID varchar(50),
	LineFolderItemDrop varchar(5),
	LineFolderItemDropUser nvarchar(255),
	LineFolderItemDropDate datetime,
	SizeClass nvarchar(50),
	SizeRange nvarchar(50),
	MaterialName nvarchar(100),
	MaterialNo nvarchar(50),
	[Version] int	--Comment #01
)

/*Insert info into temp table.*/
INSERT INTO #tempLineFolderStyles(StyleID, StyleNo, [Description], ImageID, ImageHistoryID,
	LineFolderItemDrop, LineFolderItemDropUser,	LineFolderItemDropDate, SizeClass, SizeRange, MaterialName,
	MaterialNo, [Version])	--Comment #01
SELECT b.StyleID, b.StyleNo, b.[Description], c.ImageID, c.ImageHistoryID,
	a.LineFolderItemDrop, a.LineFolderItemDropUser, a.LineFolderItemDropDate, b.SizeClass, b.SizeRange, d.MaterialName,
	d.MaterialNo, c.[Version]	--Comment #01
FROM pLineFolderItem a INNER JOIN pStyleHeader b ON
a.StyleID = b.StyleID LEFT OUTER JOIN hImage c ON
b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version LEFT OUTER JOIN pMaterial d ON
b.MaterialID = d.MaterialID
WHERE LineFolderID = @LineFolderID
ORDER BY a.LineFolderItemSort, b.StyleNo, b.Description


/*Select the information how you want for the report.*/
SELECT
	TableRow / 8 AS Row,
	TableRow % 8 AS [Column],
	StyleID,
	StyleNo,
	[Description],
	dbo.fnx_GetStreamingImagePath(ImageID, [Version]) AS FilePath,	--Comment #01
	@LineFolderID AS LineFolderID,
	LineFolderItemDrop,
	'Dropped By ' + LineFolderItemDropUser + ' - ' + CAST(LineFolderItemDropDate AS varchar(50)) AS DroppedInfo,
	SizeClass,
	SizeRange,
	MaterialName,
	MaterialNo
FROM #tempLineFolderStyles

DROP TABLE #tempLineFolderStyles
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[rpx_LineFolder_MainMaterial_SELECT]'
GO


/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.  Needed to add the 'Version' field to the temp table for
the image stream and get the 'Version' from 'hImage' to put in the temp table.
*/


ALTER PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_SELECT]
(
	@LineFolderID AS varchar(50)
)
AS


CREATE TABLE #tempLineFolderStyles
(
	TableRow int identity(0,1),
	StyleID varchar(50),
	StyleNo varchar(50),
	[Description] nvarchar(255),
	ImageID varchar(50),
	ImageHistoryID varchar(50),
	LineFolderItemDrop varchar(5),
	LineFolderItemDropUser nvarchar(255),
	LineFolderItemDropDate datetime,
	SizeClass nvarchar(50),
	SizeRange nvarchar(50),
	MaterialName nvarchar(100),
	MaterialNo nvarchar(50),
	[Version] int	--Comment #01
)

/*Insert info into temp table.*/
INSERT INTO #tempLineFolderStyles(StyleID, StyleNo, [Description], ImageID, ImageHistoryID,
	LineFolderItemDrop, LineFolderItemDropUser,	LineFolderItemDropDate, SizeClass, SizeRange, MaterialName,
	MaterialNo, [Version])	--Comment #01
SELECT b.StyleID, b.StyleNo, b.[Description], c.ImageID, c.ImageHistoryID,
	a.LineFolderItemDrop, a.LineFolderItemDropUser, a.LineFolderItemDropDate, b.SizeClass, b.SizeRange, d.MaterialName,
	d.MaterialNo, c.[Version]	--Comment #01
FROM pLineFolderItem a INNER JOIN pStyleHeader b ON
a.StyleID = b.StyleID LEFT OUTER JOIN hImage c ON
b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version LEFT OUTER JOIN pMaterial d ON
b.MaterialID = d.MaterialID
WHERE a.LineFolderID = @LineFolderID
ORDER BY a.LineFolderItemSort, b.StyleNo, b.Description

/*Select the information how you want for the report.*/
SELECT
	TableRow / 3 AS [Row],
	TableRow % 3 AS [Column],
	StyleID,
	StyleNo,
	[Description],
	dbo.fnx_GetStreamingImagePath(ImageID, [Version]) AS FilePath,	--Comment #01
	@LineFolderID AS LineFolderID,
	LineFolderItemDrop,
	'Dropped By ' + LineFolderItemDropUser + ' - ' + CAST(LineFolderItemDropDate AS varchar(50)) AS DroppedInfo,
	SizeClass,
	SizeRange,
	MaterialName,
	MaterialNo
FROM #tempLineFolderStyles

DROP TABLE #tempLineFolderStyles
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_SampleRequestSpecItemDataSet_Logic_SELECT]'
GO

ALTER PROCEDURE [dbo].[spx_SampleRequestSpecItemDataSet_Logic_SELECT] (
	@StyleID uniqueidentifier, 
	@StyleSet int,
	@SampleRequestTradeID uniqueidentifier,
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleWorkflowID varchar (50) ,
	@Submit int
)
AS 

DECLARE @ApprovedType INT 


SELECT @ApprovedType = b.ApprovedType 
FROM pSampleRequestSubmit a WITH(NOLOCK)
	INNER JOIN pSampleRequestSubmitStatus b  WITH(NOLOCK) ON a.Status = b.StatusID 
WHERE a.SampleRequestTradeID = @SampleRequestTradeID 
	AND a.SampleWorkflowID  = @SampleWorkflowID 
	AND a.Submit = @Submit 
	

SELECT 
	a.POM, a.PointMeasur, a.POMTempID, b.POMLibraryID, a.SpecID, a.StyleID, a.POMTempItemID,  a.ModelSpecID, a.ModelID, 
	a.StyleSet, a.Critical,   a.TOL, a.TOLN, a.Spec, a.Proto0, 
	a.Proto1, a.Proto2, a.Proto3, a.Proto4, a.Proto5, a.Proto6, a.Proto7, a.Proto8, a.Proto9, a.Proto10, a.Proto11, a.Grade0, a.Grade1, a.Grade2, 
	a.Grade3, a.Grade4, a.Grade5, a.Grade6, 
	a.Grade7, a.Grade8, a.Grade9, a.Grade10, a.Grade11, a.Size0, a.Size1, a.Size2, a.Size3, a.Size4, a.Size5, a.Size6, a.Size7, a.Size8, 
	a.Size9, a.Size10, a.Size11, a.CDate, a.CUser, 
	a.MDate, a.MUser, a.Change, a.Sort, b.HowToMeasurText, b.HowToMeasurImage ,
	a.SampleRequestSpecID, a.Ask, a.Var, a.Vendor, a.Rev, a.Final,
	CASE 
		WHEN a.POMTempID IS NULL THEN ''
		ELSE '<img src="../System/Icons/icon_link.gif" style="border-width:0px;" />'
	END  AS Linked,
	CASE a.Critical
		WHEN 1 THEN '<img src="../System/Icons/icon_warning.gif" style="border-width:0px;" />'
		ELSE ''
	END AS IsCritical,
	CASE 
		WHEN b.POMLibraryID IS NOT NULL THEN '<input Onclick="javascript:var w=window.open( ''../Control/Control_POMLibrary_HowTo.aspx?PLID=' +
			CAST(b.POMLibraryID AS NVARCHAR(40)) + '&PTID='', ''POMSubmit'', ''menubar=0,toolbar=0,status=0,scrollbars=1,location=0,resizable=1,top=1,left=1,height=600,width=800''); w.focus(); return false;" 
			type="image" src="../System/Icons/icon_howto.gif" style="border-width:0px;" />'
		ELSE ''
	END AS HowTo,
	CASE 
		WHEN a.POMTempID IS NULL THEN 0
		ELSE 1
	END  AS Locked	
FROM pSampleRequestSpecItem a WITH (NOLOCK) 
	LEFT OUTER JOIN pPOMLibrary b WITH (NOLOCK) ON a.POM = b.POM AND a.PointMeasur = b.PointMeasur
WHERE a.StyleID = @StyleID
	AND  a.StyleSet = @StyleSet
	AND a.SampleRequestTradeID = @SampleRequestTradeID
	AND a.SampleRequestWorkflowID = @SampleRequestWorkflowID
	AND a.SampleWorkflowID = @SampleWorkflowID
	AND a.Submit = @Submit
ORDER BY a.Sort, a.POM, a.PointMeasur


	--** Define Schema structure 
	CREATE TABLE #tb (
		GridOrder INT IDENTITY(1,1), 
		[Column] NVARCHAR(200),
		Alias NVARCHAR(200),
		Type  NVARCHAR(200),
		datatype NVARCHAR(200),
		dataformat NVARCHAR(200),
		cellwidth INT,
		GridWidth INT,
		GridHeaderCss NVARCHAR(200),
		LockId NVARCHAR(10)
	)

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss ) 
	VALUES('Linked', 'L', 'label', 'string', 50, 15, 'TableHeader' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss ) 
	VALUES('IsCritical', 'C', 'label', 'string', 50, 15, 'TableHeader' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss ) 
	VALUES('HowTo', 'H', 'label', 'string', 50, 15, 'TableHeader' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, LockId)   
	VALUES('POM', 'POM', 'textbox', 'string', 50, 40, 'TableHeader', '1' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, LockId) 
	VALUES('PointMeasur', 'Point of Measurement', 'textbox', 'string', 50, 200, 'TableHeader','1' )


	--' If washtype = EMPTY then show TOLN
	IF ( SELECT LEN(ISNULL(WashType,'')) FROM pStyleHeader WHERE StyleID = @StyleID) = 0 
		INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, dataformat ) 
		VALUES('TOLN', 'TOLN', 'textbox', 'fraction', 50, 60, 'TableHeaderRed' , '' )
	ELSE
		INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss ) 
		VALUES('TOL', 'TOL', 'textbox', 'fraction', 50, 60, 'TableHeaderRed'  )
	

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss , dataformat ) 
	VALUES('Ask', 'Asked', 'textbox', 'fraction', 50, 60, 'TableHeaderBlue', '' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, dataformat ) 
	VALUES('Var', 'Var', 'label', 'fraction', 50, 60, 'TableHeaderRed', '' )

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss, dataformat ) 
	VALUES('Vendor', 'Vendor', 'label', 'fraction', 50, 60, 'TableHeaderYellow', '' )


	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss ) 
	VALUES('Spec', '<input type="checkbox" name="chkCpy2Spec" /> Spec.', 'textbox', 'fraction', 50, 60, 'TableHeader')

	INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss ) 
	VALUES('Rev', '<input type="checkbox" name="chkCpy2Rev" /> Rev', 'textbox', 'fraction', 50, 60, 'TableHeaderGreen')

	IF @ApprovedType = 1 
		INSERT INTO #tb ( [Column], Alias, Type, datatype, cellwidth, GridWidth, GridHeaderCss ) 
		VALUES('Final', '<input type="checkbox" name="chkCpy2Final" />Final', 'textbox', 'fraction', 50, 60, 'TableHeader' )

	SELECT RIGHT( '0000'+ CAST(GridOrder AS NVARCHAR(3)), 4)  AS GridOrder, [Column], Alias, Type, 
	datatype, dataformat, cellwidth, GridWidth, GridHeaderCss, ISNULL(LockId,0) AS LockId
	FROM #tb
	
	DROP TABLE #tb 	

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_SampleRequestSpecItem_UPDATE]'
GO


ALTER PROCEDURE [dbo].[spx_SampleRequestSpecItem_UPDATE](
	@SampleRequestSpecID UNIQUEIDENTIFIER, 
	@Status INT,
	@WashType NVARCHAR(20),
	@Pom NVARCHAR(10),
	@PomMeasurment NVARCHAR(200),
	@Tol NUMERIC(18,4),
	@TolN NUMERIC(18,4),
	@Var NUMERIC(18,4),   /*** Clay Parker July 6 2009 - Modified 18,4 to 18,2 to correct rounding issues onscreen in sample request **/
	@Ask NUMERIC(18,4),
	@Rev NUMERIC(18,4),
	@Spec NUMERIC(18,4),
	@Final NUMERIC(18,4),
	@ModifiedBy NVARCHAR(200),
	@ModifiedDate DATETIME
)


AS 

	IF @WashType = 'NONWASH'
		BEGIN
			UPDATE dbo.pSampleRequestSpecItem SET 
				POM = @Pom,
				PointMeasur = @PomMeasurment,
				TOLN = @TolN, 
				Ask = @Ask,
				Var = @Var,
				Rev = @Rev,
				Spec = @Spec,
				Final = @Final,
				MUser = @ModifiedBy, 
				MDate = @ModifiedDate
			WHERE (SampleRequestSpecID = @SampleRequestSpecID)  
		END
	ELSE
		BEGIN
			UPDATE dbo.pSampleRequestSpecItem SET 
				POM = @Pom,
				PointMeasur = @PomMeasurment,
				TOL = @Tol, 
				Ask = @Ask,
				Var = @Var,
				Rev = @Rev,
				Spec = @Spec,
				Final = @Final,
				MUser = @ModifiedBy, 
				MDate = @ModifiedDate
			WHERE (SampleRequestSpecID = @SampleRequestSpecID)  
		END
		
	IF @Status = 1 --Resubmit
	BEGIN
		UPDATE pSampleRequestSpecItem SET Rev = Ask
		FROM pSampleRequestSpecItem 
		WHERE (SampleRequestSpecID = @SampleRequestSpecID) AND (Rev = 0)
	END  

	-- Modified by Artemio 
	--  December 5, 2008		
	DECLARE @ApprovedType AS INT 
	SELECT @ApprovedType = ApprovedType FROM pSampleRequestSubmitStatus WITH(NOLOCK) WHERE StatusID = @Status
	IF @ApprovedType IS NULL
		SET @ApprovedType = 0

			

	--IF @Status = 3 OR @Status = 2 --Approved
	IF @ApprovedType = 1 --Approved
		BEGIN		
			UPDATE pSampleRequestSpecItem SET Rev = Ask
			FROM pSampleRequestSpecItem 
			WHERE (SampleRequestSpecID = @SampleRequestSpecID) AND (Rev = 0)
			
			UPDATE pSampleRequestSpecItem SET Final = Rev
			WHERE (SampleRequestSpecID = @SampleRequestSpecID) AND (Final = 0) AND (Rev <> 0)
				
		END  



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_BatchQueueMaterialFindReplace_tempMaterialColor_INSERT]'
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.spx_BatchQueueMaterialFindReplace_tempMaterialColor_INSERT(
	@BachQTransactionID UNIQUEIDENTIFIER,
	@MaterialColorFindID UNIQUEIDENTIFIER,
	@MaterialColorReplaceID UNIQUEIDENTIFIER
)
AS 


INSERT INTO bBatchQueuMaterialColorReplaceTmp(
	BachQTransactionID,
	MaterialColorFindID, 
	MaterialColorReplaceID
)
VALUES(
	@BachQTransactionID,
	@MaterialColorFindID, 
	@MaterialColorReplaceID
)


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_Style_Model_Body_UPDATE]'
GO

ALTER procedure [dbo].[spx_Style_Model_Body_UPDATE] (
@tblID UNIQUEIDENTIFIER ,
--@strID UNIQUEIDENTIFIER ,
@BodyID UNIQUEIDENTIFIER ,
@StyleID UNIQUEIDENTIFIER 

)
AS
Declare @Linked as int
Declare @LinkedBF as int
Declare @ImageID as UNIQUEIDENTIFIER 
Set @ImageID = null
Set @Linked = (Select IsLinked From pBodyPatternSheetModel Where ID = @tblID)
Set @LinkedBF = 1

BEGIN

Update pBodyPatternSheetModel
set styleID = @StyleID , IsLinkedBF = @LinkedBF
where ID = @tblID and BodyID =@BodyID 

Update pBodyPatternSheetPiece set 
styleID = @StyleID , IsLinked=@Linked
where ModelID = @tblID and BodyID =@BodyID 

END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_BatchQueueMaterialFindReplace_tempMaterialSize_INSERT]'
GO

CREATE PROCEDURE dbo.spx_BatchQueueMaterialFindReplace_tempMaterialSize_INSERT(
	@BachQTransactionID UNIQUEIDENTIFIER,
	@MaterialSizeFindID UNIQUEIDENTIFIER,
	@MaterialSizeReplaceID UNIQUEIDENTIFIER
)
AS 


INSERT INTO bBatchQueuMaterialSizeReplaceTmp(
	BachQTransactionID,
	MaterialSizeFindID, 
	MaterialSizeReplaceID
)
VALUES(
	@BachQTransactionID,
	@MaterialSizeFindID, 
	@MaterialSizeReplaceID
)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_BatchQueueMaterialFindReplace_tempTransaction_INSERT]'
GO

CREATE PROCEDURE dbo.spx_BatchQueueMaterialFindReplace_tempTransaction_INSERT(
	@BachQTransactionID UNIQUEIDENTIFIER,
	@BatchQueueMaterialReplaceID UNIQUEIDENTIFIER,
	@CDate DATETIME,
	@CUser NVARCHAR(200),
	@TeamID UNIQUEIDENTIFIER
)
AS 

DELETE bBatchQueuMaterialColorReplaceTmp
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
	INNER JOIN bBatchQueuMaterialColorReplaceTmp c ON c.BachQTransactionID = b.BachQTransactionID
WHERE a.TeamID = @TeamID	

DELETE bBatchQueuMaterialSizeReplaceTmp 
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
	INNER JOIN bBatchQueuMaterialSizeReplaceTmp c ON c.BachQTransactionID = b.BachQTransactionID
WHERE a.TeamID = @TeamID	


DELETE bBatchQueuMaterialReplaceTransactionTmp
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
WHERE a.TeamID = @TeamID	


INSERT INTO bBatchQueuMaterialReplaceTransactionTmp(
	BachQTransactionID ,
	BatchQueueMaterialReplaceID ,
	CDate,
	CUser, 
	TeamID)
VALUES (
	@BachQTransactionID ,
	@BatchQueueMaterialReplaceID ,
	@CDate,
	@CUser, 
	@TeamID)
	

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_Share_TechPack_SELECT]'
GO


CREATE PROCEDURE  dbo.spx_Share_TechPack_SELECT(
	@TradePartnerID UNIQUEIDENTIFIER
)
AS


	SELECT 
		'<img src="../System/Icons/icon_package.gif" />' AS IconPath,
		b.StyleNo + ' (' + b.SizeClass + ') ' +  b.Description AS Style,
		a.StyleId,  b.StyleNo, b.Description, b.SizeClass, a.TechPackId, c.CDate, b.DevelopmentId  
	FROM pTechPackTeam a WITH(NOLOCK) 
		INNER JOIN pStyleHeader b WITH(NOLOCK) ON a.StyleId  = b.StyleID
		INNER JOIN pTechPack c WITH(NOLOCK) ON a.TechPackID = c.TechPackID
    WHERE a.TeamID = @TradePartnerID 
    ORDER BY c.CDate 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_Share_Quote_SELECT]'
GO


CREATE PROCEDURE  dbo.spx_Share_Quote_SELECT(
	@TradePartnerID UNIQUEIDENTIFIER
)
AS

    SELECT  '<img src="../System/Icons/icon_quote.gif" />' AS IconPath,
		b.StyleNo + ' (' + b.SizeClass + ') ' +  b.Description AS Style,
		a.StyleQuoteItemID, a.CDate, a.TradePartnerID,  b.StyleID, b.StyleNo,  b.Description, b.SizeClass, b.DevelopmentId
	FROM pStyleQuoteItem a WITH(NOLOCK) 
		INNER JOIN pStyleHeader b WITH(NOLOCK)  ON a.StyleID = b.StyleID
	WHERE a.TradePartnerID = @TradePartnerID  
		AND a.StyleQuoteItemShare = 1 
	ORDER BY a.CDate 
	

  
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_Body_Model_Piece_DELETE]'
GO

ALTER PROCEDURE [dbo].[spx_Body_Model_Piece_DELETE]
(
@ID uniqueidentifier
)
AS 

DECLARE @ModelID UNIQUEIDENTIFIER
Begin

SET @ModelID =(SELECT ModelID FROM pBodyPatternSheetPiece WHERE  ID = @ID)



DELETE FROM pBodyPatternSheetPiece
WHERE  ID = @ID

UPDATE pBodyPatternSheetModel 
   SET Model_nPieces  = Model_nPieces-1 
WHERE ID = @ModelID

End
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_LinePlanNewStyle_Data_SELECT]'
GO

CREATE PROCEDURE  dbo.spx_LinePlanNewStyle_Data_SELECT (
	@LinePlanItemID	UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@FormSQL NVARCHAR(MAX)
)
AS 

DECLARE 
	@SQL NVARCHAR(MAX),
	@StyleHeaderField NVARCHAR(200),
	@DefaultValue NVARCHAR(200),
	@ROWID INT,
	@TOTAL INT,
	@StyleType INT,
	@CustomField3 NVARCHAR(200)
	
	
SELECT  * INTO #tmp FROM pStyleHeader WHERE StyleID = @StyleID 

-- Get Default values 
CREATE TABLE #tmpDefaults ( 
RecID INT,
StyleHeaderField NVARCHAR(200),
DefaultValue NVARCHAR(200),
SetDefault INT DEFAULT 1 
)

INSERT INTO #tmpDefaults EXECUTE spx_LinePlanStyleHeaderFields_Logic_SELECT @LinePlanItemID = @LinePlanItemID, @StyleCopy = 0


SET @ROWID = 1
SELECT @TOTAL = COUNT(*) FROM #tmpDefaults

WHILE @ROWID <= @TOTAL 
BEGIN
	SELECT @StyleHeaderField = StyleHeaderField, @DefaultValue = DefaultValue FROM #tmpDefaults WHERE RecID = @ROWID

	SET @SQL = 'UPDATE #tmp SET ' + @StyleHeaderField + ' = '''  +  @DefaultValue + ''' '
	EXEC sys.sp_executesql @SQL
	
	SET @ROWID = @ROWID  + 1 
END 
DROP TABLE #tmpDefaults


SELECT * FROM #tmp
DROP TABLE #tmp

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_Share_Sample_SELECT]'
GO

CREATE PROCEDURE  dbo.spx_Share_Sample_SELECT(
	@TradePartnerID UNIQUEIDENTIFIER
)
AS
    
	SELECT '<img src="../System/Icons/icon_ball_blue.gif" />' AS IconPath,
		b.StyleNo + ' (' + b.SizeClass + ') ' +  b.Description AS Style,
		a.SampleRequestTradeID, a.CDate, a.TradePartnerID,  a.StyleColorID,  b.StyleID, b.StyleNo,  
		b.Description, b.SizeClass, b.DevelopmentId
	FROM  dbo.pSampleRequestTrade a WITH(NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH(NOLOCK)  ON a.StyleID=  b.StyleID 
	WHERE a.TradePartnerID = @TradePartnerId  
		AND a.SampleRequestShare = 1 
	ORDER BY a.CDate
  
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_StyleMaterialDimensionSummary_SELECT]'
GO

CREATE PROCEDURE dbo.spx_StyleMaterialDimensionSummary_SELECT(
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT 
)
AS 


SELECT '<img src="../System/Control/ImageStream.ashx?L=0&Comp=100&S=100&V=' + 
	CAST(a.MaterialImageVersion AS NVARCHAR(10)) + '&IID=' + CAST(a.MaterialImageID AS NVARCHAR(40)) + '" />' AS ImagePath, a.*
FROM pStyleMaterials a WITH(NOLOCK)
WHERE a.StyleID = @StyleID 
	AND a.StyleSet = @StyleSet
ORDER BY a.MainMaterial DESC, a.MaterialType, a.MaterialSort, a.MaterialNo 

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_StyleQuoteItem_SELECT]'
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteItem_SELECT](
	@StyleQuoteItemID UNIQUEIDENTIFIER
)
AS

	
	IF (SELECT StyleSeasonYearID
		FROM dbo.pStyleQuoteItem  WITH(NOLOCK) WHERE StyleQuoteItemID = @StyleQuoteItemID ) IS NULL 
	BEGIN 
		SELECT a.StyleQuoteItemID, a.StyleQuoteItemNo, a.StyleQuoteID, a.StyleDevelopmentID, a.StyleQuoteItemApprovedDate,
			a.StyleID, a.StyleQuoteTradePartnerID, a.StyleCostingID, a.StyleCostingType, a.StyleQuoteItemApprovedBy, 
			a.TradePartnerID, a.TradePartnerVendorID, a.StyleQuoteItemCustomField25, a.StyleQuoteItemNotes, a.StyleQuoteItemShare,
			a.StyleQuoteItemStatusId, a.StyleQuoteVariationId, a.StyleCostingFreightTypeID, a.StyleQuoteVariationId, 
			a.CDate, a.MDate, a.CUser, a.MUser,
			b.StyleSeasonYearID
		FROM dbo.pStyleQuoteItem a WITH(NOLOCK)
			LEFT OUTER JOIN dbo.pStyleSourcing b WITH(NOLOCK)  ON a.StyleSourcingID = b.StyleSourcingID 
		WHERE a.StyleQuoteItemID = @StyleQuoteItemID
		
	END 
	ELSE 
	BEGIN

		SELECT StyleQuoteItemID, StyleQuoteItemNo, StyleQuoteID, StyleDevelopmentID, StyleQuoteItemApprovedDate,
			StyleID, StyleQuoteTradePartnerID, StyleCostingID, StyleCostingType, StyleQuoteItemApprovedBy, 
			TradePartnerID, TradePartnerVendorID, StyleQuoteItemCustomField25, StyleQuoteItemNotes, StyleQuoteItemShare,
			StyleQuoteItemStatusId, StyleQuoteVariationId, StyleCostingFreightTypeID, StyleQuoteVariationId, 
			StyleSeasonYearID, CDate, MDate, CUser, MUser
		FROM dbo.pStyleQuoteItem WITH(NOLOCK)
		WHERE StyleQuoteItemID = @StyleQuoteItemID	

	END 
	

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_MaterialWorkflowTemplateItems_SELECTED]'
GO

CREATE PROCEDURE dbo.spx_MaterialWorkflowTemplateItems_SELECTED(
	@MaterialRequestWorkflowTempID UNIQUEIDENTIFIER
)
AS

	SELECT b.MaterialRequestWorkflowID, b.MaterialRequestWorkflow 
    FROM pMaterialRequestWorkflowTemplateItem a WITH(NOLOCK)
		INNER JOIN pMaterialRequestWorkflow b WITH(NOLOCK) ON a.MaterialRequestWorkflowID = b.MaterialRequestWorkflowID 
    WHERE a.MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
    ORDER BY b.MaterialRequestWorkflowSort 
	

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_MaterialWorkflowTemplateItems_SELECT]'
GO

CREATE PROCEDURE dbo.spx_MaterialWorkflowTemplateItems_SELECT(
	@MaterialRequestWorkflowTempID UNIQUEIDENTIFIER
)
AS


	SELECT MaterialRequestWorkflowID, MaterialRequestWorkflow 
	FROM pMaterialRequestWorkflow WITH(NOLOCK)
	WHERE MaterialRequestWorkflowID NOT IN (
		SELECT MaterialRequestWorkflowID 
		FROM pMaterialRequestWorkflowTemplateItem WITH(NOLOCK)
		WHERE MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
		) 
	AND Active = 1
	ORDER BY MaterialRequestWorkflowSort
	

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_User_DesktopFolder_SELECT]'
GO


CREATE PROCEDURE [dbo].[spx_User_DesktopFolder_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 

CREATE TABLE #tmp(
	ROWID INT IDENTITY(1,1),
	DeskFolderId INT,
	TemplateItemValue NVARCHAR(200),
	TemplateID NVARCHAR(40),
	DeskFolderName NVARCHAR(200)
)

CREATE TABLE #template(
	ROWID INT IDENTITY(1,1),
	LinePlanTemplateID UNIQUEIDENTIFIER
)



INSERT INTO #tmp(DeskFolderId, DeskFolderName)
SELECT DeskFolderId, DeskFolderName 
FROM cDesktopFolder WITH(NOLOCK)
WHERE DeskFolderId <> 13  -- LinePlan


DECLARE 
	@sqlScript  NVARCHAR(MAX),
	@LinePlanTemplateID UNIQUEIDENTIFIER,
	@ROWID INT,
	@TOTAL INT
	


INSERT INTO #template	( LinePlanTemplateID)
SELECT LinePlanTemplateID FROM dbo.pLinePlanTemplate

SET @ROWID = 1
SELECT @TOTAL =  COUNT(*) FROM #template


WHILE @ROWID  <= @TOTAL
BEGIN
	SELECT @LinePlanTemplateID = LinePlanTemplateID FROM #template WHERE ROWID = @ROWID

	SELECT @sqlScript = ' INSERT #tmp(DeskFolderId, TemplateID, TemplateItemValue, DeskFolderName) SELECT 13, ''' +
	CAST(a.LinePlanTemplateID AS NVARCHAR(40)) + ''', '  + a.LinePlanAttributeValue +
	', ''' + b.LinePlanTemplateName  + ''' + '' - '' +  ' + a.LinePlanAttributeText +  '  FROM ' + a.LinePlanAttributeTable + ' ORDER BY '  +  a.LinePlanAttributeText
	FROM  pLinePlanTemplateItem  a
		INNER JOIN dbo.pLinePlanTemplate b ON b.LinePlanTemplateID = a.LinePlanTemplateID
	WHERE CAST(LinePlanTemplateItemSort AS INT) = '1' 
	AND a.LinePlanTemplateID = @LinePlanTemplateID

	PRINT @sqlScript 
	EXEC sp_executesql @sqlScript 	
	
	SET @ROWID = @ROWID + 1 

END 
	


SELECT * FROM #tmp
ORDER BY DeskFolderId, ROWID

DROP TABLE #tmp


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_MaterialRequest_TPVendorSearch_SELECT]'
GO


CREATE PROCEDURE dbo.spx_MaterialRequest_TPVendorSearch_SELECT(
	@TradePartnerID UNIQUEIDENTIFIER
)
AS

	SELECT '' AS TradePartnerVendorID, '' AS VendorName
	UNION
	SELECT CAST(TradePartnerVendorID AS NVARCHAR(40)), VendorName FROM dbo.uTradePartnerVendor a WITH(NOLOCK)
	WHERE a.TradePartnerID = @TradePartnerID
	
	
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_LinePlanIndex_SELECT]'
GO

CREATE PROCEDURE [dbo].[spx_LinePlanIndex_SELECT](
	@LinePlanID UNIQUEIDENTIFIER 
)
AS


SELECT  COUNT(*) 
FROM dbo.pLinePlanTemplateItem a WITH(NOLOCK)
	INNER JOIN pLineplan b WITH(NOLOCK) ON a.LinePlanTemplateID = b.LinePlanTemplateID 
WHERE b.LinePlanID = @LinePlanID

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_Material_Color_SELECT]'
GO

CREATE PROCEDURE dbo.spx_Material_Color_SELECT(
	@MaterialID UNIQUEIDENTIFIER
)
AS 

	SELECT a.MaterialColorID, b.ColorCode, b.ColorName, b.ColorPaletteCustom4 , b.ColorSource,
		a.MaterialColorImageID, a.MaterialColorImageVersion, b.ColorPaletteID, b.ColorFolderID
	FROM dbo.pMaterialColor a WITH(NOLOCK)
		INNER JOIN dbo.pColorPalette b WITH(NOLOCK)  ON a.ColorPaletteID = b.ColorPaletteID
	WHERE a.MaterialID = @MaterialID
	
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_TradePartnerVendor_Rate_INSERT]'
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[spx_TradePartnerVendor_Rate_INSERT] (
@TradePartnerVendorRateID UNIQUEIDENTIFIER,
@NewTradePartnerVendorRateID UNIQUEIDENTIFIER,
@FieldsSelected NVARCHAR(4000) ,
@CUser NVARCHAR(200), 
@CDate DATETIME 
)
AS 
	
DECLARE @TradePartnerVendorID UNIQUEIDENTIFIER

SELECT @TradePartnerVendorID = TradePartnerVendorID  
FROM pTradePartnerVendorRate WITH(NOLOCK)
WHERE TradePartnerVendorRateID = @TradePartnerVendorRateID	
	
INSERT INTO  pTradePartnerVendorRate ( TradePartnerVendorRateID , TradePartnerVendorID, CUser, CDate, MUser, MDate )
VALUES (@NewTradePartnerVendorRateID, @TradePartnerVendorID, @CUser, @CDate, @CUser, @CDate )  
	

/***
** Copy all Items
***/	
DECLARE @SQL AS NVARCHAR(4000)
IF LEN (@FieldsSelected) > 0 
BEGIN 
	SET @SQL = 'INSERT INTO pTradePartnerVendorRateItem( TradepartnerVendorRateItemID, TradePartnerVendorRateID, StyleCategoryID, 
	CDate, CUser, MUser, MDate, ' +  @FieldsSelected + ') 
	SELECT NewID(), ''' + CAST(@NewTradePartnerVendorRateID AS NVARCHAR(40))  + ''', StyleCategoryID, '''  +
	CAST(@CDate AS NVARCHAR(20))  + ''', ''' +  @CUser + ''',  ''' +  @CUser + ''',  ''' +  CAST(@CDate AS NVARCHAR(20)) + ''', ' + @FieldsSelected + '
	FROM pTradePartnerVendorRateItem WITH(NOLOCK) WHERE TradePartnerVendorRateID =  '''  + CAST(@TradePartnerVendorRateID  AS NVARCHAR(40)) + ''' '
END 
ELSE 
BEGIN
	SET @SQL = 'INSERT INTO pTradePartnerVendorRateItem( TradepartnerVendorRateItemID, TradePartnerVendorRateID, StyleCategoryID, 
	CDate, CUser, MUser, MDate )   
	SELECT NewID(), ''' + CAST(@NewTradePartnerVendorRateID AS NVARCHAR(40))  + ''', StyleCategoryID, '''  +
	CAST(@CDate AS NVARCHAR(20))  + ''', ''' +  @CUser + ''',  ''' +  @CUser + ''',  ''' +  CAST(@CDate AS NVARCHAR(20)) + '''  
	FROM pTradePartnerVendorRateItem WITH(NOLOCK) WHERE TradePartnerVendorRateID =  '''  + CAST(@TradePartnerVendorRateID  AS NVARCHAR(40)) + ''' '
END 


EXECUTE sp_executesql @SQL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[rpx_Style_SeasonalMaterialColorway_SELECT]'
GO


/*
Comments:

#01 - Ryan Cabanas - 6/25/2008 - Feature #313

	Burberry wants to see the SAP Code in the Colorway report.  There is a custom "BB_Style_MaterialColorway_Body_LLT.rdl" that is going to
use this SAP Code.  Just needed to add that field to this query.  There were 3 changes to this procedure.  Parts A, B, and C.  Field "SAPCode"
was added to these three sections.  A - was to add the field to the temp table.  B - was to add the field to the INSERT and SELECT portion
of the statement.  C - was to select the field in the final SELECT statement.

#02 - Ryan Cabanas - 1/15/2009
	When an a chip was added from the Image Folder, the 'ColorName' field was getting updated with the Image Number.  Clay isn't sure why it
was set up this way, but he said it shouldn't be this way.  I've commented it out here.

#03 - Ryan Cabanas - June 8, 2009
	This new procedure has been created 'rpx_Style_SeasonalMaterialColorway_SELECT' for the new Seasonal Colorway
feature that we now have.

#04 - Ryan Cabanas - September 28, 2009
	Need to add new fields to the temp table to hold the sort values that are used so that sorting can be
worked with later when creating the Row and Column values.

#05 - Ryan Cabanas - September 28, 2009
	Create a couple of temp table to handle sorting for the materials and the colors.  These will be used
to do proper sorting at the final SELECT.  Commented out the old sorting in the initial INSERT/SELECT.

#06 - Ryan Cabanas - September 28, 2009
	Need to add a 'Group Color Column' that will keep the colors together in the report as the priority.
Also need to do this for Landscape reports versus Portrait reports.

#07 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.

#08 - Ryan Cabanas - September 23, 2009
	Replace the old color image string with the new color image string using function.
Deleted old code.
*/




ALTER PROCEDURE [dbo].[rpx_Style_SeasonalMaterialColorway_SELECT]  
(
	@StyleID AS varchar(255), 	
	@StyleSet AS int,
	@SeasonYearID varchar(255)	--Comment #03
)
AS



--/*Testing.*/
--BEGIN
--	DECLARE @StyleID varchar(255)
--	DECLARE @StyleSet int
--	DECLARE @SeasonYearID varchar(255)
--	SET @StyleID = 'f5bc96b7-5dea-4a2b-936b-f8bdea47229e'
--	SET @StyleSet = 1
--	SET @SeasonYearID = 'B2965D2D-2AE5-4B8D-9B77-477728946DD9'
--END




/*****************/
/*Comment #01 - A*/
/*****************/
--Create temp table.
CREATE TABLE #tempTable
(
	TableRow int identity(0,1)
	,MaterialDescription varchar(255)
	,StyleMaterialId varchar(50)
	,Placement nvarchar(1000)
	,MainColor varchar(255)
	,SAPCode varchar(50)
	,Qty varchar(18)
	,MaterialSize varchar(200)
	,ColorName varchar(150)
	,ColorCode varchar(50)
	,FilePath varchar(255)
	,MaterialColorNote nvarchar(1000)
	,MaterialColorImageID varchar(50)
	,MaterialColorImageVersion int
	,StyleColorSort nvarchar(10)		--Comment #04
	,StyleColorName nvarchar(200)		--Comment #04
	,StyleColorID nvarchar(200)			--Comment #04
	,MainMaterial int					--Comment #04
	,MaterialType int					--Comment #04
	,MaterialSort varchar(5)			--Comment #04
	,MaterialNo nvarchar(50)			--Comment #04
	,Row int							--Comment #04
	,[Column] int						--Comment #04
	,GroupColorColumnLandscape int		--Comment #06
	,GroupColorColumnPortrait int		--Comment #06
)

--Comment #05
CREATE TABLE #tempMaterialSort(
	TableRow int identity(0,1)
	,StyleMaterialId varchar(50)
	,MainMaterial int
	,MaterialType int
	,MaterialSort varchar(5)
	,MaterialNo nvarchar(50)
)

--Comment #05
CREATE TABLE #tempColorSort(
	TableRow int identity(0,1)
	,MainColor varchar(50)
	,StyleColorSort nvarchar(10)
	,StyleColorName nvarchar(200)
	,StyleColorID nvarchar(200)
	,GroupColorColumnLandscape int	--Comment #06
	,GroupColorColumnPortrait int	--Comment #06
)


/*****************/
/*Comment #01 - B*/
/*****************/
--Get the material colorway squares and put them in the temp table.
INSERT INTO #tempTable(
	MaterialDescription
	,StyleMaterialId
	,Placement
	,MainColor
	,SAPCode
	,Qty
	,MaterialSize
	,ColorName
	,ColorCode
	,FilePath
	,MaterialColorNote
	,MaterialColorImageID
	,MaterialColorImageVersion
	,StyleColorSort			--Comment #04
	,StyleColorName			--Comment #04
	,StyleColorID			--Comment #04
	,MainMaterial			--Comment #04
	,MaterialType			--Comment #04
	,MaterialSort			--Comment #04
	,MaterialNo				--Comment #04
)
SELECT
	('(' + pStyleMaterials.MaterialNo + ') ' + pStyleMaterials.MaterialName) AS MaterialDescription
	,CAST(pStyleMaterials.StyleMaterialId AS varchar(50)) AS StyleMaterialId
	,pStyleMaterials.Placement
	,isnull('(' + pStyleColorway.StyleColorNo + ') ','') +  pStyleColorway.MainColor AS MainColor
	,pStyleColorway.SAPCode
	,pStyleMaterials.Qty
	,pStyleMaterials.MaterialSize
	,pMaterialColor.ColorName
	,pMaterialColor.ColorCode
	,dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID) AS FilePath	--Comment #08
	,pMaterialColor.MaterialColorNote
	,pMaterialColor.MaterialColorImageID
	,pMaterialColor.MaterialColorImageVersion
	,pStyleColorway.Sort AS StyleColorSort						--Comment #04
	,pStyleColorway.StyleColorName								--Comment #04
	,CAST(pStyleColorway.StyleColorID AS nvarchar(200))			--Comment #04
	,pStyleMaterials.MainMaterial								--Comment #04
	,pStyleMaterials.MaterialType								--Comment #04
	,pStyleMaterials.MaterialSort								--Comment #04
	,pStyleMaterials.MaterialNo									--Comment #04
FROM pStyleColorway
	LEFT OUTER JOIN pStyleMaterials ON	pStyleColorway.StyleID = pStyleMaterials.StyleID
										AND pStyleMaterials.Colorway = 1
	LEFT OUTER JOIN pStyleColorwayItem ON	pStyleMaterials.StyleMaterialID = pStyleColorwayItem.StyleMaterialID
											AND pStyleMaterials.StyleSet = pStyleColorwayItem.StyleSet
											AND pStyleColorway.StyleColorID = pStyleColorwayItem.StyleColorID
	LEFT OUTER JOIN pMaterialColor ON pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
	INNER JOIN pStyleColorwaySeasonYear ON	pStyleColorway.StyleID = pStyleColorwaySeasonYear.StyleID						--Comment #03
											AND pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID		--Comment #03
	INNER JOIN pStyleSeasonYear ON	pStyleColorwaySeasonYear.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID			--Comment #03
									AND pStyleColorwaySeasonYear.StyleID = pStyleSeasonYear.StyleID							--Comment #03
WHERE pStyleColorway.StyleID = @StyleID
	AND pStyleColorwayItem.StyleSet = @StyleSet
	AND pStyleSeasonYear.SeasonYearID = @SeasonYearID
--ORDER BY pStyleColorway.Sort				--Comment #05
--	,pStyleColorway.StyleColorName			--Comment #05
--	,pStyleColorway.StyleColorID			--Comment #05
--	,pStyleMaterials.MainMaterial DESC		--Comment #05
--	,pStyleMaterials.MaterialType			--Comment #05
--	,pStyleMaterials.MaterialSort			--Comment #05
--	,pStyleMaterials.MaterialNo				--Comment #05

--Update the temp folder for the chips that are images from the Image folder.
UPDATE #tempTable
SET FilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #07
--	ColorName = '(' + hImage.ImageNo + ')'  --Comment #02
FROM #tempTable
	INNER JOIN hImage ON	(#tempTable.MaterialColorImageID = hImage.ImageID
							AND #tempTable.MaterialColorImageVersion = hImage.Version)


--Update the temp table to include the "Die To Match (DTM)" feature request.
UPDATE #tempTable
SET ColorCode = ''
WHERE (ColorName IS NULL)
	AND (ColorCode IS NULL)
	AND (FilePath IS NULL)


--Comment #05
BEGIN
	/*Get the materials and put them in temp table to sort.*/
	INSERT INTO #tempMaterialSort(
		StyleMaterialId
		,MainMaterial
		,MaterialType
		,MaterialSort
		,MaterialNo
	)
	SELECT
		StyleMaterialId
		,MainMaterial
		,MaterialType
		,MaterialSort
		,MaterialNo
	FROM #tempTable
	GROUP BY
		StyleMaterialId
		,MainMaterial
		,MaterialType
		,MaterialSort
		,MaterialNo
	ORDER BY 
		MainMaterial DESC
		,MaterialType
		,MaterialSort
		,MaterialNo

	/*Get the colors and put them in temp table to sort.*/
	INSERT INTO #tempColorSort(
		MainColor
		,StyleColorSort
		,StyleColorName
		,StyleColorID
	)
	SELECT
		MainColor
		,StyleColorSort
		,StyleColorName
		,StyleColorID
	FROM #tempTable
	GROUP BY
		MainColor
		,StyleColorSort
		,StyleColorName
		,StyleColorID
	ORDER BY 
		StyleColorSort
		,StyleColorName
		,StyleColorID

	--Comment #06
	/*Declare variables.*/
	DECLARE @TotalCount int
	DECLARE @RowCounter int
	DECLARE @GroupCountLandscape int
	DECLARE @GroupCutOffLandscape int
	DECLARE @GroupCountPortrait int
	DECLARE @GroupCutOffPortrait int

	--Comment #06
	/*Get counts.*/
	SELECT @TotalCount = COUNT(*) from #tempColorSort
	SET @RowCounter = 0
	SET @GroupCountLandscape = 0
	SET @GroupCutOffLandscape = 6
	SET @GroupCountPortrait = 0
	SET @GroupCutOffPortrait = 3

	--Comment #06
	/*Loop to set 'Group Color Column' values.*/
	WHILE(@RowCounter < @TotalCount)
		BEGIN
			/*Update the 'Group Color Column' value.*/
			UPDATE #tempColorSort
			SET GroupColorColumnLandscape = @GroupCountLandscape
				,GroupColorColumnPortrait = @GroupCountPortrait
			WHERE TableRow = @RowCounter

			/*Up 'Group Color Column' count, if necessary, for landscape.*/
			IF(@RowCounter % @GroupCutOffLandscape = @GroupCutOffLandscape - 1)
				BEGIN
					SET @GroupCountLandscape = @GroupCountLandscape + 1
				END

			/*Up 'Group Color Column' count, if necessary, for portrait.*/
			IF(@RowCounter % @GroupCutOffPortrait = @GroupCutOffPortrait - 1)
				BEGIN
					SET @GroupCountPortrait = @GroupCountPortrait + 1
				END

			/*Up row counter.*/
			SET @RowCounter = @RowCounter + 1
		END

	/*Update main temp table with Row and Column values.*/
	UPDATE #tempTable
	SET Row = #tempMaterialSort.TableRow
		,[Column] = #tempColorSort.TableRow
		,GroupColorColumnLandscape = #tempColorSort.GroupColorColumnLandscape
		,GroupColorColumnPortrait = #tempColorSort.GroupColorColumnPortrait
	FROM #tempTable
		INNER JOIN #tempMaterialSort	ON	#tempTable.StyleMaterialID = #tempMaterialSort.StyleMaterialID
		INNER JOIN #tempColorSort	ON	#tempTable.MainColor = #tempColorSort.MainColor
END


/*****************/
/*Comment #01 - C*/
/*****************/
--Get the desired columns from the original temp table.
SELECT
	Row		--Comment #05
	,[Column]	--Comment #05
	,GroupColorColumnLandscape	--Comment #06
	,GroupColorColumnPortrait	--Comment #06
	,MaterialDescription
	,StyleMaterialId
	,Placement
	,MainColor
	,SAPCode
	,Qty
	,MaterialSize
	,ColorName
	,ColorCode
	,FilePath
	,MaterialColorNote
FROM #tempTable
ORDER BY
	Row		--Comment #05
	,[Column]	--Comment #05


/*
SELECT *
FROM dbo.pStyleColorway INNER JOIN
    dbo.pStyleColorwayItem ON dbo.pStyleColorway.StyleColorID = dbo.pStyleColorwayItem.StyleColorID INNER JOIN
    dbo.pStyleMaterials ON dbo.pStyleColorwayItem.StyleMaterialID = dbo.pStyleMaterials.StyleMaterialID INNER JOIN
    dbo.pMaterialColor ON dbo.pStyleColorwayItem.MaterialColorID = dbo.pMaterialColor.MaterialColorID
*/

--Drop the Temp Table.
DROP TABLE #tempTable
DROP TABLE #tempMaterialSort	--Comment #05
DROP TABLE #tempColorSort		--Comment #05
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[rpx_SampleRequestSubmit_SeasonalMaterialColorway_SELECT]'
GO

/*
Comments:

#01 - Ryan Cabanas - 6/25/2008 - Feature #313

	Burberry wants to see the SAP Code in the Colorway report.  There is a custom "BB_Style_MaterialColorway_Body_LLT.rdl" that is going to
use this SAP Code.  Just needed to add that field to this query.  There were 3 changes to this procedure.  Parts A, B, and C.  Field "SAPCode"
was added to these three sections.  A - was to add the field to the temp table.  B - was to add the field to the INSERT and SELECT portion
of the statement.  C - was to select the field in the final SELECT statement.

#02 - Ryan Cabanas - 1/15/2009
	When an a chip was added from the Image Folder, the 'ColorName' field was getting updated with the Image Number.  Clay isn't sure why it
was set up this way, but he said it shouldn't be this way.  I've commented it out here.

#03 - Ryan Cabanas - June 8, 2009
	This new procedure has been created 'rpx_Style_SeasonalMaterialColorway_SELECT' for the new Seasonal Colorway
feature that we now have.

#04 - Ryan Cabanas - September 28, 2009
	Need to add new fields to the temp table to hold the sort values that are used so that sorting can be
worked with later when creating the Row and Column values.

#05 - Ryan Cabanas - September 28, 2009
	Create a couple of temp table to handle sorting for the materials and the colors.  These will be used
to do proper sorting at the final SELECT.  Commented out the old sorting in the initial INSERT/SELECT.

#06 - Ryan Cabanas - September 28, 2009
	Need to add a 'Group Color Column' that will keep the colors together in the report as the priority.
Also need to do this for Landscape reports versus Portrait reports.

#07 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.

#08 - Ryan Cabanas - September 23, 2009
	Replace the old color image string with the new color image string using function.
Deleted old code.
*/


ALTER PROCEDURE [dbo].[rpx_SampleRequestSubmit_SeasonalMaterialColorway_SELECT]
(
	@SampleRequestSubmitId NVARCHAR(50)
)
AS


--/*Testing.*/
--BEGIN
--	DECLARE @SampleRequestSubmitId NVARCHAR(50)
--	SET @SampleRequestSubmitId = '8BB4C4BB-3401-4617-B367-64A0F8126066'
--END


/****************************************************************/
/*Get some initial variables to perform the remaining logic.	*/
/****************************************************************/
--Variables.
DECLARE @StyleID varchar(255)
DECLARE @StyleSet int
DECLARE @SeasonYearID varchar(255)

DECLARE @SampleRequestTradeId NVARCHAR(50)
DECLARE @StyleSeasonYearId NVARCHAR(50)

--Get @StyleId, @StyleSet, and @SampleRequestTradeId.
SELECT @StyleId = StyleId
	,@StyleSet = StyleSet
	,@SampleRequestTradeId = SampleRequestTradeId
FROM pSampleRequestSubmit
WHERE SampleRequestSubmitId = @SampleRequestSubmitId

--Get @StyleSeasonYearId.
SELECT @StyleSeasonYearId = StyleSeasonYearId
FROM pSampleRequestTrade
WHERE SampleRequestTradeId = @SampleRequestTradeId

--Get @SeasonYearId.
SELECT @SeasonYearID = SeasonYearID
FROM pStyleSeasonYear
WHERE StyleSeasonYearId = @StyleSeasonYearId


/*****************/
/*Comment #01 - A*/
/*****************/
--Create temp table.
CREATE TABLE #tempTable
(
	TableRow int identity(0,1)
	,MaterialDescription varchar(255)
	,StyleMaterialId varchar(50)
	,Placement nvarchar(1000)
	,MainColor varchar(255)
	,SAPCode varchar(50)
	,Qty varchar(18)
	,MaterialSize varchar(200)
	,ColorName varchar(150)
	,ColorCode varchar(50)
	,FilePath varchar(255)
	,MaterialColorNote nvarchar(1000)
	,MaterialColorImageID varchar(50)
	,MaterialColorImageVersion int
	,StyleColorSort nvarchar(10)		--Comment #04
	,StyleColorName nvarchar(200)		--Comment #04
	,StyleColorID nvarchar(200)			--Comment #04
	,MainMaterial int					--Comment #04
	,MaterialType int					--Comment #04
	,MaterialSort varchar(5)			--Comment #04
	,MaterialNo nvarchar(50)			--Comment #04
	,Row int							--Comment #04
	,[Column] int						--Comment #04
	,GroupColorColumnLandscape int		--Comment #06
	,GroupColorColumnPortrait int		--Comment #06
)

--Comment #05
CREATE TABLE #tempMaterialSort(
	TableRow int identity(0,1)
	,StyleMaterialId varchar(50)
	,MainMaterial int
	,MaterialType int
	,MaterialSort varchar(5)
	,MaterialNo nvarchar(50)
)

--Comment #05
CREATE TABLE #tempColorSort(
	TableRow int identity(0,1)
	,MainColor varchar(50)
	,StyleColorSort nvarchar(10)
	,StyleColorName nvarchar(200)
	,StyleColorID nvarchar(200)
	,GroupColorColumnLandscape int	--Comment #06
	,GroupColorColumnPortrait int	--Comment #06
)


/*****************/
/*Comment #01 - B*/
/*****************/
--Get the material colorway squares and put them in the temp table.
INSERT INTO #tempTable(
	MaterialDescription
	,StyleMaterialId
	,Placement
	,MainColor
	,SAPCode
	,Qty
	,MaterialSize
	,ColorName
	,ColorCode
	,FilePath
	,MaterialColorNote
	,MaterialColorImageID
	,MaterialColorImageVersion
	,StyleColorSort			--Comment #04
	,StyleColorName			--Comment #04
	,StyleColorID			--Comment #04
	,MainMaterial			--Comment #04
	,MaterialType			--Comment #04
	,MaterialSort			--Comment #04
	,MaterialNo				--Comment #04
)
SELECT
	('(' + pStyleMaterials.MaterialNo + ') ' + pStyleMaterials.MaterialName) AS MaterialDescription
	,CAST(pStyleMaterials.StyleMaterialId AS varchar(50)) AS StyleMaterialId
	,pStyleMaterials.Placement
	,isnull('(' + pStyleColorway.StyleColorNo + ') ','') +  pStyleColorway.MainColor AS MainColor
	,pStyleColorway.SAPCode
	,pStyleMaterials.Qty
	,pStyleMaterials.MaterialSize
	,pMaterialColor.ColorName
	,pMaterialColor.ColorCode
	,dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID) AS FilePath	--Comment #08
	,pMaterialColor.MaterialColorNote
	,pMaterialColor.MaterialColorImageID
	,pMaterialColor.MaterialColorImageVersion
	,pStyleColorway.Sort AS StyleColorSort						--Comment #04
	,pStyleColorway.StyleColorName								--Comment #04
	,CAST(pStyleColorway.StyleColorID AS nvarchar(200))			--Comment #04
	,pStyleMaterials.MainMaterial								--Comment #04
	,pStyleMaterials.MaterialType								--Comment #04
	,pStyleMaterials.MaterialSort								--Comment #04
	,pStyleMaterials.MaterialNo									--Comment #04
FROM pStyleColorway
	LEFT OUTER JOIN pStyleMaterials ON	pStyleColorway.StyleID = pStyleMaterials.StyleID
										AND pStyleMaterials.Colorway = 1
	LEFT OUTER JOIN pStyleColorwayItem ON	pStyleMaterials.StyleMaterialID = pStyleColorwayItem.StyleMaterialID
											AND pStyleMaterials.StyleSet = pStyleColorwayItem.StyleSet
											AND pStyleColorway.StyleColorID = pStyleColorwayItem.StyleColorID
	LEFT OUTER JOIN pMaterialColor ON pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
	INNER JOIN pStyleColorwaySeasonYear ON	pStyleColorway.StyleID = pStyleColorwaySeasonYear.StyleID						--Comment #03
											AND pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID		--Comment #03
	INNER JOIN pStyleSeasonYear ON	pStyleColorwaySeasonYear.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID			--Comment #03
									AND pStyleColorwaySeasonYear.StyleID = pStyleSeasonYear.StyleID							--Comment #03
WHERE pStyleColorway.StyleID = @StyleID
	AND pStyleColorwayItem.StyleSet = @StyleSet
	AND pStyleSeasonYear.SeasonYearID = @SeasonYearID
--ORDER BY pStyleColorway.Sort				--Comment #05
--	,pStyleColorway.StyleColorName			--Comment #05
--	,pStyleColorway.StyleColorID			--Comment #05
--	,pStyleMaterials.MainMaterial DESC		--Comment #05
--	,pStyleMaterials.MaterialType			--Comment #05
--	,pStyleMaterials.MaterialSort			--Comment #05
--	,pStyleMaterials.MaterialNo				--Comment #05

--Update the temp folder for the chips that are images from the Image folder.
UPDATE #tempTable
SET FilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #07
--	ColorName = '(' + hImage.ImageNo + ')'  --Comment #02
FROM #tempTable
	INNER JOIN hImage ON	(#tempTable.MaterialColorImageID = hImage.ImageID
							AND #tempTable.MaterialColorImageVersion = hImage.Version)


--Update the temp table to include the "Die To Match (DTM)" feature request.
UPDATE #tempTable
SET ColorCode = ''
WHERE (ColorName IS NULL)
	AND (ColorCode IS NULL)
	AND (FilePath IS NULL)


--Comment #05
BEGIN
	/*Get the materials and put them in temp table to sort.*/
	INSERT INTO #tempMaterialSort(
		StyleMaterialId
		,MainMaterial
		,MaterialType
		,MaterialSort
		,MaterialNo
	)
	SELECT
		StyleMaterialId
		,MainMaterial
		,MaterialType
		,MaterialSort
		,MaterialNo
	FROM #tempTable
	GROUP BY
		StyleMaterialId
		,MainMaterial
		,MaterialType
		,MaterialSort
		,MaterialNo
	ORDER BY 
		MainMaterial DESC
		,MaterialType
		,MaterialSort
		,MaterialNo

	/*Get the colors and put them in temp table to sort.*/
	INSERT INTO #tempColorSort(
		MainColor
		,StyleColorSort
		,StyleColorName
		,StyleColorID
	)
	SELECT
		MainColor
		,StyleColorSort
		,StyleColorName
		,StyleColorID
	FROM #tempTable
	GROUP BY
		MainColor
		,StyleColorSort
		,StyleColorName
		,StyleColorID
	ORDER BY 
		StyleColorSort
		,StyleColorName
		,StyleColorID

	--Comment #06
	/*Declare variables.*/
	DECLARE @TotalCount int
	DECLARE @RowCounter int
	DECLARE @GroupCountLandscape int
	DECLARE @GroupCutOffLandscape int
	DECLARE @GroupCountPortrait int
	DECLARE @GroupCutOffPortrait int

	--Comment #06
	/*Get counts.*/
	SELECT @TotalCount = COUNT(*) from #tempColorSort
	SET @RowCounter = 0
	SET @GroupCountLandscape = 0
	SET @GroupCutOffLandscape = 6
	SET @GroupCountPortrait = 0
	SET @GroupCutOffPortrait = 3

	--Comment #06
	/*Loop to set 'Group Color Column' values.*/
	WHILE(@RowCounter < @TotalCount)
		BEGIN
			/*Update the 'Group Color Column' value.*/
			UPDATE #tempColorSort
			SET GroupColorColumnLandscape = @GroupCountLandscape
				,GroupColorColumnPortrait = @GroupCountPortrait
			WHERE TableRow = @RowCounter

			/*Up 'Group Color Column' count, if necessary, for landscape.*/
			IF(@RowCounter % @GroupCutOffLandscape = @GroupCutOffLandscape - 1)
				BEGIN
					SET @GroupCountLandscape = @GroupCountLandscape + 1
				END

			/*Up 'Group Color Column' count, if necessary, for portrait.*/
			IF(@RowCounter % @GroupCutOffPortrait = @GroupCutOffPortrait - 1)
				BEGIN
					SET @GroupCountPortrait = @GroupCountPortrait + 1
				END

			/*Up row counter.*/
			SET @RowCounter = @RowCounter + 1
		END

	/*Update main temp table with Row and Column values.*/
	UPDATE #tempTable
	SET Row = #tempMaterialSort.TableRow
		,[Column] = #tempColorSort.TableRow
		,GroupColorColumnLandscape = #tempColorSort.GroupColorColumnLandscape
		,GroupColorColumnPortrait = #tempColorSort.GroupColorColumnPortrait
	FROM #tempTable
		INNER JOIN #tempMaterialSort	ON	#tempTable.StyleMaterialID = #tempMaterialSort.StyleMaterialID
		INNER JOIN #tempColorSort	ON	#tempTable.MainColor = #tempColorSort.MainColor
END


/*****************/
/*Comment #01 - C*/
/*****************/
--Get the desired columns from the original temp table.
SELECT
	Row		--Comment #05
	,[Column]	--Comment #05
	,GroupColorColumnLandscape	--Comment #06
	,GroupColorColumnPortrait	--Comment #06
	,MaterialDescription
	,StyleMaterialId
	,Placement
	,MainColor
	,SAPCode
	,Qty
	,MaterialSize
	,ColorName
	,ColorCode
	,FilePath
	,MaterialColorNote
FROM #tempTable
ORDER BY
	Row		--Comment #05
	,[Column]	--Comment #05


/*
SELECT *
FROM dbo.pStyleColorway INNER JOIN
    dbo.pStyleColorwayItem ON dbo.pStyleColorway.StyleColorID = dbo.pStyleColorwayItem.StyleColorID INNER JOIN
    dbo.pStyleMaterials ON dbo.pStyleColorwayItem.StyleMaterialID = dbo.pStyleMaterials.StyleMaterialID INNER JOIN
    dbo.pMaterialColor ON dbo.pStyleColorwayItem.MaterialColorID = dbo.pMaterialColor.MaterialColorID
*/

--Drop the Temp Table.
DROP TABLE #tempTable
DROP TABLE #tempMaterialSort	--Comment #05
DROP TABLE #tempColorSort		--Comment #05
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_StyleSpec_SELECT]'
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spx_StyleSpec_SELECT]
(@StyleID uniqueidentifier,
@StyleSet int)

AS 


SELECT SpecID, StyleID, POMTempItemID, POMLibraryID, POMTempID, StyleSet, POM, PointMeasur, TOL, TOLN, Spec, Proto0, Proto1, Proto2, Proto3, Proto4, 
Proto5, Proto6, Proto7, Proto8, Proto9, Proto10, Proto11, Grade0, Grade1, Grade2, Grade3, Grade4, Grade5, Grade6, Grade7, Grade8, Grade9, Grade10, 
Grade11, Size0, Size1, Size2, Size3, Size4, Size5, Size6, Size7, Size8, Size9, Size10, Size11, CDate, CUser, MDate, MUser, Change, Sort, 
HowToMeasurText, HowToMeasurImage, Critical, '(' + POM + ') ' + PointMeasur AS FullSpec
FROM dbo.pStyleSpec WITH (NOLOCK)
WHERE     (StyleID = @StyleID) AND (StyleSet = @StyleSet) 
ORDER BY Sort, POM, PointMeasur

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_Body_Model_Piece_INSERT]'
GO
SET QUOTED_IDENTIFIER OFF
GO

ALTER procedure [dbo].[spx_Body_Model_Piece_INSERT]
(
@ID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleSet int,
@CADDB varchar(50),
@Catalog varchar(50),
@Model_Code int
)
AS
BEGIN
DECLARE @strCADPiece nvarchar(max) 
Declare @strPiece nvarchar(max)


CREATE TABLE #tempTblPiece(
	[Piece_Code] [int]  NULL DEFAULT ((0)),
	[Piece_Name] [varchar](64)  NULL,
	[Last_Updated] [datetime] NULL,
	[IsActive] [int] NULL DEFAULT ((-1)),
	[IsLinked] [int] NULL DEFAULT ((0)),
	[ClassifierId] [int] NULL,
	[SystemId] [int] NULL,
	[Model_Code] [int] NULL DEFAULT ((0)),
	[Material_Code] [int] NULL,
	[Piece_Description] [varchar](510) NULL,

	[Piece_CrOpId] [varchar](100) NULL,
	[Piece_Create] [datetime] NULL,
	[Piece_RevOp1] [varchar](100) NULL,
	[Piece_Rev1] [datetime] NULL,
	[Piece_RevOp2] [varchar](100) NULL,
	[Piece_Rev2] [datetime] NULL,
	[Piece_Message] [varchar](510) NULL,
	[Piece_HPTable] [varchar](100) NULL,
	[Piece_Bias] [int] NULL DEFAULT ((0)),
	[Piece_Flip] [int] NULL DEFAULT ((0)),
	[Piece_Nap] [int] NULL DEFAULT ((0)),
	[Piece_Ign_Splice] [int] NULL DEFAULT ((0)),
	[Piece_Standard] [int] NULL,
	[Piece_Buffering] [int] NULL,
	[Piece_nSplits] [int] NULL,
	[Piece_Tilt_CW] [float] NULL,
	[Piece_DieBlock] [float] NULL,
	[Piece_Pri_XBlock] [float] NULL,
	[Piece_Pri_XBlkType] [int] NULL,
	[Piece_Pri_YBlock] [float] NULL,
	[Piece_Pri_YBlkType] [int] NULL,
	[Piece_Sec_XBlock] [float] NULL,
	[Piece_Sec_XBlkType] [int] NULL,
	[Piece_Sec_YBlock] [float] NULL,
	[Piece_Sec_YBlkType] [int] NULL,
	[Piece_XVariance] [float] NULL,
	[Piece_XVar_Type] [int] NULL,
	[Piece_YVariance] [float] NULL,
	[Piece_YVar_Type] [int] NULL,
	[Piece_nUnflipped] [int] NULL,
	[Piece_nOpposite] [int] NULL,
	[Piece_nFilpY] [int] NULL,
	[Piece_nFlipXY] [int] NULL,
	[Piece_IsMirror] [int] NULL DEFAULT ((0)),
	[Piece_Area] [float] NULL,
	[Piece_Perimeter] [float] NULL,
	[Piece_PreRotation] [float] NULL,
	[Piece_Image_SN] [int] NULL,
	[Piece_Image_Name] [varchar](100) NULL,
	[Piece_Comments] [text] NULL,
	[UserDefined1] [varchar](100) NULL,
	[UserDefined2] [varchar](100) NULL,
	[UserDefined3] [varchar](100) NULL,
	[UserDefined4] [varchar](100) NULL,
	[UserDefined5] [varchar](100) NULL,
	[Piece_Size] [varchar](64) NULL,
	[Piece_Tilt_CCW] [float] NULL,
	[Piece_CW_Type] [int] NULL,
	[Piece_CCW_Type] [int] NULL,
	[Piece_PreRotationType] [int] NULL,
	[PiecePosition] [int] NOT NULL DEFAULT ((0)),
	[mPiece_Area] [float] NULL,
	[mPiece_Perimeter] [float] NULL,
	[Piece_Category] [varchar](510) NULL,
	[Rule_Table_Name] [varchar](64) NULL)
	
SELECT @strPiece = 'INSERT INTO #tempTblPiece 
          ([Piece_Code]
           ,[Piece_Name]
           ,[Last_Updated]
           ,[IsActive]
           ,[IsLinked]
           ,[ClassifierId]
           ,[SystemId]
           ,[Model_Code]
           ,[Material_Code]
           ,[Piece_Description]
           ,[Piece_Category]
		   ,[Rule_Table_Name]
           ,[Piece_CrOpId]
           ,[Piece_Create]
           ,[Piece_RevOp1]
           ,[Piece_Rev1]
           ,[Piece_RevOp2]
           ,[Piece_Rev2]
           ,[Piece_Message]
           ,[Piece_HPTable]
           ,[Piece_Bias]
           ,[Piece_Flip]
           ,[Piece_Nap]
           ,[Piece_Ign_Splice]
           ,[Piece_Standard]
           ,[Piece_Buffering]
           ,[Piece_nSplits]
           ,[Piece_Tilt_CW]
           ,[Piece_DieBlock]
           ,[Piece_Pri_XBlock]
           ,[Piece_Pri_XBlkType]
           ,[Piece_Pri_YBlock]
           ,[Piece_Pri_YBlkType]
           ,[Piece_Sec_XBlock]
           ,[Piece_Sec_XBlkType]
           ,[Piece_Sec_YBlock]
           ,[Piece_Sec_YBlkType]
           ,[Piece_XVariance]
           ,[Piece_XVar_Type]
           ,[Piece_YVariance]
           ,[Piece_YVar_Type]
           ,[Piece_nUnflipped]
           ,[Piece_nOpposite]
           ,[Piece_nFilpY]
           ,[Piece_nFlipXY]
           ,[Piece_IsMirror]
           ,[Piece_Area]
           ,[Piece_Perimeter]
           ,[Piece_PreRotation]
           ,[Piece_Image_SN]
           ,[Piece_Image_Name]
           ,[Piece_Comments]
           ,[UserDefined1]
           ,[UserDefined2]
           ,[UserDefined3]
           ,[UserDefined4]
           ,[UserDefined5]
           ,[Piece_Size]
           ,[Piece_Tilt_CCW]
           ,[Piece_CW_Type]
           ,[Piece_CCW_Type]
           ,[Piece_PreRotationType]
           ,[PiecePosition]
           ,[mPiece_Area]
           ,[mPiece_Perimeter]          
           )' +
' SELECT [Piece_Code]
      ,[Piece_Name]
      ,[Last_Updated]
      ,[IsActive]
      ,[IsLinked]
      ,[ClassifierId]
      ,[SystemId]
      ,[Model_Code]
      ,[Material_Code]
      ,[Piece_Description]
      ,[Piece_Category]
      ,[Rule_Table_Name]
      ,[Piece_CrOpId]
      ,[Piece_Create]
      ,[Piece_RevOp1]
      ,[Piece_Rev1]
      ,[Piece_RevOp2]
      ,[Piece_Rev2]
      ,[Piece_Message]
      ,[Piece_HPTable]
      ,[Piece_Bias]
      ,[Piece_Flip]
      ,[Piece_Nap]
      ,[Piece_Ign_Splice]
      ,[Piece_Standard]
      ,[Piece_Buffering]
      ,[Piece_nSplits]
      ,[Piece_Tilt_CW]
      ,[Piece_DieBlock]
      ,[Piece_Pri_XBlock]
      ,[Piece_Pri_XBlkType]
      ,[Piece_Pri_YBlock]
      ,[Piece_Pri_YBlkType]
      ,[Piece_Sec_XBlock]
      ,[Piece_Sec_XBlkType]
      ,[Piece_Sec_YBlock]
      ,[Piece_Sec_YBlkType]
      ,[Piece_XVariance]
      ,[Piece_XVar_Type]
      ,[Piece_YVariance]
      ,[Piece_YVar_Type]
      ,[Piece_nUnflipped]
      ,[Piece_nOpposite]
      ,[Piece_nFilpY]
      ,[Piece_nFlipXY]
      ,[Piece_IsMirror]
      ,[Piece_Area]
      ,[Piece_Perimeter]
      ,[Piece_PreRotation]
      ,[Piece_Image_SN]
      ,[Piece_Image_Name]
      ,[Piece_Comments]
      ,[UserDefined1]
      ,[UserDefined2]
      ,[UserDefined3]
      ,[UserDefined4]
      ,[UserDefined5]
      ,[Piece_Size]
      ,[Piece_Tilt_CCW]
      ,[Piece_CW_Type]
      ,[Piece_CCW_Type]
      ,[Piece_PreRotationType]
      ,[PiecePosition]
      ,[mPiece_Area]
      ,[mPiece_Perimeter] FROM '
 +  @CADDB + '.' + @Catalog + 
 '.dbo.Cad_Piece_Details WHERE  Model_Code = ' + Convert(varchar(50),@Model_Code)

print @strPiece
Exec (@strPiece) 

--IF  (select Count(*) from dbo.pBodyPatternSheetPiece where Model_Code = @Model_Code) = 0
--Begin

INSERT INTO [dbo].[pBodyPatternSheetPiece]
 (StyleID,StyleSet,[Piece_Code],[Piece_Name],[Last_Updated],[Active],IsLinked,Model_Code,
[Material_Code],[Piece_Description],[Piece_Category],[Rule_Table_Name],[Piece_CrOpId],[Piece_Create],[Piece_RevOp1],[Piece_Rev1]
,[Piece_RevOp2],[Piece_Rev2],[Piece_Message],[Piece_HPTable],[Piece_Bias],[Piece_Flip],[Piece_Nap]
,[Piece_Ign_Splice] ,[Piece_Standard] ,[Piece_Buffering] ,[Piece_nSplits],[Piece_Tilt_CW],[Piece_DieBlock],[Piece_Pri_XBlock]
,[Piece_Pri_XBlkType],[Piece_Pri_YBlock],[Piece_Pri_YBlkType],[Piece_Sec_XBlock],[Piece_Sec_XBlkType]
,[Piece_Sec_YBlock],[Piece_Sec_YBlkType],[Piece_XVariance],[Piece_XVar_Type],[Piece_YVariance] ,[Piece_YVar_Type]
,[Piece_nUnflipped],[Piece_nOpposite],[Piece_nFilpY],[Piece_nFlipXY],[Piece_IsMirror],[Piece_Area]
,[Piece_Perimeter],[Piece_PreRotation],[Piece_Image_SN],[Piece_Image_Name],[Piece_Comments],[UserDefined1],[UserDefined2]
,[UserDefined3],[UserDefined4],[UserDefined5],[Piece_Size],[Piece_Tilt_CCW],[Piece_CW_Type],[Piece_CCW_Type],[Piece_PreRotationType]
,[PiecePosition],[mPiece_Area],[mPiece_Perimeter] , ImageID, ModelID ) 
           
SELECT  @StyleID, @StyleSet, [Piece_Code],[Piece_Name],[Last_Updated], 1 as active ,1 as Linked
, Model_Code,[Material_Code],[Piece_Description],[Piece_Category],[Rule_Table_Name],[Piece_CrOpId],[Piece_Create],[Piece_RevOp1],[Piece_Rev1]
,[Piece_RevOp2],[Piece_Rev2],[Piece_Message],[Piece_HPTable],[Piece_Bias],[Piece_Flip],[Piece_Nap]
,[Piece_Ign_Splice] ,[Piece_Standard] ,[Piece_Buffering] ,[Piece_nSplits],[Piece_Tilt_CW],[Piece_DieBlock],[Piece_Pri_XBlock]
,[Piece_Pri_XBlkType],[Piece_Pri_YBlock],[Piece_Pri_YBlkType],[Piece_Sec_XBlock],[Piece_Sec_XBlkType]
,[Piece_Sec_YBlock],[Piece_Sec_YBlkType],[Piece_XVariance],[Piece_XVar_Type],[Piece_YVariance] ,[Piece_YVar_Type]
,[Piece_nUnflipped],[Piece_nOpposite],[Piece_nFilpY],[Piece_nFlipXY],[Piece_IsMirror],[Piece_Area]
,[Piece_Perimeter],[Piece_PreRotation],[Piece_Image_SN],[Piece_Image_Name],[Piece_Comments],[UserDefined1],[UserDefined2]
,[UserDefined3],[UserDefined4],[UserDefined5],[Piece_Size],[Piece_Tilt_CCW],[Piece_CW_Type],[Piece_CCW_Type],[Piece_PreRotationType]
,[PiecePosition],[mPiece_Area],[mPiece_Perimeter] ,null as ImageID, @ID 
FROM #tempTblPiece  

Drop Table #tempTblPiece
END
---------------------------------------------------------------

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_Style_Model_Insert]'
GO

ALTER procedure [dbo].[spx_Style_Model_Insert] (
@ID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleSet int,
@CADDB varchar(50),
@Catalog varchar(50),
@Model_Code int,
@CUser nvarchar(200),
@CDate datetime
)
AS
Declare @Linked  int
Declare @strCADModel nvarchar(max)
Declare @strCADPiece nvarchar(max)
Declare @ImageID  UNIQUEIDENTIFIER 
Declare @pID UNIQUEIDENTIFIER 
DECLARE @BodyID  UNIQUEIDENTIFIER
Set @BodyID = null


BEGIN


IF not exists  (select * from dbo.pBodyPatternSheetModel where ID = @ID)
Set @Linked = 1


SELECT @strCADModel ='
INSERT INTO [pBodyPatternSheetModel]
           ([ID]
           ,[StyleID]
           ,[StyleSet]
           ,[Model_Code]
           ,[Model_Name]
           ,[Last_Updated]
           ,[Active]
           ,[IsLinkedBF]
           ,[IsLinked]
           ,[CDate]
           ,[CUser]
           ,[MUser]
           ,[MDate]
           ,[Marker_Code]
           ,[Model_Description]
           ,[Model_CrOpId]
           ,[Model_Create]
           ,[Model_RevOp1]
           ,[Model_Rev1]
           ,[Model_RevOp2]
           ,[Model_Rev2]
           ,[Model_GRTable]
           ,[Model_MTMFile]
           ,[Model_SAName]
           ,[Model_SYNTable]
           ,[Model_HPTable]
           ,[Model_SampleSize]
           ,[Model_nMaterials]
           ,[Model_nPieces]
           ,[Model_nSizes]
           ,[Model_Image_SN]
           ,[Model_Image_Name]
           ,[Model_Comments]
           ,[PreferMetric]
           ,[UserDefined1]
           ,[UserDefined2]
           ,[UserDefined3]
           ,[UserDefined4]
           ,[UserDefined5]
           ,[Total_Area]
           ,[LastCADRefresh]
           ,[PlotFileLocation]
           ,[NotchFile]
           ,[AnnotationFile]
           ,[StorageType])' + 
' SELECT '+  CHAR(39) + Convert(varchar(36),@ID) + CHAR(39) + ' as ID,'
 + CHAR(39) + Convert(varchar(36),@StyleID) + CHAR(39) 
+' as StyleID, ' + Convert(varchar(10),@StyleSet) + ' as StyleSet,[Model_Code]
 ,[Model_Name],[Last_Updated],1 as [Active], 0 as [IsLinkedBF], 1 as [IsLinked],' 
  + convert(nvarchar(50), CAST(@CDate AS DATETIME), 101) +' as [CDate],' 
+ CHAR(39) + Convert(varchar(36),@CUser) + CHAR(39) +' as [CUser],'
+ CHAR(39) + Convert(varchar(36),@CUser) + CHAR(39) + ' as [MUser],'
+ convert(nvarchar(50), CAST(@CDate AS DATETIME), 101)  + ' as [MDate]          
--,[ClassifierId],[SystemId]
,[Marker_Code],[Model_Description],[Model_CrOpId],[Model_Create]
,[Model_RevOp1],[Model_Rev1],[Model_RevOp2],[Model_Rev2],[Model_GRTable],[Model_MTMFile]
,[Model_SAName],[Model_SYNTable],[Model_HPTable],[Model_SampleSize],[Model_nMaterials],[Model_nPieces]
,[Model_nSizes],[Model_Image_SN],[Model_Image_Name],[Model_Comments],[PreferMetric],[UserDefined1]
,[UserDefined2],[UserDefined3],[UserDefined4],[UserDefined5],[Total_Area],[LastCADRefresh]
,[PlotFileLocation],[NotchFile],[AnnotationFile],[StorageType]' +

' FROM ' +  @CADDB + '.' + @Catalog + 
 '.dbo.Cad_Model_Details WHERE  Model_Code = ' + Convert(varchar(50),@Model_Code)
--print @strCADModel
--return
-- EXEC [spx_BodyPatternsheet_Model_Insert]'119c1d8e-b113-4677-ba0e-93b4c71e4026','d888c2ec-9ea0-460e-89fc-693930d8e780','[SIVA-PC]','[kellwood]','17610','siva nandigam','2010-10-04T11:49:41.253','siva nandigam','2010-10-04T11:49:41.253'
EXEC (@strCADModel)

Exec [spx_Body_Model_Piece_INSERT] @ID, @StyleID, @StyleSet, @CADDB,@Catalog,@Model_Code

END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_Body_PatternSheet_Piece_INSERT]'
GO

ALTER procedure [dbo].[spx_Body_PatternSheet_Piece_INSERT]
(
@BodyID UNIQUEIDENTIFIER,
@StyleSet int,
@CADDB varchar(50),
@Catalog varchar(50),
@Model_Code int,
@ID UNIQUEIDENTIFIER
)
AS
BEGIN
DECLARE @strCADPiece nvarchar(max) 
Declare @strPiece nvarchar(max)


CREATE TABLE #tempTblPiece(
	[Piece_Code] [int]  NULL DEFAULT ((0)),
	[Piece_Name] [varchar](64)  NULL,
	[Last_Updated] [datetime] NULL,
	[IsActive] [int] NULL DEFAULT ((-1)),
	[IsLinked] [int] NULL DEFAULT ((0)),
	[ClassifierId] [int] NULL,
	[SystemId] [int] NULL,
	[Model_Code] [int] NULL DEFAULT ((0)),
	[Material_Code] [int] NULL,
	[Piece_Description] [varchar](510) NULL,

	[Piece_CrOpId] [varchar](100) NULL,
	[Piece_Create] [datetime] NULL,
	[Piece_RevOp1] [varchar](100) NULL,
	[Piece_Rev1] [datetime] NULL,
	[Piece_RevOp2] [varchar](100) NULL,
	[Piece_Rev2] [datetime] NULL,
	[Piece_Message] [varchar](510) NULL,
	[Piece_HPTable] [varchar](100) NULL,
	[Piece_Bias] [int] NULL DEFAULT ((0)),
	[Piece_Flip] [int] NULL DEFAULT ((0)),
	[Piece_Nap] [int] NULL DEFAULT ((0)),
	[Piece_Ign_Splice] [int] NULL DEFAULT ((0)),
	[Piece_Standard] [int] NULL,
	[Piece_Buffering] [int] NULL,
	[Piece_nSplits] [int] NULL,
	[Piece_Tilt_CW] [float] NULL,
	[Piece_DieBlock] [float] NULL,
	[Piece_Pri_XBlock] [float] NULL,
	[Piece_Pri_XBlkType] [int] NULL,
	[Piece_Pri_YBlock] [float] NULL,
	[Piece_Pri_YBlkType] [int] NULL,
	[Piece_Sec_XBlock] [float] NULL,
	[Piece_Sec_XBlkType] [int] NULL,
	[Piece_Sec_YBlock] [float] NULL,
	[Piece_Sec_YBlkType] [int] NULL,
	[Piece_XVariance] [float] NULL,
	[Piece_XVar_Type] [int] NULL,
	[Piece_YVariance] [float] NULL,
	[Piece_YVar_Type] [int] NULL,
	[Piece_nUnflipped] [int] NULL,
	[Piece_nOpposite] [int] NULL,
	[Piece_nFilpY] [int] NULL,
	[Piece_nFlipXY] [int] NULL,
	[Piece_IsMirror] [int] NULL DEFAULT ((0)),
	[Piece_Area] [float] NULL,
	[Piece_Perimeter] [float] NULL,
	[Piece_PreRotation] [float] NULL,
	[Piece_Image_SN] [int] NULL,
	[Piece_Image_Name] [varchar](100) NULL,
	[Piece_Comments] [text] NULL,
	[UserDefined1] [varchar](100) NULL,
	[UserDefined2] [varchar](100) NULL,
	[UserDefined3] [varchar](100) NULL,
	[UserDefined4] [varchar](100) NULL,
	[UserDefined5] [varchar](100) NULL,
	[Piece_Size] [varchar](64) NULL,
	[Piece_Tilt_CCW] [float] NULL,
	[Piece_CW_Type] [int] NULL,
	[Piece_CCW_Type] [int] NULL,
	[Piece_PreRotationType] [int] NULL,
	[PiecePosition] [int] NOT NULL DEFAULT ((0)),
	[mPiece_Area] [float] NULL,
	[mPiece_Perimeter] [float] NULL,
	[Piece_Category] [varchar](510) NULL,
	[Rule_Table_Name] [varchar](64) NULL)
	
SELECT @strPiece = 'INSERT INTO #tempTblPiece 
          ([Piece_Code]
           ,[Piece_Name]
           ,[Last_Updated]
           ,[IsActive]
           ,[IsLinked]
           ,[ClassifierId]
           ,[SystemId]
           ,[Model_Code]
           ,[Material_Code]
           ,[Piece_Description]
           ,[Piece_Category]
		   ,[Rule_Table_Name]
           ,[Piece_CrOpId]
           ,[Piece_Create]
           ,[Piece_RevOp1]
           ,[Piece_Rev1]
           ,[Piece_RevOp2]
           ,[Piece_Rev2]
           ,[Piece_Message]
           ,[Piece_HPTable]
           ,[Piece_Bias]
           ,[Piece_Flip]
           ,[Piece_Nap]
           ,[Piece_Ign_Splice]
           ,[Piece_Standard]
           ,[Piece_Buffering]
           ,[Piece_nSplits]
           ,[Piece_Tilt_CW]
           ,[Piece_DieBlock]
           ,[Piece_Pri_XBlock]
           ,[Piece_Pri_XBlkType]
           ,[Piece_Pri_YBlock]
           ,[Piece_Pri_YBlkType]
           ,[Piece_Sec_XBlock]
           ,[Piece_Sec_XBlkType]
           ,[Piece_Sec_YBlock]
           ,[Piece_Sec_YBlkType]
           ,[Piece_XVariance]
           ,[Piece_XVar_Type]
           ,[Piece_YVariance]
           ,[Piece_YVar_Type]
           ,[Piece_nUnflipped]
           ,[Piece_nOpposite]
           ,[Piece_nFilpY]
           ,[Piece_nFlipXY]
           ,[Piece_IsMirror]
           ,[Piece_Area]
           ,[Piece_Perimeter]
           ,[Piece_PreRotation]
           ,[Piece_Image_SN]
           ,[Piece_Image_Name]
           ,[Piece_Comments]
           ,[UserDefined1]
           ,[UserDefined2]
           ,[UserDefined3]
           ,[UserDefined4]
           ,[UserDefined5]
           ,[Piece_Size]
           ,[Piece_Tilt_CCW]
           ,[Piece_CW_Type]
           ,[Piece_CCW_Type]
           ,[Piece_PreRotationType]
           ,[PiecePosition]
           ,[mPiece_Area]
           ,[mPiece_Perimeter]          
           )' +
' SELECT [Piece_Code]
      ,[Piece_Name]
      ,[Last_Updated]
      ,[IsActive]
      ,[IsLinked]
      ,[ClassifierId]
      ,[SystemId]
      ,[Model_Code]
      ,[Material_Code]
      ,[Piece_Description]
      ,[Piece_Category]
      ,[Rule_Table_Name]
      ,[Piece_CrOpId]
      ,[Piece_Create]
      ,[Piece_RevOp1]
      ,[Piece_Rev1]
      ,[Piece_RevOp2]
      ,[Piece_Rev2]
      ,[Piece_Message]
      ,[Piece_HPTable]
      ,[Piece_Bias]
      ,[Piece_Flip]
      ,[Piece_Nap]
      ,[Piece_Ign_Splice]
      ,[Piece_Standard]
      ,[Piece_Buffering]
      ,[Piece_nSplits]
      ,[Piece_Tilt_CW]
      ,[Piece_DieBlock]
      ,[Piece_Pri_XBlock]
      ,[Piece_Pri_XBlkType]
      ,[Piece_Pri_YBlock]
      ,[Piece_Pri_YBlkType]
      ,[Piece_Sec_XBlock]
      ,[Piece_Sec_XBlkType]
      ,[Piece_Sec_YBlock]
      ,[Piece_Sec_YBlkType]
      ,[Piece_XVariance]
      ,[Piece_XVar_Type]
      ,[Piece_YVariance]
      ,[Piece_YVar_Type]
      ,[Piece_nUnflipped]
      ,[Piece_nOpposite]
      ,[Piece_nFilpY]
      ,[Piece_nFlipXY]
      ,[Piece_IsMirror]
      ,[Piece_Area]
      ,[Piece_Perimeter]
      ,[Piece_PreRotation]
      ,[Piece_Image_SN]
      ,[Piece_Image_Name]
      ,[Piece_Comments]
      ,[UserDefined1]
      ,[UserDefined2]
      ,[UserDefined3]
      ,[UserDefined4]
      ,[UserDefined5]
      ,[Piece_Size]
      ,[Piece_Tilt_CCW]
      ,[Piece_CW_Type]
      ,[Piece_CCW_Type]
      ,[Piece_PreRotationType]
      ,[PiecePosition]
      ,[mPiece_Area]
      ,[mPiece_Perimeter] FROM '
 +  @CADDB + '.' + @Catalog + 
 '.dbo.Cad_Piece_Details WHERE  Model_Code = ' + Convert(varchar(50),@Model_Code)

Exec (@strPiece) 

--IF  (select Count(*) from dbo.pBodyPatternSheetPiece where Model_Code = @Model_Code) = 0
--Begin

INSERT INTO [dbo].[pBodyPatternSheetPiece]
 (BodyID,StyleSet,[Piece_Code],[Piece_Name],[Last_Updated],[Active],IsLinked,Model_Code,
[Material_Code],[Piece_Description],[Piece_Category],[Rule_Table_Name],[Piece_CrOpId],[Piece_Create],[Piece_RevOp1],[Piece_Rev1]
,[Piece_RevOp2],[Piece_Rev2],[Piece_Message],[Piece_HPTable],[Piece_Bias],[Piece_Flip],[Piece_Nap]
,[Piece_Ign_Splice] ,[Piece_Standard] ,[Piece_Buffering] ,[Piece_nSplits],[Piece_Tilt_CW],[Piece_DieBlock],[Piece_Pri_XBlock]
,[Piece_Pri_XBlkType],[Piece_Pri_YBlock],[Piece_Pri_YBlkType],[Piece_Sec_XBlock],[Piece_Sec_XBlkType]
,[Piece_Sec_YBlock],[Piece_Sec_YBlkType],[Piece_XVariance],[Piece_XVar_Type],[Piece_YVariance] ,[Piece_YVar_Type]
,[Piece_nUnflipped],[Piece_nOpposite],[Piece_nFilpY],[Piece_nFlipXY],[Piece_IsMirror],[Piece_Area]
,[Piece_Perimeter],[Piece_PreRotation],[Piece_Image_SN],[Piece_Image_Name],[Piece_Comments],[UserDefined1],[UserDefined2]
,[UserDefined3],[UserDefined4],[UserDefined5],[Piece_Size],[Piece_Tilt_CCW],[Piece_CW_Type],[Piece_CCW_Type],[Piece_PreRotationType]
,[PiecePosition],[mPiece_Area],[mPiece_Perimeter] , ImageID, ModelID ) 
           
SELECT  @BodyID, @StyleSet, [Piece_Code],[Piece_Name],[Last_Updated], 1 as active ,1 as Linked
, Model_Code,[Material_Code],[Piece_Description],[Piece_Category],[Rule_Table_Name],[Piece_CrOpId],[Piece_Create],[Piece_RevOp1],[Piece_Rev1]
,[Piece_RevOp2],[Piece_Rev2],[Piece_Message],[Piece_HPTable],[Piece_Bias],[Piece_Flip],[Piece_Nap]
,[Piece_Ign_Splice] ,[Piece_Standard] ,[Piece_Buffering] ,[Piece_nSplits],[Piece_Tilt_CW],[Piece_DieBlock],[Piece_Pri_XBlock]
,[Piece_Pri_XBlkType],[Piece_Pri_YBlock],[Piece_Pri_YBlkType],[Piece_Sec_XBlock],[Piece_Sec_XBlkType]
,[Piece_Sec_YBlock],[Piece_Sec_YBlkType],[Piece_XVariance],[Piece_XVar_Type],[Piece_YVariance] ,[Piece_YVar_Type]
,[Piece_nUnflipped],[Piece_nOpposite],[Piece_nFilpY],[Piece_nFlipXY],[Piece_IsMirror],[Piece_Area]
,[Piece_Perimeter],[Piece_PreRotation],[Piece_Image_SN],[Piece_Image_Name],[Piece_Comments],[UserDefined1],[UserDefined2]
,[UserDefined3],[UserDefined4],[UserDefined5],[Piece_Size],[Piece_Tilt_CCW],[Piece_CW_Type],[Piece_CCW_Type],[Piece_PreRotationType]
,[PiecePosition],[mPiece_Area],[mPiece_Perimeter] ,null as ImageID, @ID 
FROM #tempTblPiece  

Drop Table #tempTblPiece
END
---------------------------------------------------------------

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_BodyPatternsheet_Model_Insert]'
GO

ALTER PROCEDURE [dbo].[spx_BodyPatternsheet_Model_Insert] (
@ID UNIQUEIDENTIFIER,
@BodyID UNIQUEIDENTIFIER,
@StyleSet int,
@CADDB varchar(50),
@Catalog varchar(50),
@Model_Code int,
@CUser nvarchar(200),
@CDate datetime,
@MUser nvarchar(200),
@MDate datetime
)
AS
Declare @Linked  int
Declare @strCADModel nvarchar(max)
Declare @strCADPiece nvarchar(max)
Declare @ImageID  UNIQUEIDENTIFIER 
Declare @pID UNIQUEIDENTIFIER 


BEGIN


IF not exists  (select * from dbo.pBodyPatternSheetModel where ID = @ID)
Set @Linked = 1

SELECT @strCADModel ='
INSERT INTO [pBodyPatternSheetModel]
           ([ID]
           ,[BodyId]
           ,[StyleSet]
           ,[Model_Code]
           ,[Model_Name]
           ,[Last_Updated]
           ,[Active]
           ,[IsLinkedBF]
           ,[IsLinked]
           ,[CDate]
           ,[CUser]
           ,[MUser]
           ,[MDate]
           ,[Marker_Code]
           ,[Model_Description]
           ,[Model_CrOpId]
           ,[Model_Create]
           ,[Model_RevOp1]
           ,[Model_Rev1]
           ,[Model_RevOp2]
           ,[Model_Rev2]
           ,[Model_GRTable]
           ,[Model_MTMFile]
           ,[Model_SAName]
           ,[Model_SYNTable]
           ,[Model_HPTable]
           ,[Model_SampleSize]
           ,[Model_nMaterials]
           ,[Model_nPieces]
           ,[Model_nSizes]
           ,[Model_Image_SN]
           ,[Model_Image_Name]
           ,[Model_Comments]
           ,[PreferMetric]
           ,[UserDefined1]
           ,[UserDefined2]
           ,[UserDefined3]
           ,[UserDefined4]
           ,[UserDefined5]
           ,[Total_Area]
           ,[LastCADRefresh]
           ,[PlotFileLocation]
           ,[NotchFile]
           ,[AnnotationFile]
           ,[StorageType])' + 
' SELECT '+  CHAR(39) + Convert(varchar(36),@ID) + CHAR(39) + ' as ID,' 
+ CHAR(39) + Convert(varchar(36),@BodyID) + CHAR(39) 
+' as BodyID , ' + Convert(varchar(10),@StyleSet) + ' as StyleSet, [Model_Code]
 ,[Model_Name],[Last_Updated],1 as [Active], 0 as [IsLinkedBF], 1 as [IsLinked],' 
  + convert(nvarchar(50), CAST(@CDate AS DATETIME), 101) +' as [CDate],' 
+ CHAR(39) + Convert(varchar(36),@CUser) + CHAR(39) +' as [CUser],'
+ CHAR(39) + Convert(varchar(36),@MUser) + CHAR(39) + ' as [MUser],'
+ convert(nvarchar(50), CAST(@CDate AS DATETIME), 101)  + ' as [MDate]          
--,[ClassifierId],[SystemId]
,[Marker_Code],[Model_Description],[Model_CrOpId],[Model_Create]
,[Model_RevOp1],[Model_Rev1],[Model_RevOp2],[Model_Rev2],[Model_GRTable],[Model_MTMFile]
,[Model_SAName],[Model_SYNTable],[Model_HPTable],[Model_SampleSize],[Model_nMaterials],[Model_nPieces]
,[Model_nSizes],[Model_Image_SN],[Model_Image_Name],[Model_Comments],[PreferMetric],[UserDefined1]
,[UserDefined2],[UserDefined3],[UserDefined4],[UserDefined5],[Total_Area],[LastCADRefresh]
,[PlotFileLocation],[NotchFile],[AnnotationFile],[StorageType]' +

' FROM ' +  @CADDB + '.' + @Catalog + 
 '.dbo.Cad_Model_Details WHERE  Model_Code = ' + Convert(varchar(50),@Model_Code)
 
--print @strCADModel
--return
-- EXEC [spx_BodyPatternsheet_Model_Insert]'119c1d8e-b113-4677-ba0e-93b4c71e4026','d888c2ec-9ea0-460e-89fc-693930d8e780','[SIVA-PC]','[kellwood]','17610','siva nandigam','2010-10-04T11:49:41.253','siva nandigam','2010-10-04T11:49:41.253'

EXEC (@strCADModel)

Exec [spx_Body_PatternSheet_Piece_INSERT] @BodyID, @StyleSet, @CADDB,@Catalog,@Model_Code, @ID


END

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_BatchQueueMaterialReplace_DELETE]'
GO

CREATE  PROCEDURE [dbo].[spx_BatchQueueMaterialReplace_DELETE]
(
	@BatchQueueMaterialReplaceID uniqueidentifier
)
AS 

DELETE FROM bBatchQueueMaterialReplace
WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_SampleRequestSpec_SELECT_OLD]'
GO


ALTER PROCEDURE [dbo].[spx_SampleRequestSpec_SELECT_OLD] 
(@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar(5),
@TeamID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet nvarchar(5))
AS

DECLARE @samplesize varchar(10), @sql varchar(8000), @selectwhere varchar(8000), @delim varchar(1), @select varchar(8000), @var varchar(100), @ask varchar(100), @spec varchar(100), @rev varchar(100), @fin varchar(100), @pivot varchar(100), @pivotwhere varchar(100), @table varchar(100)

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

--SELECT @samplesize = (SELECT 
--CASE 
--WHEN Sel0 = 1 THEN Size0	
--WHEN Sel1 = 1 THEN Size1
--WHEN Sel2 = 1 THEN Size2
--WHEN Sel3 = 1 THEN Size3
--WHEN Sel4 = 1 THEN Size4
--WHEN Sel5 = 1 THEN Size5
--WHEN Sel6 = 1 THEN Size6
--WHEN Sel7 = 1 THEN Size7
--WHEN Sel8 = 1 THEN Size8
--WHEN Sel9 = 1 THEN Size9
--WHEN Sel10 = 1 THEN Size10
--WHEN Sel11 = 1 THEN Size11	
--END AS [SampleSize] FROM pSampleRequestWorkflowSize WITH (NOLOCK) 
--WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) 
--AND (SampleWorkflowID = @SampleWorkflowID) 
--AND (TeamID = @TeamID) 
--AND (StyleID = @StyleID))

--CASE 
--WHEN Size0 = 1 THEN Proto0	
--WHEN Size1 = 1 THEN Proto1
--WHEN Size2 = 1 THEN Proto2
--WHEN Size3 = 1 THEN Proto3
--WHEN Size4 = 1 THEN Proto4
--WHEN Size5 = 1 THEN Proto5
--WHEN Size6 = 1 THEN Proto6
--WHEN Size7 = 1 THEN Proto7
--WHEN Size8 = 1 THEN Proto8
--WHEN Size9 = 1 THEN Proto9
--WHEN Size10 = 1 THEN Proto10
--WHEN Size11 = 1 THEN Proto11	
--END AS [SMP]

SELECT @select = 'SELECT POM, PointMeasur AS [Point of Measurment] 
 FROM dbo.pSampleRequestSpecItem WITH (NOLOCK)
GROUP BY SampleRequestWorkflowID, SampleWorkflowID, TradePartnerVendorID, StyleID, StyleSet, POM, PointMeasur, Sort '

SELECT @ask = 'MAX(Ask)'
SELECT @spec = 'MAX(Spec)'
SELECT @var = 'MAX(Var)'
SELECT @rev = 'MAX(Rev)'
SELECT @fin = 'MAX(Final)'

SELECT @pivot = 'Submit'
SELECT @table = 'pSampleRequestSpecItem '

SELECT @pivotwhere = ' pSampleRequestSpecItem WHERE 1=2 AND ((StyleSet =' + '''' + convert(varchar(5),@StyleSet) + ''')  
AND (StyleID =' + '''' + convert(varchar(50),@StyleID) + ''') 
AND (SampleRequestWorkflowID =' + '''' + convert(varchar(50),@SampleRequestWorkflowID) + ''') 
AND (SampleWorkflowID =' + '''' + convert(varchar(50),@SampleWorkflowID) + ''') 
AND (TradePartnerVendorID =' + '''' + convert(varchar(50),@TeamID) + ''') 
ORDER BY POM) '

--EXEC ('SELECT ' + @pivot + ' AS pivot INTO ##SampleSpec FROM ' + @table + ' WHERE 1=2')
--EXEC ('INSERT INTO ##SampleSpec SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE ' + @pivot + ' Is Not Null')
SELECT Submit AS 'pivot' INTO ##SampleSpec FROM pSampleRequestSpecItem WITH (NOLOCK) WHERE 1=2

INSERT INTO ##SampleSpec SELECT DISTINCT Submit FROM pSampleRequestSpecItem WITH (NOLOCK) WHERE Submit Is Not Null AND Spec = 0 AND StyleSet = @StyleSet AND StyleID = @StyleID AND TradePartnerVendorID = @TeamID AND SampleRequestWorkflowID = @SampleRequestWorkflowID AND SampleWorkflowID = @SampleWorkflowID

--SELECT * FROM pSampleRequestSpecItem WITH (NOLOCK) WHERE Spec <> 0 AND Submit Is Not Null AND StyleSet = @StyleSet AND StyleID = @StyleID AND TradePartnerVendorID = @TeamID AND SampleRequestWorkflowID = @SampleRequestWorkflowID AND SampleWorkflowID = @SampleWorkflowID

SELECT @sql='',  @ask=stuff(@ask, len(@ask), 1, ' END)' )
SELECT @sql=@sql + '',  @spec=stuff(@spec, len(@spec), 1, ' END)' )
SELECT @sql=@sql + '',  @var=stuff(@var, len(@var), 1, ' END)' )
SELECT @sql=@sql + '',  @rev=stuff(@rev, len(@rev), 1, ' END)' )
SELECT @sql=@sql + '',  @fin=stuff(@fin, len(@fin), 1, ' END)' )

SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
WHEN 0 THEN '''' ELSE '''' END 
FROM tempdb.information_schema.columns 
WHERE table_name='##SampleSpec' AND column_name='pivot'

SELECT @sql=@sql + '''Ask ' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@ask,charindex( '(', @ask )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Spec ' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@spec,charindex( '(', @spec )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Var ' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@var,charindex( '(', @var )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Rev ' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@rev,charindex( '(', @rev )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
+ '''Final ' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@fin,charindex( '(', @fin )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
FROM ##SampleSpec

SELECT @sql = left(@sql, len(@sql)-1)

SELECT @select = stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')

SELECT @selectwhere = ' HAVING  (StyleSet =' + '''' + convert(varchar(5),@StyleSet) + ''')  
AND (StyleID =' + '''' + convert(varchar(50),@StyleID) + ''') 
AND (SampleRequestWorkflowID =' + '''' + convert(varchar(50),@SampleRequestWorkflowID) + ''') 
AND (SampleWorkflowID =' + '''' + convert(varchar(50),@SampleWorkflowID) + ''') 
AND (TradePartnerVendorID =' + '''' + convert(varchar(50),@TeamID) + ''') 
ORDER BY Sort, POM '


PRINT @select + @selectwhere

DROP TABLE ##SampleSpec

EXEC (@select + @selectwhere)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_BatchQueueMaterialFindReplace_Execute_UPDATE]'
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.spx_BatchQueueMaterialFindReplace_Execute_UPDATE(
	@BachQTransactionID UNIQUEIDENTIFIER
)
AS


DECLARE @Error INT 
SET @Error = 0 

BEGIN TRANSACTION 

BEGIN TRY

	DECLARE 
		@BatchQueueMaterialReplaceID UNIQUEIDENTIFIER,
		@CUser NVARCHAR(200),
		@CDate DATETIME,
		@TeamID UNIQUEIDENTIFIER 


	SELECT 
		@BatchQueueMaterialReplaceID = BatchQueueMaterialReplaceID,
		@CUser = CUser,
		@CDate = CDate,
		@TeamID =  TeamID
	FROM bBatchQueuMaterialReplaceTransactionTmp WITH(NOLOCK)
	WHERE BachQTransactionID = @BachQTransactionID


	DECLARE 
		@TOTAL INT,
		@ROWID INT,
		@MaterialColorFindID UNIQUEIDENTIFIER,
		@MaterialColorReplaceID UNIQUEIDENTIFIER,
		@MaterialSizeFindID UNIQUEIDENTIFIER,
		@MaterialSizeReplaceID UNIQUEIDENTIFIER,
		@StyleMaterialID UNIQUEIDENTIFIER
		

	--** Replace MaterialColor
	CREATE TABLE #mc(
		ROWID INT IDENTITY(1,1),
		MaterialColorFindID UNIQUEIDENTIFIER,
		MaterialColorReplaceID UNIQUEIDENTIFIER
	)

	INSERT INTO #mc(
		MaterialColorFindID, 
		MaterialColorReplaceID
	)
	SELECT MaterialColorFindID, MaterialColorReplaceID
	FROM dbo.bBatchQueuMaterialColorReplaceTmp WITH(NOLOCK)
	WHERE BachQTransactionID = @BachQTransactionID


	SET @ROWID = 1
	SELECT @TOTAL = COUNT(*) FROM #mc

	WHILE @ROWID <= @TOTAL
	BEGIN

		SELECT @MaterialColorFindID = MaterialColorFindID, @MaterialColorReplaceID = MaterialColorReplaceID
		FROM #mc WHERE ROWID = @ROWID

		UPDATE c
		SET c.MaterialColorID = @MaterialColorReplaceID
		FROM dbo.bBatchQueueMaterialReplaceStyle a
			INNER JOIN dbo.pStyleColorway b ON a.StyleID = b.StyleID
			INNER JOIN dbo.pStyleColorwayItem  c  ON c.StyleColorID =  b.StyleColorID 
		WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID
		AND c.MaterialColorID  = @MaterialColorFindID
		
		SET @ROWID =  @ROWID + 1 
		
	END

	DROP TABLE #mc

	--** Replace MaterialSize 
	DECLARE 
		@MaterialFindID UNIQUEIDENTIFIER,
		@MaterialReplaceID UNIQUEIDENTIFIER

		
	SELECT @MaterialFindID = MaterialFindID, @MaterialReplaceID = MaterialReplaceID
	FROM bBatchQueueMaterialReplace WITH(NOLOCK)
	WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID


	CREATE TABLE #ms(
		ROWID INT IDENTITY(1,1),
		MaterialSizeFindID UNIQUEIDENTIFIER,
		MaterialSizeReplaceID UNIQUEIDENTIFIER
	)

	INSERT INTO #ms(MaterialSizeFindID, MaterialSizeReplaceID)
	SELECT MaterialSizeFindID, MaterialSizeReplaceID FROM dbo.bBatchQueuMaterialSizeReplaceTmp
	WHERE BachQTransactionID = BachQTransactionID


	SET @ROWID = 1
	SELECT @TOTAL =COUNT(*) FROM #ms

	WHILE @ROWID <= @TOTAL
	BEGIN 

		SELECT 
			@MaterialSizeFindID = MaterialSizeFindID, 
			@MaterialSizeReplaceID = MaterialSizeReplaceID
		FROM #ms WHERE ROWID = @ROWID 

		UPDATE b
		SET MaterialSizeID = @MaterialSizeReplaceID
		FROM dbo.bBatchQueueMaterialReplaceStyle a
			INNER JOIN dbo.pStyleMaterials b ON b.StyleID =  a.StyleID 
		WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID
			AND b.MaterialID = @MaterialFindID
			AND b.MaterialSizeID = @MaterialSizeFindID	
		
		SET @ROWID = @ROWID + 1 
	END 

	DROP TABLE #ms

	--** Update Material in 
	--		pStyleMaterials => MaterialID = NEWMaterial, 
	--		pStyleColorwayItem => MaterialID = NEWMaterial, 
	--		pStyleSourcingItem = > TradepartnerVendorID = NULL, MaterialPrice = 0 

	CREATE TABLE #sm(
		ROWID INT IDENTITY (1,1),
		StyleMaterialID UNIQUEIDENTIFIER
	)


	INSERT INTO #sm( StyleMaterialID)
	SELECT b.StyleMaterialID
	FROM dbo.bBatchQueueMaterialReplaceStyle a
		INNER JOIN dbo.pStyleMaterials b ON a.StyleID = b.StyleID AND b.MaterialID = @MaterialFindID
	WHERE A.BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID

	SET @ROWID = 1 
	SELECT @TOTAL = COUNT(*)  FROM #sm 

	WHILE @ROWID <= @TOTAL
	BEGIN
		SELECT @StyleMaterialID = StyleMaterialID FROM #sm WHERE ROWID = @ROWID 
		
		UPDATE dbo.pStyleMaterials 
		SET MaterialID = @MaterialReplaceID
		WHERE StyleMaterialID = @StyleMaterialID 
		
		
		UPDATE a
		SET MaterialImageID = b.MaterialImageID,
			MaterialImageVersion = b.MaterialImageVersion,
			MaterialType = b.MaterialType,
			Materialno =  b.MaterialNo,
			Materialname = b.MaterialName,
			A = b.A,
			B = b.B,
			C = b.C,
			D = b.D,
			E = b.E,
			F = b.F,
			G = b.G,
			H = b.H,
			I = b.I,
			J = b.J,
			K = b.K,
			L = b.L,
			M = b.M,
			N = b.N,
			O = b.O,
			P = b.P,
			Q = b.Q,
			R = b.R,
			S = b.S,
			T = b.T,
			U = b.U,
			V = b.V,
			X = b.X,
			Y = b.Y,
			Z = b.Z,
			Source = b.Source,
			Notes =  b.Notes,
			CDate = @CDate,
			CUser = @CUser,
			MDate = @CDate,
			MUser = @CUser, 
			MChange = b.MChange, 
			TradePartnerID = NULL,
			TradePartnerVendorID =  NULL
		FROM dbo.pStyleMaterials a
			INNER JOIN dbo.pMaterial b ON a.MaterialID =  b.MaterialID 
		WHERE a.StyleMaterialID = @StyleMaterialID
		

		UPDATE pStyleColorwayItem
		SET MaterialID = @MaterialReplaceID
		WHERE StyleMaterialID = @StyleMaterialID		

		UPDATE dbo.pStyleSourcingItem
		SET TradePartnerVendorID = NULL ,
			MaterialPrice =	0 
		WHERE StyleMaterialID = @StyleMaterialID 
		
		
		SET @ROWID = @ROWID + 1 
	END
	

END TRY
BEGIN CATCH 
	SET @Error = 1 
	
END CATCH 


IF @Error = 0
	COMMIT TRANSACTION
ELSE	
	ROLLBACK TRANSACTION 
	


DELETE bBatchQueuMaterialColorReplaceTmp
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
	INNER JOIN bBatchQueuMaterialColorReplaceTmp c ON c.BachQTransactionID = b.BachQTransactionID
WHERE a.TeamID = @TeamID	

DELETE bBatchQueuMaterialSizeReplaceTmp 
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
	INNER JOIN bBatchQueuMaterialSizeReplaceTmp c ON c.BachQTransactionID = b.BachQTransactionID
WHERE a.TeamID = @TeamID	


DELETE bBatchQueuMaterialReplaceTransactionTmp
FROM dbo.bBatchQueueMaterialReplace a
	INNER JOIN bBatchQueuMaterialReplaceTransactionTmp b ON a.BatchQueueMaterialReplaceID = b.BatchQueueMaterialReplaceID
WHERE a.TeamID = @TeamID		
	

DELETE FROM dbo.bBatchQueueMaterialReplace
WHERE BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_StyleComponentDimensionLogic_UPDATE]'
GO

CREATE PROCEDURE dbo.spx_StyleComponentDimensionLogic_UPDATE(
	@StyleMaterialID UNIQUEIDENTIFIER,
	@SQLUpdate NVARCHAR(MAX),
	@TeamID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS

DECLARE
	@MaterialImageID UNIQUEIDENTIFIER, 
	@MaterialImageVersion INT, 
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialNo NVARCHAR(200), 
	@MaterialName  NVARCHAR(200),
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@MaterialSize NVARCHAR(200),
	@MainMaterialID UNIQUEIDENTIFIER
	
DECLARE 
	@oLicense INT, 
	@oArtwork INT, 
	@oColorway INT, 
	@oMaterialDimension INT, 
	@oPlacement NVARCHAR(4000), 
	@oMainMaterial INT

	
DECLARE 
	@nLicense INT, 
	@nArtwork INT, 
	@nColorway INT, 
	@nMaterialDimension INT, 
	@nPlacement NVARCHAR(4000), 
	@nMainMaterial INT
	


-- Old values
SELECT @oLicense = a.License, @oArtwork = a.Artwork, @oColorway = a.Colorway, @oMaterialDimension = a.MaterialDimension, 
	@oPlacement = a.Placement, @oMainMaterial = a.MainMaterial,
	@MaterialImageID = MaterialImageID, @MaterialImageVersion = MaterialImageVersion, @MaterialID = MaterialID, 
	@MaterialNo = MaterialNo, @MaterialName = MaterialName, @StyleID = StyleID, @StyleSet = StyleSet, @MaterialSize = MaterialSize
FROM dbo.pStyleMaterials a
WHERE StyleMaterialID = @StyleMaterialID

SELECT @MainMaterialID = StyleMaterialID FROM dbo.pStyleMaterials WHERE @StyleID =  @StyleID AND MainMaterial = 1 


EXEC SP_EXECUTESQL @SQLUpdate

-- New values
SELECT @nLicense = a.License, @nArtwork = a.Artwork, @nColorway = a.Colorway, @nMaterialDimension = a.MaterialDimension, 
	@nPlacement = a.Placement, @nMainMaterial = a.MainMaterial 
FROM dbo.pStyleMaterials a
WHERE StyleMaterialID = @StyleMaterialID


IF @nMainMaterial = 1 AND @StyleSet = 1 
BEGIN
	UPDATE  dbo.pStyleHeader SET 
		StyleMaterialID = @StyleMaterialID, 
		MaterialImageID = @MaterialImageID, 
		MaterialImageVersion = @MaterialImageVersion, 
		MaterialID = @MaterialID, 
		MaterialNo = @MaterialNo, 
		MaterialName = @MaterialName  
	WHERE StyleID = @StyleID
END

exec spx_StyleMaterialVariation_UPDATE  @StyleMaterialId 	
exec spx_StyleMaterialGlobal_UPDATE @StyleMaterialId, @StyleId, @StyleSet


--*** Log changes 

DECLARE 
	@NewChangeID UNIQUEIDENTIFIER,
	@MaterialChanged NVARCHAR(1000),
	@StyleChangeDescription  NVARCHAR(1000)

SET @MaterialChanged  = @MaterialNo
IF @MaterialName IS NOT NULL 
	SET @MaterialChanged  = @MaterialChanged  + '- ' + @MaterialName
IF @MaterialSize IS NOT NULL
	SET @MaterialChanged  = @MaterialChanged  + ' ('  + @MaterialSize + ')'


--** License
IF @oLicense = 1 AND @nLicense = 0
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Removed from Licensee'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000009',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Delete', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 

IF @oLicense = 0 AND @nLicense = 1
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Added from Licensee'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000009',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Update', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 


--** Artwork
IF @oArtwork = 1 AND @nArtwork = 0
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Removed from Size\Treadment'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000010',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Delete', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 
IF @oArtwork = 0 AND @nArtwork = 1
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Added to Size\Treadment'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000010',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Update', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 


--** Colorway
IF @oColorway = 1 AND @nColorway = 0
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Removed from colorway'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000004',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Delete', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 
IF @oColorway = 0 AND @nColorway = 1
BEGIN
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Added to colorway'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000004',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Update', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 


IF @oPlacement <> @nPlacement
BEGIN 
	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' - Placement changed FROM: '  + @oPlacement + ' To: ' + @nPlacement
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000004',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Update', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate
END 


IF EXISTS ( SELECT * FROM pStyleHeader a WITH(NOLOCK) INNER JOIN dbo.pTechPack b WITH(NOLOCK) ON a.TechPackId = b.TechPackID )
BEGIN 

	SET @NewChangeID = NEWID() 
	SET @StyleChangeDescription =  'Material ' + @MaterialChanged + ' Update'
	
	EXEC spx_StyleChange_INSERT 
		@ActiveID = '00000000-0000-0000-0000-000000000000',
		@ChangeID = @NewChangeID,
		@WorkflowID = '40000000-0000-0000-0000-000000000014',
		@StyleID = @StyleID,
		@StyleSet = @StyleSet,
		@StyleStatus = 0 ,
		@StyleChangeNotifyTo = '',
		@StyleChangeType = 'Update', 
		@StyleChangeDescription = @StyleChangeDescription,
		@ChangeBy = @MUser, 
		@ChangeDate = @MDate


	IF @StyleSet = 1
	BEGIN 
	
		IF @nMainMaterial = 1
		BEGIN 
		
			IF  @MainMaterialID IS NULL OR  
				( @MainMaterialID IS NOT NULL  AND @MainMaterialID <> @StyleMaterialID)
			BEGIN
				-- New mainmaterial
				
				SET @NewChangeID = NEWID() 
				SET @StyleChangeDescription =  'Main Material ' + @MaterialChanged + ' added to Style'
						
				EXEC spx_StyleChange_INSERT 
					@ActiveID = '00000000-0000-0000-0000-000000000000',
					@ChangeID = @NewChangeID,
					@WorkflowID = '40000000-0000-0000-0000-000000000014',
					@StyleID = @StyleID,
					@StyleSet = @StyleSet,
					@StyleStatus = 0 ,
					@StyleChangeNotifyTo = '',
					@StyleChangeType = 'Update', 
					@StyleChangeDescription = @StyleChangeDescription,
					@ChangeBy = @MUser, 
					@ChangeDate = @MDate		
			END
			
			IF @MainMaterialID IS NOT NULL  AND @MainMaterialID <> @StyleMaterialID
			BEGIN 
			
				SET @NewChangeID = NEWID() 
				SET @StyleChangeDescription =  'Main Material ' + @MaterialChanged + ' removed from Style'
						
				EXEC spx_StyleChange_INSERT 
					@ActiveID = '00000000-0000-0000-0000-000000000000',
					@ChangeID = @NewChangeID,
					@WorkflowID = '40000000-0000-0000-0000-000000000014',
					@StyleID = @StyleID,
					@StyleSet = @StyleSet,
					@StyleStatus = 0 ,
					@StyleChangeNotifyTo = '',
					@StyleChangeType = 'Update', 
					@StyleChangeDescription = @StyleChangeDescription,
					@ChangeBy = @MUser, 
					@ChangeDate = @MDate			
			
			END 
		END 
		ELSE IF  @nMainMaterial = 0 AND @MainMaterialID = @StyleMaterialID
		BEGIN 
		
			SET @NewChangeID = NEWID() 
			SET @StyleChangeDescription =  'Main Material ' + @MaterialChanged + ' Removed from Style'
		
			EXEC spx_StyleChange_INSERT 
				@ActiveID = '00000000-0000-0000-0000-000000000000',
				@ChangeID = @NewChangeID,
				@WorkflowID = '40000000-0000-0000-0000-000000000014',
				@StyleID = @StyleID,
				@StyleSet = @StyleSet,
				@StyleStatus = 0 ,
				@StyleChangeNotifyTo = '',
				@StyleChangeType = 'Delete', 
				@StyleChangeDescription = @StyleChangeDescription,
				@ChangeBy = @MUser, 
				@ChangeDate = @MDate		
		
		END 
	
	END 

		
END 





GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_StyleColorwayItem_UPDATE]'
GO
SET QUOTED_IDENTIFIER OFF
GO


ALTER PROCEDURE [dbo].[spx_StyleColorwayItem_UPDATE]  (
	@MaterialColorID UNIQUEIDENTIFIER,
	@StyleMaterialID UNIQUEIDENTIFIER = NULL,
	@StyleColorItemID UNIQUEIDENTIFIER = NULL,	
	@StyleID UNIQUEIDENTIFIER = NULL,
	@StyleSet INT = 1,
	@SeasonYearID UNIQUEIDENTIFIER = NULL,
	@AllColor INT = 0,
	@MUser NVARCHAR(200),
	@MDate DATETIME ,
	@ChangeTransID UNIQUEIDENTIFIER,
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@NoApplicableColor INT = 0
) 
AS 


--*** Check for the "No applicable" 
--*** Burberry logic 

IF @NoApplicableColor = 1
BEGIN
	DECLARE 
		@MaterialID  UNIQUEIDENTIFIER,
		@MaterialSeasonYearID UNIQUEIDENTIFIER
	
	SET @MaterialColorID =  NULL
	
	--** Verify that the color exists in Burberry's main colorpalette
	IF NOT EXISTS (SELECT * FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = '00000000-0000-0000-0000-000000000001'
		AND ColorPaletteID = '00000000-0000-0000-0000-000000000001' )
		RETURN 

	SELECT @MaterialID = a.MaterialID 
	FROM dbo.pStyleMaterials a WITH (NOLOCK)
	WHERE a.StyleMaterialID = @StyleMaterialID
	
	--**  Check for material/seasaonYear
	SELECT @MaterialSeasonYearID=MaterialSeasonYearID   
	FROM pMaterialSeasonYear WITH (NOLOCK)
	WHERE MaterialID = @MaterialID
	AND SeasonYearID = @SeasonYearID
	
	IF @MaterialSeasonYearID IS NULL
	BEGIN 
		SET @MaterialSeasonYearID = NEWID()
		INSERT INTO dbo.pMaterialSeasonYear(
			MaterialSeasonYearID ,SeasonYearID, MaterialID ,CUser ,CDate )
		VALUES (
			@MaterialSeasonYearID, @SeasonYearID, @MaterialID,@MUser, @MDate )
	END 


	--*** Check if the materialcolor exists ? 	
	SELECT @MaterialColorID = MaterialColorID FROM pMaterialColor WITH (NOLOCK) 
	WHERE MaterialID=@MaterialID
		AND ColorPaletteID = '00000000-0000-0000-0000-000000000001' 
		
	IF @MaterialColorID IS NULL
	BEGIN 
		SET @MaterialColorID =  NEWID()
		--** Add color to the material 
		EXECUTE spx_Material_Color_INSERT
			@MaterialColorID = @MaterialColorID,
			@MaterialID=@MaterialID,
			@ColorPaletteID= '00000000-0000-0000-0000-000000000001',
			@CUser = @MUser,
			@CDate = @MDate
	END 
	
	--** Check for the color in a Material/SeasonYear
	IF NOT EXISTS ( SELECT * FROM dbo.pMaterialColorSeasonYear 
		WHERE MaterialColorID = @MaterialColorID AND SeasonYearID = @SeasonYearID)
	BEGIN
		EXECUTE spx_MaterialColorSeasonYear_INSERT
			@MaterialID = @MaterialID,
			@MaterialColorID = @MaterialColorID,
			@SeasonYearID  = @SeasonYearID,
			@TeamID = @ChangeTransID,
			@CUser = @MUser,
			@CDate = @MDate
		
	END 
END 


DECLARE 
	@ChangeLogID UNIQUEIDENTIFIER,
	@BeforeValue UNIQUEIDENTIFIER,
	@BeforeText NVARCHAR(400),
	@AfterValue UNIQUEIDENTIFIER,
	@AfterText NVARCHAR(400),
	@ROWID INT,
	@TOTAL INT,
	@MultiDimension INT,
	@StyleColorID UNIQUEIDENTIFIER
	
CREATE TABLE #tmp(
	ROWID INT IDENTITY(1,1),
	StyleColorItemID UNIQUEIDENTIFIER,
	MaterialColorID UNIQUEIDENTIFIER,
	ColorName NVARCHAR(200),
	ColorCode NVARCHAR(200),
	MultiDimension INT,
	StyleMaterialID UNIQUEIDENTIFIER,
	StyleColorID UNIQUEIDENTIFIER
)


IF @AllColor = 1 
BEGIN 

	IF @SeasonYearID IS NULL 

		INSERT INTO #tmp( StyleColorItemID ,MaterialColorID ,
				  ColorName ,ColorCode, MultiDimension, StyleMaterialID, StyleColorID)
		SELECT a.StyleColorItemID, a.MaterialColorID, 
			ISNULL(c.ColorName,''), ISNULL(c.ColorCode,''),  e.MultiDimension,  a.StyleMaterialID, a.StyleColorID
		FROM dbo.pStyleColorwayItem a WITH (NOLOCK)
			INNER JOIN dbo.pStyleMaterials d WITH (NOLOCK) ON d.StyleMaterialID = a.StyleMaterialID
			INNER JOIN dbo.pMaterial e WITH (NOLOCK) ON e.MaterialID  =  d.MaterialID
			LEFT OUTER JOIN pMaterialColor b WITH (NOLOCK) ON a.MaterialColorID =  b.MaterialColorID
			LEFT OUTER JOIN dbo.pColorPalette c WITH (NOLOCK) ON	c.ColorPaletteID =  b.ColorPaletteID
		WHERE a.StyleMaterialID = @StyleMaterialID 
			AND a.StyleID = @StyleID 
			AND a.StyleSet = @StyleSet 
			
	ELSE 
		INSERT INTO #tmp( StyleColorItemID ,MaterialColorID ,
				  ColorName ,ColorCode, MultiDimension, StyleMaterialID, StyleColorID)
		SELECT a.StyleColorItemID, a.MaterialColorID, 
			ISNULL(c.ColorName,''), ISNULL(c.ColorCode,''),  e.MultiDimension,  a.StyleMaterialID, a.StyleColorID
		FROM dbo.pStyleColorwayItem a WITH (NOLOCK)
			INNER JOIN dbo.pStyleSeasonYear x ON x.StyleID = a.StyleID	
				AND x.SeasonYearID = @SeasonYearID
			INNER JOIN dbo.pStyleColorwaySeasonYear y ON y.StyleColorwayID  =  a.StyleColorID 
				AND y.StyleSeasonYearID = x.StyleSeasonYearID			
			INNER JOIN dbo.pStyleMaterials d WITH (NOLOCK) ON d.StyleMaterialID = a.StyleMaterialID
			INNER JOIN dbo.pMaterial e WITH (NOLOCK) ON e.MaterialID  =  d.MaterialID
			LEFT OUTER JOIN pMaterialColor b WITH (NOLOCK) ON a.MaterialColorID =  b.MaterialColorID
			LEFT OUTER JOIN dbo.pColorPalette c WITH (NOLOCK) ON	c.ColorPaletteID =  b.ColorPaletteID
		WHERE a.StyleMaterialID = @StyleMaterialID 
			AND a.StyleID = @StyleID 
			AND a.StyleSet = @StyleSet 	
		
END 
ELSE
BEGIN 

	INSERT INTO #tmp( StyleColorItemID ,MaterialColorID ,ColorName ,ColorCode,MultiDimension, StyleMaterialID, StyleColorID)
	SELECT a.StyleColorItemID, a.MaterialColorID,ISNULL(c.ColorName,''), ISNULL(c.ColorCode,''), e.MultiDimension,  a.StyleMaterialID, a.StyleColorID
	FROM dbo.pStyleColorwayItem a WITH (NOLOCK)
		INNER JOIN dbo.pStyleMaterials d WITH (NOLOCK) ON d.StyleMaterialID = a.StyleMaterialID
		INNER JOIN dbo.pMaterial e WITH (NOLOCK) ON e.MaterialID  =  d.MaterialID
		LEFT OUTER JOIN pMaterialColor b WITH (NOLOCK) ON a.MaterialColorID =  b.MaterialColorID
		LEFT OUTER JOIN dbo.pColorPalette c WITH (NOLOCK) ON	c.ColorPaletteID =  b.ColorPaletteID
	WHERE a.StyleColorItemID = @StyleColorItemID
	
END



-- Update Colorchips
UPDATE pStyleColorwayItem SET 
	MaterialColorID = @MaterialColorID,
	MUser = @MUser,
	MDate = @MDate
FROM pStyleColorwayItem 
	INNER JOIN #tmp ON 	pStyleColorwayItem.StyleColorItemID = #tmp.StyleColorItemID


----*** Check MultiMaterials
--SET @ROWID = 1
--SELECT @TOTAL =  COUNT(*) FROM #tmp

--WHILE @ROWID <= @TOTAL 
--BEGIN
--	SELECT @MultiDimension = MultiDimension,  @StyleMaterialID = StyleMaterialID, @StyleColorID = StyleColorID
--	FROM #tmp WHERE ROWID = @ROWID

--	IF @MultiDimension =  1
--	BEGIN 
--		-- Update subComponents using the default color combination 
		
--		UPDATE dbo.pStyleColorwayItem
--		SET MaterialColorID = d.MaterialColorId
--		FROM dbo.pStyleColorwayItem 
--			INNER JOIN dbo.pStyleMaterials  b ON pStyleColorwayItem.StyleMaterialID =  b.StyleMaterialID 
--			INNER JOIN pMaterialLinkColorway c ON c.MaterialColorID = @MaterialColorID -- parent color
--			INNER JOIN dbo.pMaterialLinkColorwayItem  d ON d.MaterialLinkColorwayID = c.MaterialLinkColorwayID
--				AND d.MaterialLinkID = b.MaterialLinkID
--		WHERE b.MultiMaterialParentID = @StyleMaterialID -- StyleMaterial Parent
--		AND pStyleColorwayItem.StyleColorID = @StyleColorID -- Style Colorway
	
--	END 

--	SET @ROWID = @ROWID + 1 
--END 






--****
--** Insert Log 
--****
IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-000000000000'
BEGIN 

	--Get New value 
	SELECT @AfterValue = a.MaterialColorID, @AfterText = '(' + ISNULL(b.ColorCode,'') + ') ' + ISNULL(b.ColorName,'')
	FROM dbo.pMaterialColor a WITH (NOLOCK)  
		INNER JOIN dbo.pColorPalette b WITH (NOLOCK)  ON b.ColorPaletteID =  a.ColorPaletteID
	WHERE a.MaterialColorID = @MaterialColorID

	IF @AfterValue IS NULL	
		SET @AfterText = NULL
		

	SET @ROWID = 1
	SELECT @TOTAL = COUNT(*) FROM #tmp 

	WHILE @ROWID <= @TOTAL	
	BEGIN

		SET @ChangeLogID =  NEWID()	
		
		SELECT @StyleColorItemID = StyleColorItemID,
			@BeforeValue = MaterialColorID,
			@BeforeText = '(' + ColorCode + ') ' + ColorName 
		FROM #tmp WHERE ROWID = @ROWID 
		
		IF @BeforeValue IS NULL 
			SET @BeforeText = NULL


		--** Log change
		INSERT INTO pChangeLog ( 
			ChangeLogID
			,ChangeTransID
			,ChangeTableID
			,ChangeTablePKID
			,ChangeUserID
			,ChangeUserName
			,changedate
			,ChangeSort
		)
		VALUES(
			@ChangeLogID
			,@ChangeTransID
			,'00000001-C1CC-DF11-AF06-005056C00008'
			,@StyleColorItemID 
			,@ChangeTransUserID
			,@MUser
			,@MDate
			,'0000'
		)
		
		INSERT INTO pChangeLogItem(
			ChangeLogItemID
			,ChangeTransID
			,ChangeLogID
			,ChangeFieldName
			,ChangeFieldAlias
			,ChangeBeforeValue
			,ChangeAfterValue
			,ChangeBeforeText
			,ChangeAfterText
			,ChangeSort)
		VALUES (
			NEWID()
			,@ChangeTransID
			,@ChangeLogID
			,'MaterialColorID'
			,'MaterialColorID'
			,@BeforeValue
			,@Aftervalue
			,@BeforeText
			,@AfterText
			,'0001')
				

		SET @ROWID = @ROWID + 1 
	END 

END 


	
DROP TABLE #tmp


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_BodyHeaderCopy_INSERT]'
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[spx_BodyHeaderCopy_INSERT]      
(      
@BodyID uniqueidentifier,      
@NewBodyID uniqueidentifier,      
@DesignSketchID uniqueidentifier,      
@DesignSketchVersion varchar(5),        
@CreatedBy nvarchar(200),      
@CreatedDate datetime      
)      
AS      
      
SET NOCOUNT ON      
      
BEGIN      
 INSERT INTO pBody      
  (BodyID,BodyTypeID,BodySet,BodyNo,BodyWorkflowID,Description,TempID,TempNo,StyleCategory,SizeClass,SizeRange,POMTempID,    
POMTempItemID,Season,Year,ImageID,ImageVersion,PC1,PC2,PC3,PC4,Active,CUser,CDate,MUser,MDate,POMTempID1,POMTempID2,POMTempID3,POMTempID4,WashType     
  )      
 SELECT     @NewBodyID,BodyTypeID,BodySet,BodyNo,BodyWorkflowID,Description,TempID,TempNo,StyleCategory,SizeClass,SizeRange,POMTempID,    
POMTempItemID,Season,Year,@DesignSketchID,@DesignSketchVersion,PC1,PC2,PC3,PC4,Active,CUser,CDate,MUser,MDate,POMTempID1,POMTempID2,POMTempID3,POMTempID4,WashType        
 FROM  pBody WITH (NOLOCK)      
 WHERE BodyID = @BodyID      
END        
    
BEGIN      
      
 INSERT INTO pBodyImage      
 (BodyID,SpecSketchID1,SpecSketchVersion1,SpecSketchID2,SpecSketchVersion2,SpecSketchID3,SpecSketchVersion3,SpecSketchID4,SpecSketchVersion4)      
 SELECT @NewBodyID,SpecSketchID1,SpecSketchVersion1,SpecSketchID2,SpecSketchVersion2,SpecSketchID3,SpecSketchVersion3,SpecSketchID4,SpecSketchVersion4     
 FROM pBodyImage WITH (NOLOCK)      
 WHERE BodyID = @BodyID      
      
END      
    
      
BEGIN      
      
DECLARE @BodyworkflowID uniqueidentifier  
Set  @BodyworkflowID = newid()  
  
 INSERT INTO pBodyWorkflow      
 (BodyworkflowID,BodyID,BodySet,WorkflowID,WorkDate,WorkStart,WorkDue,WorkAssignedTo,WorkStatus,WorkSort,CUser,CDate,MUser,MDate,WorkDay)      
 SELECT NEWID(), @NewBodyID As BodyID,BodySet,WorkflowID,WorkDate,WorkStart,WorkDue,WorkAssignedTo,WorkStatus,WorkSort,@CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate ,WorkDay     
 FROM  pBodyWorkflow WITH (NOLOCK)      
 WHERE BodyID = @BodyID     
  
END      
      
      
      
BEGIN      
    

 INSERT INTO [pBodyPatternSheetModel]      
 ([ID],[BodyID],[StyleID],[StyleSet],[Model_Code],[Model_Name],[Last_Updated],[Active],[IsLinkedBF],[IsLinked],[CDate],[CUser],[MUser],[MDate],[Marker_Code],[Model_Description],[Model_CrOpId],[Model_Create],[Model_RevOp1],[Model_Rev1],[Model_SampleSize],[Model_nMaterials],[Model_nPieces],[Model_nSizes],[Model_Image_Name],[Model_Comments],[PreferMetric])      
 SELECT newid(), @NewBodyID As BodyID,[StyleID],[StyleSet],[Model_Code],[Model_Name],[Last_Updated],[Active],[IsLinkedBF],[IsLinked],@CreatedDate AS [CDate],@CreatedBy AS [CUser],@CreatedBy AS [MUser], @CreatedDate AS [MDate],[Marker_Code],[Model_Description],[Model_CrOpId],[Model_Create],[Model_RevOp1],[Model_Rev1],[Model_SampleSize],[Model_nMaterials],[Model_nPieces],[Model_nSizes],[Model_Image_Name],[Model_Comments],[PreferMetric]
 FROM  [pBodyPatternSheetModel] WITH (NOLOCK)      
 WHERE BodyID = @BodyID     
  
END  
      
BEGIN      
      
 
 INSERT INTO [pBodyMarker]      
 ([ID],[BodyID],[StyleID],[Marker_Code],[Marker_Name],[Location],[Last_Updated],[IsActive],[IsLinkedBF],[IsLinked],[Usage],[LossFactor],[LossFactor_pct],[TotalUsage],[AdjustedUsage],[Marker_Description],[Marker_CrOpId],[Marker_Create],[Marker_RevOp1],[CDate],[CUser],[MUser],[MDate],[Marker_Rev1],[Marker_RevOp2],[Marker_Rev2],[Marker_Width],[Marker_Length],[Marker_Total_Perim],[Marker_Total_Area],[Marker_Goal],[Marker_Efficiency],[Marker_Notches],[Marker_Drillholes],[Marker_Corners],[Marker_Message],[Marker_nModels],[Marker_nPieces],[Marker_PlacPieces],[Marker_nSizes],[Marker_nBundles],[Marker_Plac_Bndl],[Marker_Bias],[Marker_Flip],[Marker_Nap],[Marker_NCEdits],[Marker_Spread],[Marker_Closed],[Marker_DieBlk],[Marker_Tubular],[Marker_StripePlaid],[Marker_nStripes],[Marker_nPlaids],[Marker_5_Star],[Marker_Max_Splice],[Marker_nSplices],[Marker_XVariance],[Marker_YVariance],[Marker_Image_SN],[Marker_Image_Name],[Marker_Comments],[CADCatId],[Category],[SubCat],[SubCatType],[Class],[UserDefined1],[UserDefined2],[UserDefined3],[UserDefined4],[UserDefined5],[PreferMetric],[IsCosting],[IsApproved],[Sizes],[EfficiencyType],[LastCADRefresh],[PlotFileLocation],[NotchFile],[AnnotationFile],[StorageType],[mMarker_Width],[mMarker_Length],[mMarker_Total_Perim],[mMarker_Total_Area],[Yield_per_Bundle],[Yield_per_Dozen],[mYield_per_Bundle],[mYield_per_Dozen],[ImageID],[IsForAveraging],[StyleSet])      
 SELECT newid(), @NewBodyID As BodyID,[StyleID],[Marker_Code],[Marker_Name],[Location],[Last_Updated],[IsActive],[IsLinkedBF],[IsLinked],[Usage],[LossFactor],[LossFactor_pct],[TotalUsage],[AdjustedUsage],[Marker_Description],[Marker_CrOpId],[Marker_Create],[Marker_RevOp1],@CreatedDate AS [CDate],@CreatedBy AS [CUser],@CreatedBy AS [MUser], @CreatedDate AS [MDate],[Marker_Rev1],[Marker_RevOp2],[Marker_Rev2],[Marker_Width],[Marker_Length],[Marker_Total_Perim],[Marker_Total_Area],[Marker_Goal],[Marker_Efficiency],[Marker_Notches],[Marker_Drillholes],[Marker_Corners],[Marker_Message],[Marker_nModels],[Marker_nPieces],[Marker_PlacPieces],[Marker_nSizes],[Marker_nBundles],[Marker_Plac_Bndl],[Marker_Bias],[Marker_Flip],[Marker_Nap],[Marker_NCEdits],[Marker_Spread],[Marker_Closed],[Marker_DieBlk],[Marker_Tubular],[Marker_StripePlaid],[Marker_nStripes],[Marker_nPlaids],[Marker_5_Star],[Marker_Max_Splice],[Marker_nSplices],[Marker_XVariance],[Marker_YVariance],[Marker_Image_SN],[Marker_Image_Name],[Marker_Comments],[CADCatId],[Category],[SubCat],[SubCatType],[Class],[UserDefined1],[UserDefined2],[UserDefined3],[UserDefined4],[UserDefined5],[PreferMetric],[IsCosting],[IsApproved],[Sizes],[EfficiencyType],[LastCADRefresh],[PlotFileLocation],[NotchFile],[AnnotationFile],[StorageType],[mMarker_Width],[mMarker_Length],[mMarker_Total_Perim],[mMarker_Total_Area],[Yield_per_Bundle],[Yield_per_Dozen],[mYield_per_Bundle],[mYield_per_Dozen],[ImageID],[IsForAveraging],[StyleSet]
 FROM  [pBodyMarker] WITH (NOLOCK)      
 WHERE BodyID = @BodyID     
  
END   
/**************************************************************************************************************************************************************************************************************************************************************
  
    
*****************************************************      
-- INSERT LOG RECCORD       
***************************************************************************************************************************************************************************************************************************************************************
  
    
****************************************************/      
DECLARE @BodyNo NVARCHAR(20)      
DECLARE @Description NVARCHAR (4000)      
      
SELECT @BodyNo  = BodyNo        
FROM pBody WITH (NOLOCK) WHERE BodyID = @BodyID       
      
SET  @Description  = 'Body copied from body with BodyNo: '  +  @BodyNo        
       
INSERT INTO pBodyChange (BodyChangeID ,  BodyStatus ,  WorkflowID , BodyID , BodySet ,  BodyChangeNotifyTo , BodyChangeType,       
BodyChangeDescription ,  BodyChangeBy, BodyChangeDate,  ActiveID ,  Active  )       
VALUES  ( NEWID() ,   0 , '11111111-0000-0000-0000-000000000001' , @NewBodyID , 0 ,  '' , 'Information', @Description ,      
@CreatedBy,  @CreatedDate ,  '00000000-0000-0000-0000-000000000000'  , 1 ) 
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_SampleWorkflowItem_SELECT_1]'
GO
SET QUOTED_IDENTIFIER OFF
GO


ALTER PROCEDURE [dbo].[spx_SampleWorkflowItem_SELECT_1] 
(@UserID nvarchar(5))
AS

DECLARE @sql varchar(8000), @delim varchar(1), @select varchar(8000), @enddate varchar(100), @duedate varchar(100), @pivot varchar(100), @table varchar(100)
SET NOCOUNT ON

SELECT @select = 'SELECT dbo.pSampleRequestWorkflow.StyleID, dbo.pStyleHeader.StyleNo AS [Style No], dbo.pStyleHeader.Description, 
CASE 
WHEN pSampleRequestWorkflow.StyleSet = 1 THEN 
	CASE WHEN dbo.pStyleHeader.PC1 Is Not Null THEN dbo.pStyleHeader.PC1 ELSE ''1st Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 2 THEN 
	CASE WHEN dbo.pStyleHeader.PC2 Is Not Null THEN dbo.pStyleHeader.PC2 ELSE ''2nd Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 3 THEN 
	CASE WHEN dbo.pStyleHeader.PC3 Is Not Null THEN dbo.pStyleHeader.PC3 ELSE ''3rd Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 4 THEN 
	CASE WHEN dbo.pStyleHeader.PC4 Is Not Null THEN dbo.pStyleHeader.PC4 ELSE ''4th Set'' END
END AS [Style Set] FROM  dbo.pSampleRequestWorkflow WITH (NOLOCK) 
INNER JOIN dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID 
GROUP BY dbo.pSampleRequestWorkflow.StyleID, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.Description, dbo.pSampleRequestWorkflow.StyleSet, 
dbo.pStyleHeader.PC1, dbo.pStyleHeader.PC2, dbo.pStyleHeader.PC3, dbo.pStyleHeader.PC4,pSampleRequestWorkflow.UserID
HAVING pSampleRequestWorkflow.UserID = ' + @UserID + ' ORDER BY dbo.pStyleHeader.StyleNo, dbo.pSampleRequestWorkflow.StyleSet'

--SELECT @enddate = 'MAX((CONVERT(datetime, CONVERT(varchar, dbo.pSampleRequestWorkflow.EndDate, 101))))'
--SELECT @duedate = 'MAX((CONVERT(datetime, CONVERT(varchar, dbo.pSampleRequestWorkflow.DueDate, 101))))'

SELECT @enddate = 'MAX(dbo.pSampleRequestWorkflow.EndDate)'
SELECT @duedate = 'MAX(dbo.pSampleRequestWorkflow.DueDate)'
SELECT @pivot = 'dbo.pSampleRequestWorkflow.SampleWorkflowID'
SELECt @table = 'pSampleRequestWorkflow WITH (NOLOCK)'

EXEC ('SELECT ' + @pivot + ' AS pivot INTO ##SampleWorkflow FROM ' + @table + ' WHERE 1=2')
EXEC ('INSERT INTO ##SampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE ' 
+ @pivot + ' Is Not Null')


SELECT @sql='',  @duedate=stuff(@duedate, len(@duedate), 1, ' END)' )
SELECT @sql=@sql + '',  @enddate=stuff(@enddate, len(@enddate), 1, ' END)' )

SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
WHEN 0 THEN '''' ELSE '''' END 
FROM tempdb.information_schema.columns 
WHERE table_name='##SampleWorkflow' AND column_name='pivot'

SELECT @sql=@sql + '''D_' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@duedate,charindex( '(', @duedate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
+ '''E_' + convert(varchar(100), @pivot) + ''' = ' + 
stuff(@enddate,charindex( '(', @enddate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
FROM ##SampleWorkflow

SELECT @sql=left(@sql, len(@sql)-1)

SELECT @select=stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')

DROP TABLE ##SampleWorkflow

EXEC (@select)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_SampleRequestGrid_Tables_SELECT]'
GO

ALTER  PROCEDURE [dbo].[spx_SampleRequestGrid_Tables_SELECT] (  
@TradePartnerID nvarchar(50),  
@sqlSelect varchar(8000) = NULL,  
@TeamID varchar (50) = NULL   
)  
AS  
  
  
CREATE TABLE #SampleRequestTrade (  
SampleRequestTradeID UNIQUEIDENTIFIER ,   
StyleSet INT  
)  
  
  
DECLARE @SQL AS NVARCHAR(4000)   
SET @SQL  = 'INSERT INTO #SampleRequestTrade ( SampleRequestTradeID, StyleSet  )  
SELECT a.SampleRequestTradeID, a.StyleSet   
FROM pSampleRequestWorkflow a INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID   
WHERE 1=1   
'  
  
  
IF @TradePartnerID IS NOT NULL   
 SET @SQL  = @SQL  + ' AND a.TradePartnerID = ''' + @TradePartnerID  + ''''  
IF @sqlSelect IS NOT NULL  
 SET @SQL  = @SQL  + ' AND a.SampleRequestTradeID IN (' + @sqlSelect + ') '  
IF @TeamID IS NOT NULL    
 SET @SQL  = @SQL  + ' AND b.StyleType IN  (  SELECT StyleTypeID FROM sAccessStyleFolder WHERE TeamId = ''' +  CAST (@TeamID AS NVARCHAR(50))  + ''' AND (AccessRoleId = 3 OR AccessView = 1) ) '   
SET @SQL  = @SQL  + ' GROUP BY  a.SampleRequestTradeID, a.StyleSet  '  
EXEC (@SQL)  
  
  
SET @SQL  ='  
 SELECT a.SampleRequestTradeID  , b.VendorName  , c.Description ,   
 CASE   
  WHEN FOO.StyleSet = 1 THEN   
   CASE WHEN c.PC1 Is Not Null THEN c.PC1 ELSE ''1st Set'' END  
  WHEN FOO.StyleSet = 2 THEN   
   CASE WHEN c.PC2 Is Not Null THEN c.PC2 ELSE ''2nd Set'' END  
  WHEN FOO.StyleSet = 3 THEN   
   CASE WHEN c.PC3 Is Not Null THEN c.PC3 ELSE ''3rd Set'' END  
  WHEN FOO.StyleSet = 4 THEN   
   CASE WHEN c.PC4 Is Not Null THEN c.PC4 ELSE ''4th Set'' END   
 END AS StyleSetName , FOO.StyleSet , d.TradePartnerName ,  
 ISNULL(e.MainColor,''NA'') AS Color ,  c.StyleNo , c.DueDate as TechPack , c.SizeClass , a.TechPackID, c.SizeRange  
 FROM pSampleRequestTrade a  
 INNER JOIN  #SampleRequestTrade FOO ON a.SampleRequestTradeID = FOO.SampleRequestTradeID  
 INNER JOIN uTradePartnerVendor b ON a.TradePartnerVendorID =  b.TradePartnerVendorID  
 INNER JOIN pStyleHeader c ON a.StyleID = c.StyleID  
 INNER JOIN uTradePartner d ON a.TradePartnerID =  d.TradePartnerID  
 LEFT OUTER JOIN pStyleColorway e ON a.StyleColorID  = e.StyleColorID   
'  
IF @TradePartnerID IS NOT NULL   
 SET @SQL  = @SQL  + ' WHERE a.TradePartnerID = ''' + @TradePartnerID + '''  '  
   
SET @SQL  = @SQL  +  ' ORDER BY VendorName, StyleNo, FOO.StyleSet , Color  '  
  
EXEC (@SQL)  
  
  
  
SET @SQL  = 'SELECT DISTINCT a.SampleWorkflowID, c.SampleWorkflow , c.SampleWorkflowSort  
  FROM pSampleRequestWorkflow a  
  INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID   
  INNER JOIN pSampleWorkflow c ON a.SampleWorkflowID  =  c.SampleWorkflowID  
  '  
IF @TeamID  IS  NOT NULL   
 SET @SQL  = @SQL  +  ' WHERE a.SampleWorkflowID IN  (   
   SELECT SampleTypeId from sAccessSampleFolder WHERE TeamId = ''' + @TeamID  + ''' AND (AccessRoleId=3 OR AccessView=1 )   
  )  
  '   
SET @SQL  = @SQL  +  ' ORDER BY c.SampleWorkflowSort ;    
  
  SELECT a.SampleWorkflowID, a.SampleRequestTradeID , a.Submit, a.EndDate , a.DueDate, a.Status,   
  a.StyleSet, c.ApprovedType  
  FROM pSampleRequestWorkflow a  
  INNER JOIN #SampleRequestTrade b ON a.SampleRequestTradeID = b.SampleRequestTradeID AND a.StyleSet  = b.StyleSet  
  INNER JOIN pSampleRequestSubmitStatus c ON  c.StatusID = a.Status  
  '   
  
IF @TeamID IS NOT NULL   
 SET @SQL  = @SQL  +  ' WHERE a.SampleWorkflowID IN  (   
   SELECT SampleTypeId from sAccessSampleFolder WHERE TeamId = ''' + @TeamID  + '''  AND (AccessRoleId=3 OR AccessView=1 )   
  ) '  
EXEC (@SQL)  
   
DROP TABLE #SampleRequestTrade   
  
  
  
  
  
set ANSI_NULLS ON  
set QUOTED_IDENTIFIER ON  

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[spx_SampleRequestGridAgentShared_SELECT_NEW]'
GO

ALTER PROCEDURE [dbo].[spx_SampleRequestGridAgentShared_SELECT_NEW] 
(
@TradePartnerID nvarchar(50),
@StyleNo nvarchar(200) = NULL,
@StyleDescription nvarchar(200) = NULL,
@sqlSelect varchar(8000) = NULL
)
AS

DECLARE @UserID varchar(10), @sql varchar(8000), @delim varchar(1), @select varchar(8000), @enddate varchar(100), @duedate varchar(100), @pivot varchar(100), @table varchar(100)

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

SELECT @select = 'SELECT TOP 100  uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,  pSampleRequestWorkflow.SampleRequestTradeID, 
	pSampleRequestWorkflow.StyleColorID, pSampleRequestWorkflow.StyleID, 
	pSampleRequestWorkflow.StyleSet, pStyleHeader.StyleNo AS [Style No], 
	pStyleHeader.SizeRange AS [Size], pStyleHeader.Description, 
CASE 
WHEN pSampleRequestWorkflow.StyleSet = 1 THEN 
	CASE WHEN pStyleHeader.PC1 Is Not Null THEN pStyleHeader.PC1 ELSE ''1st Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 2 THEN 
	CASE WHEN pStyleHeader.PC2 Is Not Null THEN pStyleHeader.PC2 ELSE ''2nd Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 3 THEN 
	CASE WHEN pStyleHeader.PC3 Is Not Null THEN pStyleHeader.PC3 ELSE ''3rd Set'' END
WHEN pSampleRequestWorkflow.StyleSet = 4 THEN 
	CASE WHEN pStyleHeader.PC4 Is Not Null THEN pStyleHeader.PC4 ELSE ''4th Set'' END 
END AS [Style Set], pStyleColorway.MainColor AS Color FROM pSampleRequestWorkflow INNER JOIN
	pStyleHeader ON pSampleRequestWorkflow.StyleID = pStyleHeader.StyleID LEFT OUTER JOIN
	pStyleColorway ON pSampleRequestWorkflow.StyleColorID = pStyleColorway.StyleColorID INNER JOIN
	pSampleRequestTrade ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID

	INNER JOIN  uTradePartner ON pSampleRequestWorkflow.TradePartnerID =  uTradePartner.TradePartnerID INNER JOIN
	uTradePartnerVendor ON  pSampleRequestWorkflow.TradePartnerVendorID =  uTradePartnerVendor.TradePartnerVendorID

GROUP BY pSampleRequestWorkflow.SampleRequestTradeID, pSampleRequestWorkflow.StyleID, pSampleRequestWorkflow.StyleColorID, 
   pSampleRequestWorkflow.StyleSet, pStyleHeader.StyleNo, pStyleHeader.SizeRange, pStyleHeader.Description, 
   pSampleRequestWorkflow.StyleSet, pStyleHeader.Pc1, pStyleHeader.Pc2, pStyleHeader.Pc3, pStyleHeader.Pc4, 
   pSampleRequestWorkflow.TradePartnerID, pStyleColorway.MainColor, pSampleRequestTrade.SampleRequestShare,

   uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName	

HAVING pSampleRequestWorkflow.TradePartnerID = ''' + @TradePartnerID + ''' AND (pSampleRequestTrade.SampleRequestShare = 1) AND
	pSampleRequestWorkflow.SampleRequestTradeID IN (' + @sqlSelect + ')'

--IF @StyleNo IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.StyleNo LIKE ''%' + @StyleNo + '%''' 
--IF @StyleDescription IS NOT NULL SELECT @select = @select + ' AND pStyleHeader.Description LIKE ''%' + @StyleDescription + '%''' 

SELECT @select = @select + ' ORDER BY pStyleHeader.StyleNo, pSampleRequestWorkflow.StyleSet '

SELECT @enddate = 'MAX(pSampleRequestWorkflow.EndDate)'
SELECT @duedate = 'MAX(pSampleRequestWorkflow.DueDate)'
SELECT @pivot = 'pSampleRequestWorkflow.SampleWorkflowID'
SELECt @table = 'pSampleRequestWorkflow'

--PRINT ('SELECT ' + @pivot + ' AS pivot INTO ##tmpSampleWorkflow FROM ' + @table + ' WHERE 1=2')
EXEC ('SELECT ' + @pivot + ' AS pivot INTO ##tmpSampleWorkflow FROM ' + @table + ' WHERE 1=2 AND SampleRequestTradeID IN (' + @sqlSelect + ')')

--PRINT ('INSERT INTO ##tmpSampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE TradePartnerID = ''{' + @TradePartnerID + '}''' + ' AND ' + @pivot + ' Is Not Null')
EXEC ('INSERT INTO ##tmpSampleWorkflow SELECT DISTINCT ' + @pivot + ' FROM ' + @table + ' WHERE SampleRequestTradeID IN (' + @sqlSelect + ')' + ' AND ' + @pivot + ' Is Not Null')

SELECT @sql='',  @duedate=stuff(@duedate, len(@duedate), 1, ' END)' )
SELECT @sql=@sql + '',  @enddate=stuff(@enddate, len(@enddate), 1, ' END)' )

SELECT @delim=CASE Sign( CharIndex('char', data_type) + CharIndex('date', data_type) ) 
	WHEN 0 THEN '''' ELSE '''' END 
	FROM tempdb.information_schema.columns 
WHERE table_name='##tmpSampleWorkflow' AND column_name='pivot'

SELECT @sql=@sql + '''D_' + convert(varchar(100), @pivot) + ''' = ' + 
	stuff(@duedate,charindex( '(', @duedate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
	+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
	+ '''E_' + convert(varchar(100), @pivot) + ''' = ' + 
	stuff(@enddate,charindex( '(', @enddate )+1, 0, ' CASE ' + @pivot + ' WHEN ' 
	+ @delim + convert(varchar(100), @pivot) + @delim + ' THEN ' ) + ', ' 
FROM ##tmpSampleWorkflow

IF @sql is not null AND LEN(@SQL) > 0
begin 
	SELECT @sql=left(@sql, len(@sql)-1)
	SELECT @select=stuff(@select, charindex(' FROM ', @select)+1, 0, ', ' + @sql + ' ')
end 

DROP TABLE ##tmpSampleWorkflow

-- PRINT (@select)
EXEC (@select)

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_StyleSourcingItemsLogic_UPDATE]'
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.spx_StyleSourcingItemsLogic_UPDATE(
	@StyleSourcingID UNIQUEIDENTIFIER,
	@StyleColorID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS

DECLARE @dummy INT

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[spx_StyleQuoteItemTPVReplace_SELECT]'
GO

CREATE PROCEDURE dbo.spx_StyleQuoteItemTPVReplace_SELECT(
	@TradePartnerID UNIQUEIDENTIFIER,
	@StyleQuoteID UNIQUEIDENTIFIER, 
	@StyleID UNIQUEIDENTIFIER, 
	@search NVARCHAR(MAX)
)
AS 


	DECLARE @SQL NVARCHAR(MAX)
	
	SET @SQL = 'SELECT TradePartnerVendorID, TradePartnerID, VendorCode, VendorName, City, State, Country, Active 
        FROM dbo.uTradePartnerVendor WHERE '

	IF LEN ( ISNULL(@search,'') ) > 0 
	BEGIN 
	
    SET @SQL =  @SQL  + ' (
			VendorCode LIKE ''' + @search + '%'' OR 
			VendorName LIKE ''' + @search + '%'' OR 
            City LIKE  ''' + @search + '%'' OR 
            State LIKE ''' + @search + '%'' OR 
            Country LIKE ''' + @search + '%'' ) AND '
        
	END 
    
    SET @SQL =  @SQL  + ' (Active = 1) AND  (TradePartnerID = ''' + CAST(@TradePartnerID AS NVARCHAR(40)) + ''' ) 
		AND (TradePartnerVendorId NOT IN (SELECT TradePartnerVendorId FROM pStyleQuoteItem 
        WHERE styleQuoteID = ''' + CAST(@StyleQuoteID AS NVARCHAR(40))  + ''' AND StyleId = ''' + CAST(@StyleId AS NVARCHAR(40)) +  ''' ))
        ORDER BY VendorCode, VendorName '
        
     EXECUTE sp_executesql  @SQL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO

--
-- End of Stored Procedures
--


--
-- Initial data changes
--


UPDATE pSampleWorkflow set GroupName = '-ProtoType'
WHERE SampleWorkflowID = '90A'
AND SampleWorkflow = 'Proto Meas Sample'
AND WorkflowID = '40000000-0000-0000-0000-000000000050'
GO

UPDATE pSampleWorkflow set GroupName = '-Pre Production'
WHERE SampleWorkflowID = '91A'
AND SampleWorkflow = 'PP Meas Sample'
AND WorkflowID = '40000000-0000-0000-0000-000000000050'
GO

UPDATE pSampleWorkflow set GroupName = '-Sales Sample'
WHERE SampleWorkflowID = '92A'
AND SampleWorkflow = 'Ship Meas Sample'
AND WorkflowID = '40000000-0000-0000-0000-000000000050'
GO

UPDATE pSampleWorkflow set GroupName = '-TOP of Production'
WHERE SampleWorkflowID = '93A'
AND SampleWorkflow = 'Top Meas Sample'
AND WorkflowID = '40000000-0000-0000-0000-000000000050'
GO

UPDATE pSampleWorkflow set GroupName = '-Fit Sample'
WHERE SampleWorkflowID = '94A'
AND SampleWorkflow = 'Fit Meas Sample'
AND WorkflowID = '40000000-0000-0000-0000-000000000050'
GO

UPDATE pBodyType
SET BodyGridItem = 'Body_GridItem_Apparel.xml'
WHERE BodyTypeId = 10
GO

IF EXISTS(SELECT SampleWorkflow FROM psampleworkflow WHERE SampleWorkflow='QA Meas Worksheet')
   BEGIN
        PRINT 'QA Meas Worksheet bubble already exists'
   END
ELSE
  BEGIN
	Insert into psampleworkflow values('95A', 'QA Meas Worksheet',    '40000000-0000-0000-0000-000000000050',    'A'   ,'QA Meas Worksheet',     '21', 'Yes',      NULL, NULL  ,NULL,      NULL      ,'015',     0, NEWID())
  END
  
GO

Update pWorkflowTemplate set Body = 1 Where TemplateName = 'Body'
GO

Delete FROM pWorkflowTemplateItem 
where WorkflowTemplateID in (select WorkflowTemplateID from pWorkflowTemplate where Body = 0)
AND WorkflowID in ('11111111-0000-0000-0000-000000000002','11111111-0000-0000-0000-000000000003','11111111-0000-0000-0000-000000000004')
GO

begin
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Body Workflow')
	begin
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,ControlPanelTypeID,ControlPanelUrl) 
		SELECT COALESCE(MAX(ControlPanelID),0) + 1,'Body Workflow','Body Workflow',COALESCE(MAX(ControlPanelOrder),0) + 1,'pWorkflowTemplate','Control_Workflow_Default.xml','0280d7a7-5c44-e011-b0b2-001e4fc593fc','Control_Workflow_List.aspx?ISBDY=1&CPID=' + convert(varchar(12),COALESCE(MAX(ControlPanelID),0) + 1)
		From pControlPanel
	end
end
GO

update pWorkflow set Active = 0
where WorkflowID in ('40000000-0000-0000-0000-000000000012','40000000-0000-0000-0000-000000000014','40000000-0000-0000-0000-000000000015',
'50000000-0000-0000-0000-000000000050','50000000-0000-0000-0000-000000000051','50000000-0000-0000-0000-000000000052','50000000-0000-0000-0000-000000000053',
'50000000-0000-0000-0000-000000000054','50000000-0000-0000-0000-000000000055','50000000-0000-0000-0000-000000000056','50000000-0000-0000-0000-000000000057')
GO


UPDATE pBodyType
SET BodyGridItem = 'Body_GridItem_Apparel.xml'
WHERE BodyTypeId = 10
GO


IF EXISTS(SELECT SampleWorkflow FROM psampleworkflow WHERE SampleWorkflow='QA Meas Worksheet')
   BEGIN
        PRINT 'QA Meas Worksheet bubble already exists'
   END
ELSE
  BEGIN
	Insert into psampleworkflow values('95A', 'QA Meas Worksheet',    '40000000-0000-0000-0000-000000000050',    'A'   ,'-QA Meas Worksheet',     '21', 'Yes',      NULL, NULL  ,NULL,      NULL      ,'015',     0, NEWID())
  END
  
GO

IF not EXISTS(SELECT CultureIndentifierID FROM sSystemCulture WHERE CultureIndentifierID='0x0408')  
  BEGIN
	INSERT INTO sSystemCulture
			   (CultureIndentifierID
			   ,CultureName
			   ,CultureCountry
			   ,CultureLanguage
			   ,Active
			   ,Unicode
			   ,DecimalValidationRegEx
			   ,DateValidationRegEx
			   ,CurrencyValidationRegEx
			   ,DateShortFormat
			   ,DateLongFormat
			   ,TimeShortFormat
			   ,TimeLongFormat
			   ,NumberDecimalSymbol
			   ,NumberDigitGroupingSymbol
			   ,CurrencySymbol
			   ,CurrencyDecimalSymbol
			   ,CurrencyDigitGroupingSymbol
			   ,DateTimeShortFormat
			   ,DateTimeLongFormat
			   ,CurrencyFormat
			   ,PercentFormat
			   ,PercentValidationRegEx
			   ,DecimalFormat
			   ,SystemCultureId)
		 VALUES
			   ('0x0408'
			   ,'el-GR'
			   ,'Greece'
			   ,'Greek'
			   ,1
			   ,0
			   ,'[0-9]+[.,]?[0-9]*'
			   ,'^(?=\d)(?:(?!(?:(?:0?[5-9]|1[0-4])(?:\.|-|\/)10(?:\.|-|\/)(?:1582))|(?:(?:0?[3-9]|1[0-3])(?:\.|-|\/)0?9(?:\.|-|\/)(?:1752)))(31(?!(?:\.|-|\/)(?:0?[2469]|11))|30(?!(?:\.|-|\/)0?2)|(?:29(?:(?!(?:\.|-|\/)0?2(?:\.|-|\/))|(?=\D0?2\D(?:(?!000[04]|(?:(?:1[^0-6]|[2468][^048]|[3579][^26])00))(?:(?:(?:\d\d)(?:[02468][048]|[13579][26])(?!\x20BC))|(?:00(?:42|3[0369]|2[147]|1[258]|09)\x20BC))))))|2[0-8]|1\d|0?[1-9])([-.\/])(1[012]|(?:0?[1-9]))\2((?=(?:00(?:4[0-5]|[0-3]?\d)\x20BC)|(?:\d{4}(?:$|(?=\x20\d)\x20)))\d{4}(?:\x20BC)?)(?:$|(?=\x20\d)\x20))?((?:(?:0?[1-9]|1[012])(?::[0-5]\d){0,2}(?:\x20[aApP][mM]))|(?:[01]\d|2[0-3])(?::[0-5]\d){1,2})?$'
			   ,'[0-9]+[,.]?[0-9][0-9]'
			   ,'d'
			   ,'D'
			   ,'t'
			   ,'T'
			   ,','
			   ,'.'
			   ,'€'
			   ,','
			   ,'.'
			   ,'g'
			   ,'G'
			   ,'C'
			   ,'{0:p}'           
			   ,'[0-9]+[.]?[0-9]*'
			   ,'0.000'
			   ,NEWID())
	END


IF not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sSystemButtons' and COLUMN_NAME = N'el_GR')
	BEGIN
		ALTER TABLE sSystemButtons ADD el_GR nvarchar(30) NULL
	END
	
IF not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sSystemStrings' and COLUMN_NAME = N'el_GR')
	BEGIN
		ALTER TABLE sSystemStrings ADD el_GR nvarchar(4000) NULL
	END
	
IF not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sUserStrings' and COLUMN_NAME = N'el_GR')
	BEGIN
		ALTER TABLE sUserStrings ADD el_GR nvarchar(4000) NULL
	END
	
GO

Delete from pSampleWorkflowItemTemplate  where SampleWorkflowID in ('18A','20A','27A')
GO

update pControlPanel
   set ControlPanelTypeID = NULL where ControlPanelName = 'Body Workflow'
GO

Update pSampleWorkflow set Active = 'No' where SampleWorkflowID in ('18A','20A','27A')
GO


IF NOT EXISTS (SELECT * FROM pColorFolder WHERE ColorFolderID = '00000000-0000-0000-0000-000000000001')
	BEGIN
		INSERT INTO pColorFolder (ColorFolderID, ColorFolderDescription, CUser, CDate, MUser, MDate, MChange, Active, StyleColorway, SystemServerStorageID, ColorTypeID)
		VALUES ('00000000-0000-0000-0000-000000000001', 'plmOn Default', 'System', GETUTCDATE(), 'System', GETUTCDATE(), 1, 1, 0, '00000000-0000-0000-0000-000000000001', 0)
	END
	GO

IF not EXISTS(SELECT CultureIndentifierID FROM sSystemCulture WHERE CultureIndentifierID='0x0408')  
  BEGIN
	INSERT INTO sSystemCulture
			   (CultureIndentifierID
			   ,CultureName
			   ,CultureCountry
			   ,CultureLanguage
			   ,Active
			   ,Unicode
			   ,DecimalValidationRegEx
			   ,DateValidationRegEx
			   ,CurrencyValidationRegEx
			   ,DateShortFormat
			   ,DateLongFormat
			   ,TimeShortFormat
			   ,TimeLongFormat
			   ,NumberDecimalSymbol
			   ,NumberDigitGroupingSymbol
			   ,CurrencySymbol
			   ,CurrencyDecimalSymbol
			   ,CurrencyDigitGroupingSymbol
			   ,DateTimeShortFormat
			   ,DateTimeLongFormat
			   ,CurrencyFormat
			   ,PercentFormat
			   ,PercentValidationRegEx
			   ,DecimalFormat
			   ,SystemCultureId)
		 VALUES
			   ('0x0408'
			   ,'el-GR'
			   ,'Greece'
			   ,'Greek'
			   ,1
			   ,0
			   ,'[0-9]+[.,]?[0-9]*'
			   ,'^(?=\d)(?:(?!(?:(?:0?[5-9]|1[0-4])(?:\.|-|\/)10(?:\.|-|\/)(?:1582))|(?:(?:0?[3-9]|1[0-3])(?:\.|-|\/)0?9(?:\.|-|\/)(?:1752)))(31(?!(?:\.|-|\/)(?:0?[2469]|11))|30(?!(?:\.|-|\/)0?2)|(?:29(?:(?!(?:\.|-|\/)0?2(?:\.|-|\/))|(?=\D0?2\D(?:(?!000[04]|(?:(?:1[^0-6]|[2468][^048]|[3579][^26])00))(?:(?:(?:\d\d)(?:[02468][048]|[13579][26])(?!\x20BC))|(?:00(?:42|3[0369]|2[147]|1[258]|09)\x20BC))))))|2[0-8]|1\d|0?[1-9])([-.\/])(1[012]|(?:0?[1-9]))\2((?=(?:00(?:4[0-5]|[0-3]?\d)\x20BC)|(?:\d{4}(?:$|(?=\x20\d)\x20)))\d{4}(?:\x20BC)?)(?:$|(?=\x20\d)\x20))?((?:(?:0?[1-9]|1[012])(?::[0-5]\d){0,2}(?:\x20[aApP][mM]))|(?:[01]\d|2[0-3])(?::[0-5]\d){1,2})?$'
			   ,'[0-9]+[,.]?[0-9][0-9]'
			   ,'d'
			   ,'D'
			   ,'t'
			   ,'T'
			   ,','
			   ,'.'
			   ,'€'
			   ,','
			   ,'.'
			   ,'g'
			   ,'G'
			   ,'C'
			   ,'{0:p}'           
			   ,'[0-9]+[.]?[0-9]*'
			   ,'0.000'
			   ,NEWID())
	END
GO


UPDATE pGRClassRange
   SET Active = 1
GO

UPDATE pComponentType SET ComponentLinePlanSearchSchema = 'Material_LinePlan_Search_Default.xml'
GO

UPDATE pComponentType SET ComponentLinePlanSchema =  'Material_LinePlan_Default.xml'
GO 

IF EXISTS ( SELECT * FROM pGRCompany Where CUser = 'Yunify')
   BEGIN
        IF NOT EXISTS (SELECT * from pGRPOMAlternates WHERE POMAlternatesId = 'fc6ffd3f-a8e8-4c09-8ab1-009c716de647')

        BEGIN

INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'fc6ffd3f-a8e8-4c09-8ab1-009c716de647', N'961453b4-7d8a-4157-a0f0-71ff09300991', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'd9f354d6-5ab7-42d9-a077-00eb50da74c9', N'5ced1eeb-4c6d-48b1-bcdf-a94da2bae69b', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'918e232b-ce25-4e5f-9566-011d72e5cb31', N'efc6b25d-0db5-4707-a9d0-d553a1ed41d2', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'2e2201a1-2583-4d09-8a75-02fb49d9a4f8', N'd64b38fd-2d30-43f1-97f6-a8105b31183c', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'08c17630-18a1-4e03-be13-037446f5e358', N'9f7b90fc-367d-43ba-aa09-e62221a3053b', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'9055d14e-2314-40f9-92ca-06ea1211b42a', N'6798ae24-d96c-4f3e-afbb-61c85fe8b5b3', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'3b536c36-115f-4126-9b02-07fbffb08449', N'caed1d22-9dfd-4428-8a00-4c5e20000815', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'b9793fe1-ba0d-4dc1-84c1-0ac25e4008ff', N'f926b79b-a08b-46f4-a935-de2cfcdeff61', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'ce211fc5-519a-4951-9ccf-0bc96acf3e3d', N'26e53e0d-2073-4200-baef-b5f943fadc78', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'09bc3513-9e73-48f8-accb-0c5ec7449aef', N'6afcace9-a9e7-4646-b2e5-b1b0992e60a4', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'd859a3a8-5824-4638-b481-142737fd49bb', N'fe56427d-a2b7-49ef-a56d-da5b09cdc369', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'7c700c6e-d994-4dfd-aa6b-168e4a3ad8ef', N'c94fcd6e-1824-4637-afd1-213019975534', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'f51251f0-9aa8-45d9-9501-173a4abc9b80', N'4fff6a37-c607-4da2-ab7d-8b6296f5d24a', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'47bac117-b7fd-4c53-83c2-1b4dd64afb6a', N'f28854ad-2c8b-4afc-b647-6fd0d21ad71b', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'c5de8337-f095-49da-9b03-1cc12dc57651', N'7225221a-9964-4798-8e4d-bf8587a38ff3', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'8ebdd4d9-b384-4cdf-a74a-1ccd7cc57b37', N'5bf182b5-2073-4672-8911-35c0fd19feb8', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'92373f48-fddb-4fd5-9058-1ce115007a9a', N'3ed32a3e-28e1-4f03-9910-d8e35fd2cb4f', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'ad0e9d95-e70a-4f5f-a9c3-1ee21665068f', N'368e39d3-4122-4917-b37e-e3686bbf8a68', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'c503a457-16ae-4064-a29c-236af5f2352c', N'2a87b2f9-68fd-434b-9f49-966ef63b6854', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'1efaefe7-fcfd-40ff-95bf-247e56d5bb91', N'41707e59-922c-4582-aca1-4a5a30db1ec6', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'f805051b-77ff-4a60-861e-254efe27a41b', N'7d930fff-4e4d-44c8-9be8-343e9ed381e3', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'8e1cf564-3c4a-4a3c-acdc-2940d66b83a8', N'555a83df-9e67-417d-88fe-87e8cdc2811a', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'71286b8b-5fc1-41bb-baeb-297fbde25517', N'a746187b-7aaa-4535-8877-ef08725f278e', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'a5f1c3c6-715a-4c73-b3bd-29d96d399bc6', N'4203fae6-bc3b-4098-abc4-11f7c820658b', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'd8d29477-d72a-4688-8246-2c73ce9a756f', N'19acf21d-6181-4364-948a-e08104498a9c', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'a1d7a8ce-2f43-4491-b55f-2e0d58995d15', N'4ab0ab8c-7ac4-4eff-9d07-6d4a4c75643d', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'9efd3df8-1ac5-42d5-804e-2f54e027b6b1', N'4504de57-1270-468b-8e26-f628df64fc91', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'7dbbe840-1ade-43a2-b620-316f617a80f5', N'b1a8c845-fdb4-43a1-9acc-c941f12307f7', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'cc825cf9-d990-43f1-a6a2-32079da105c9', N'a28e887c-22ba-4796-bfe9-1d967131b11f', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'972410df-34c5-402a-b3ce-3219d6bbc585', N'8ecb85c3-78f0-4682-80b4-915d0e57d8e4', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'9cce737d-cb76-4f36-9b21-3231be9c0bec', N'918c33c0-499c-49ca-bf72-f9655325227d', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'17bd3981-eefd-4fc9-a11f-32fe3d3b649d', N'ca3b7d9c-d22d-4367-b784-d03271ed153b', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'b6cf79b2-7321-4ce8-b752-349e27b16a6a', N'9892513c-9e61-412d-8d03-f4f9d80ca028', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'1d0e4b6c-2535-48d5-ab29-3658d84888c1', N'53bef307-37f4-4ed1-8d6a-03cd78d6b218', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'd399703d-dec5-415b-a874-3aa3b2092727', N'3b6a486b-2d2b-4cbb-8061-9f9005f19e8a', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'4bf93b4e-65a1-4709-8aec-3aa595976009', N'b5ff73bb-9b84-4bfd-a664-a876eecfa959', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'1fa43734-523e-4a24-b552-3d6bca322036', N'81aa9cea-4311-4698-975a-ed6489f419f1', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'25467756-7180-49d5-9b31-3ef86331c283', N'40dc70a3-44d6-4d5b-a208-f3856607653c', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'd3317c52-f1c2-4476-a067-430f94300f04', N'ce06801c-7704-4537-99d4-1cea0d3a4eb5', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'7a7b8e40-6116-4c76-b223-44311cc62c9c', N'6747ab45-a068-4621-b212-290654de44d0', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'a01207dd-3d6b-418f-ae2a-44f4165f3878', N'671c1a75-15b9-476c-ad84-968092e06493', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'a5b3e7c9-b77b-4a77-8a0d-4e03560db0b9', N'968f3913-d656-4fbe-ad8c-92c67052e991', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'eb9996a8-70d9-4e9b-a19d-4e15b6d777c2', N'7f16d6ff-125b-4064-be3b-85e43ee91fb8', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'726f32df-c088-462a-b37c-4e6ec4b20dac', N'e8ee757b-7831-4ced-b8b7-15bfb4bcadf9', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'8907c9d1-345c-4990-8279-505c9f340c25', N'c822d790-97fb-4976-9b04-cff118b7e19a', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'c87bc9b4-3c8d-42b7-b7e6-51cbbd261651', N'ba3deded-44e3-4977-a152-8323f0fef192', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'3447f607-a967-489d-8a39-52356d36500b', N'523eb5ab-2be8-4b6c-8049-c29212288376', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'dd7fa53e-eb52-4373-a7a1-529c86e0de9f', N'fe22e1f9-eb9e-47bc-ab3a-e6880d7260a5', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'30f386f4-dd9e-49a1-b0df-53f6f32d10b2', N'99a09840-4e69-4320-aa02-84959c500610', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'68fa3377-9c0b-4374-a2e4-589c2101c260', N'bacfd78f-66b4-498f-b190-5818ff43b715', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'43bd6dad-7a38-4ec4-8004-5a0051ed816c', N'509cd46e-a014-4801-b54c-d68962e4b41f', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'98c6b643-8e4a-4d91-b99a-5c725decb240', N'4ca796f4-8da5-4220-afe3-bf50f5679f95', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'fed6608f-a2ea-4367-83ee-5ce3dd7bbcce', N'69ef5891-47d1-4e5b-83ec-49b65ab6b02d', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'f360670e-c7de-495b-8a7c-60d072c5f7b2', N'10f98418-5ccf-4619-8a80-31f884f954ea', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'3aa04848-7d55-4f76-a5b8-631cf4e2ecc3', N'77ac8228-a80d-4238-a326-acd800959a9f', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'a68fd290-433d-4386-9a20-63ae2f253cf8', N'172fc5a4-8558-44c7-bd1b-309f13829fa4', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'c5b3a974-8dce-45fa-9a1e-671bc9c660d3', N'a7f1dd92-0769-4b3c-b89b-51994b239138', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'b1323281-7ced-46df-b4aa-68861b41b6ad', N'c714695d-046c-4879-8c40-a469f0f8f883', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'ae710bb5-8d44-4bc7-acaa-6b46f28a7038', N'd3047b17-88ca-408b-b6b6-dac76dd9e14a', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'cecaf2c5-2827-4dbb-9ddd-6b51c11adf0a', N'10f9c30f-ef78-4d1a-9f0b-78dd259641f7', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'490ec2e9-a2a8-401e-a517-6b547c36726f', N'47b57286-ad33-4a6c-a9f2-7810b11a07c8', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'9be4d3ab-d394-4b51-8674-6b8e24347aa7', N'95713370-49e1-45ce-b3c0-93c60fdd29dd', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'78f1df3c-e957-4d7d-bf57-7065c0045f66', N'92e28d16-56f0-4e9b-8ee9-fcb992996fe1', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'8c4f9000-58bc-43df-b66f-719b80fb19c2', N'cbb8485a-388b-425a-ab98-08d0a62a6208', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'03dc700c-924c-447b-aa91-719f99b37fd3', N'3d1ce631-84ad-484a-ac97-95de7438c86d', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'a6bcbe49-5305-4bf2-9409-73d90909d905', N'c1359735-ec06-49d4-b2d7-31a9c51a9d4c', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'28fca157-6ec7-419a-9a06-74b5018d2dd3', N'24942349-1d97-45a4-806b-1e88f7d0f44b', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'271a06c9-c67c-4f36-9df4-803f80358f54', N'72b84ffa-739a-4763-be4e-09bd956ab905', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'743ca948-c75e-4ce1-9094-80707c1d9e07', N'9f84a177-707f-4976-89dd-681ea0068a21', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'ca544636-0a27-49dc-b885-83579114ff99', N'4627a752-b5e6-4b1a-b9fa-fd95979106b2', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'8fd0927c-2db4-4645-aae2-85194a146357', N'2d5eba7f-c154-4f03-a18c-8624dcfd790b', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'dbb0106c-81fa-4d72-b70d-8616d529ca71', N'de896bc7-6544-4bbb-b306-89335d201254', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'17ea4d86-82de-45b7-a755-869cb4c03954', N'1fdb3d67-191b-42a9-8212-20386a70062a', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'43b1f82f-8452-4def-890f-87b9f0f9c799', N'f2e38956-d60a-4c9c-8fb4-f65674450752', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'0c28ac84-1659-4041-a90f-884f6f742667', N'bd023a7c-9466-42e2-a1cb-b183cb5b6d59', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'c5533f1c-909f-4d62-ac9b-8974d4e6ef84', N'eab38076-2326-4023-a324-afe27cecba68', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'2e6ce41e-74c8-4c61-8798-897b2677c481', N'69f9e752-a6ee-47ff-9a1d-ec1216174416', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'85cebf0c-4512-4c92-8026-8ba331edf2d8', N'a5d80d57-0fa3-49bd-8872-240e7d325ee9', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'b0c2bf9f-592e-48d3-9cab-9296953bca76', N'912b3090-f67d-4578-9e23-ea6d2cbca1be', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'25f42403-0e1c-4835-b9c8-929994d01c10', N'0b2b752c-ffe5-4d75-8426-32463735cd58', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'bbfde7a2-78c5-45ce-8e3f-94d2de36ffcf', N'f8f064a3-7b8f-4745-830a-6f511fc0b5a9', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'c4222cbf-0db5-4364-bce0-98191a18f4b6', N'c9b55d88-c6f2-4a33-a0db-22010fb73689', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'e867f383-2465-49a1-81b7-983f8c92262a', N'4da7f25a-ef7a-4fbc-a90b-a7f1329bef6f', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'012c42f1-977d-4023-9671-991b8a82ff42', N'b38533ee-1471-469b-abcf-3d3d418e2626', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'55fd60c3-de91-4fa3-95eb-9ad507cf342f', N'9e229f35-d1e3-4eba-980c-09440dc4c154', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'3b5e79be-ae60-4f73-9d13-9b1f801447ad', N'38c28449-6092-4b97-8ffb-6be62d3d7652', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'bc831bf9-5d82-4e39-bf65-9d1f080b7b2a', N'78b61999-0604-454d-a3b5-e2d5a79ae7ba', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'f0a25f93-a576-413f-bd88-a2b6bbecce73', N'0a9047c6-55d1-4b0b-80da-17f9f3c43a2e', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'f2ae43bd-188d-45c5-97cf-a78c3aa8d3b2', N'064d34f3-794e-4f8a-a8c4-d7e10ca02374', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'505e5559-3355-490a-a866-a7e98480991a', N'd5abf044-eee1-4c66-bdd3-e246f5bc1482', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'0dd2b271-754c-4673-a18a-a8182293c00a', N'4dbbc5ad-9140-467a-b36b-e3e0ba791778', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'39842b60-8d95-46d2-a990-aa493031afcf', N'f399aab5-0353-4571-852a-59a6a815b003', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'085df37e-b6aa-49e1-962b-aa896dc2701e', N'ad6e8f3b-7575-4483-860b-e7f104c890e1', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'3cc7eb81-4447-42f1-816d-ab09425d60bd', N'96d61aff-4267-45bd-b763-1440178d79f4', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'70acb317-069d-428e-ae67-ae26d5483dd5', N'df8a0fb8-986a-443f-a01d-1715b6c665f6', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'64b664c1-47fd-48bc-8881-ae44b0c8f0dd', N'276662d2-822f-4147-a8c0-203adf979d77', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'2529a8f3-b02f-4f54-b307-aeeee8e230ee', N'a878b59b-d33b-42aa-8117-4fb6b3220bae', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'ac6edf16-bb0e-4930-8a51-b157f08e3f69', N'9711f534-db77-43d5-9cdc-a4938c1b55f9', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'fce245f3-ad79-4028-a26e-b6af45918420', N'a31e982a-2b45-43d4-ab59-3553f61651d6', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'efe97fe6-79a7-46a4-8788-b9a96489379c', N'97e11e9f-4fbc-423e-a3dc-f3f2c323e349', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'a22746e3-e5f4-4682-9a13-ba8eead8b13d', N'1107be1d-d3d8-4db5-b39d-e4773b6e751d', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'd9351dae-d3eb-4591-8d1f-c014342208fc', N'9f2cfe4e-78ce-469e-af99-4d17f386e844', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'3f0edc85-0ff8-4ee4-a3c5-c0633c16d4c3', N'047a6d19-74f7-49ed-87c5-4db15dc452bf', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'2341a194-6b3d-4dcc-8de0-c0cab74467de', N'ab166e1e-9fc4-43a0-b489-df70a0081ea9', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'0a33494c-8c1d-4326-9052-c1b7c8d6582b', N'3b8f33fb-47c3-4a32-af0f-b50d0759b9a9', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'64e2113c-eaee-452e-9f03-c5c71f71c7f4', N'2d483957-00d8-4363-89ea-295df90cb7dd', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'807c4001-c987-4272-a455-c62f6a832382', N'22950451-2a98-4cbc-a18b-ad8c6f33efe9', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'04c2cd94-4858-4228-90cc-c94e54d78d87', N'd0d6cd25-41d6-4b24-9491-e2d7409f67b9', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'56b2092c-b1dd-465b-9bce-cac26801178f', N'fd2505e4-fc93-40a5-996f-95ec791eb3fc', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'34e05f74-b52e-4a86-aa0e-cc81f24d1667', N'20fc3666-b30b-4e25-86a2-14f77485cb05', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'68a22f83-ac0c-4a0c-a6e4-cea8a8294e3c', N'5245466d-0d6c-44bc-a55b-e76694c059cc', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'41836b4c-37e2-44a3-9754-cebe104e2796', N'238e38b4-4aca-4bff-aa82-94fe6c7d6a93', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'92f6da1f-866d-454a-a17b-d022fbbbf9a9', N'ba411118-9ab0-46d4-8e1b-18d72e8a3e65', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'32203f02-8802-4629-8a9b-d057046b94f5', N'f901fb14-6600-4507-a8ac-d754799d81f5', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'6946da9d-32de-49ba-abff-d1a509b9f282', N'4960a21e-27c9-42cd-94b9-d9d0070ad62e', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'28b246da-82f7-48a7-9bcc-d8c4143e507c', N'0127d400-32f6-4f30-a0a5-e6ec08a9fcb7', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'66350fe8-371f-483a-8d26-db8988158a48', N'fee3f81a-8345-46fc-bef4-47ac158c7b40', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'338d9131-4bf2-493b-b102-dcbee267386f', N'206f74bc-80c4-4bc5-8de8-33926068b915', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'f489959c-dcf1-435f-83cb-dcdb3494751e', N'bb774498-70ac-4054-b4da-46319d914964', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'4adf744b-1c87-41d8-ab87-e1e0346be513', N'2c5da39b-bd16-45c5-8fc3-ec6b568056fa', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'90e6e834-ab3f-46fc-9d20-e2cc30ee0003', N'392a0356-44f5-4e4c-ba23-6efd6272e73c', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'e72da530-e199-410e-8508-e4d873893af3', N'ee5cc34f-1f84-4a53-8a1e-9ac4d7abe32f', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'58801553-3674-4941-a369-e78a981ad5e8', N'5e1fc2b5-9cb7-4624-bbe1-4b6d6ea87d79', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'fea9b30f-6861-48b8-95e8-ea8673dcb949', N'8717ce20-92db-4989-a113-abfc1ca56106', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'e3822e5e-841e-4c2d-974a-ea9177709c2d', N'7ebfc45f-ac80-4e4f-9107-1256cb0ddb04', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'06d8c4c9-9934-48f2-8902-ebed9cc04117', N'0164223f-83f4-4612-a4e4-7a50683a6476', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'4731d979-7ed9-4b67-a4ea-f04ca68d3a56', N'3a73e7d6-63d9-4cb6-b55e-73312be59c2d', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'a8018219-0e41-4aff-a18c-f1504ecc7f3d', N'7736b73c-c114-422e-ab5a-0e003478a62e', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'04efe556-ab8d-40dc-ba36-f1561ebd7c75', N'676297d6-34a2-4d8d-bd33-0cb0a26cfbe4', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'1692672c-7e8e-4f0a-951c-f17009516d4b', N'081c4858-9866-4545-9c2e-408a0401f1b0', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'6ab81e38-f1ed-4e33-8aa4-f29d7bc2e782', N'd150429c-a658-4c20-a4fc-4fde5180e8a5', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'4e7fb6b7-e0dd-44d6-8fc1-f3b0e88435c2', N'88451dea-2b0a-4516-9921-2efd433b57f5', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'3ad5a126-a532-4dd7-be24-f448be4534e4', N'1370ac35-a62a-4a47-8539-52cd0c822547', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'5a38a280-97bb-40a1-aec7-f60b933a12a9', N'e2863af9-4503-45a4-b9c0-22dcf11f374d', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'9c5843e4-ea7b-49b9-840c-f7ade6434bab', N'5cb9575d-544c-4881-b8b0-57c2ef88023e', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'122abf9d-da74-495d-bb47-f7b14e8c9234', N'e3467ab7-146b-40de-b5be-123b7d35716e', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'91192358-20e8-482e-9963-f844618078e6', N'42ce8061-efe8-4282-ad9d-5baf8737666f', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'7caddca7-53b3-42b7-af48-f9f5c4bb79cf', N'4763daef-4bf0-4678-bc86-a4af15ba7c22', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)
INSERT [dbo].[pGRPOMAlternates] ([POMAlternatesId], [POMGuidId], [AlternatesGuidId], [POMGradeTypeId], [POMId], [GradeTypeId]) VALUES (N'02b4a083-e309-43df-a717-fde260a92a84', N'0ce231b0-02b5-4c13-becf-f7de60748f8d', N'cbd54a39-9257-4fcd-89e5-527efaa9e741', NULL, NULL, NULL)

        END
   END
GO

--
-- End of Initial data changes
--


--
-- Now do the sversion table
--

/*
This script was created by Visual Studio on 6/20/2011 at 2:51 PM.
Run this script on kjohannsen3\kj2008r2.GA40_to_401.dbo to make it the same as kjohannsen3\kj2008r2.GA401.dbo.
This script performs its actions in the following order:
1. Disable foreign-key constraints.
2. Perform DELETE commands. 
3. Perform UPDATE commands.
4. Perform INSERT commands.
5. Re-enable foreign-key constraints.
Please back up your target database before running this script.
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
/*Pointer used for text / image updates. This might not be needed, but is declared here just in case*/
DECLARE @pv binary(16)
BEGIN TRANSACTION
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'03965a0e-7112-4f8e-a246-03c5c18d2279', N'DB_Version', N'4.0.0001', N'01498', '20110610 07:22:36.657')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'0eade694-b146-42a5-9296-64c845c5fad6', N'DB_Version', N'4.1.0000', N'01473', '20110603 13:12:19.457')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'0fb59fd8-a0d8-4ea5-b3f7-d00d5782298e', N'DB_Version', N'4.0.0000', N'01479', '20110603 13:12:20.670')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'136d588d-c1a6-4490-9e8f-83c7ae6b9910', N'DB_Version', N'4.0.0000', N'01505', '20110610 07:22:39.690')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'1afc2669-3760-4a20-bc77-243047c77241', N'DB_Version', N'4.0.0000', N'01506', '20110610 07:22:39.940')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'1d48b140-595c-477c-bd8f-0356dd0b8df3', N'DB_Version', N'4.1.0000', N'01513', '20110610 07:22:41.210')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'1d6e1e72-4242-44a7-aa6e-6a1684f5cbf0', N'DB_Version', N'4.0.0000', N'01489', '20110603 13:12:22.107')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'2058ea65-6746-43ad-8b2b-0d79ce468ce4', N'DB_Version', N'4.0.0000', N'01508', '20110610 07:22:41.010')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'271525f6-c48c-4442-8e2a-ef316fef2db5', N'DB_Version', N'4.0.0000', N'01487', '20110603 13:12:21.697')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'2df3644c-7817-494c-8a0a-114443b849b6', N'DB_Version', N'4.1.0000', N'01472', '20110603 13:12:19.290')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'2fadcc8e-f308-4d0d-8a86-bcffa784f72e', N'DB_Version', N'4.1.0000', N'01474', '20110603 13:12:19.683')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'3038573c-10fb-4c32-a10a-9046c2a4e981', N'DB_Version', N'4.0.0000', N'01477', '20110603 13:12:20.310')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'4950e60e-cd5c-4a43-8360-099a679f84fb', N'DB_Version', N'4.0.0000', N'01507', '20110610 07:22:40.160')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'5a36b51b-a1a9-4319-a035-f9a2d0bb2211', N'DB_Version', N'4.0.0000', N'01499', '20110610 07:22:37.540')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'5fc14a24-1dfb-4088-9d71-e76448e07421', N'DB_Version', N'4.1.0000', N'01469', '20110603 13:12:17.947')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'60fda557-e45e-4842-91c1-3abf21f39d41', N'DB_Version', N'4.0.0000', N'01503', '20110610 07:22:39.003')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'672630ae-08ec-4299-a923-9b64fc68ffdb', N'DB_Version', N'4.0.0000', N'01501', '20110610 07:22:38.357')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'6ae04bd8-15fd-4c90-a73e-311275f20462', N'DB_Version', N'4.1.0000', N'01467', '20110603 13:12:17.117')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'7fa2a46f-8291-419d-a659-9bfb6f53f380', N'DB_Version', N'4.0.0000', N'01471', '20110603 13:12:18.797')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'8740fbfe-7735-4a7b-8457-ee690d711adf', N'DB_Version', N'4.0.0000', N'01500', '20110610 07:22:37.997')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'8a3d9e69-d603-419b-893d-8295fc7f79e8', N'DB_Version', N'4.1.0000', N'01485', '20110603 13:12:21.280')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'8cb67621-cc08-4d2a-950f-4c35015140d9', N'DB_Version', N'4.0.0001', N'01495', '20110603 14:55:18.740')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'91cceac2-cc2e-42ff-aaf0-c3e903fabe00', N'DB_Version', N'4.0.0000', N'01470', '20110603 13:12:18.647')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'955fda69-aaa1-4fa6-9682-404c58918215', N'DB_Version', N'4.0.0000', N'01502', '20110610 07:22:38.723')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'966d07f3-9fb3-4836-b954-cf6ee13c3c06', N'DB_Version', N'4.0.0000', N'01476', '20110603 13:12:20.150')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'9a2cd380-0e64-4e0b-a18c-cc7944738679', N'DB_Version', N'4.0.0000', N'01515', '20110610 07:22:41.820')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'a7caed3d-3123-420a-be02-647baf4302f4', N'DB_Version', N'4.0.0000', N'01488', '20110603 13:12:21.937')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'b8238c2e-15cf-4b24-8ab8-36901bf3ff24', N'DB_Version', N'4.0.0000', N'01504', '20110610 07:22:39.470')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'bcb239a6-ed1f-4ea3-afef-e417445eec34', N'DB_Version', N'4.0.0001', N'01494', '20110603 13:12:22.307')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'c1f78e09-54fe-4b9f-b12e-9220eac0fe49', N'DB_Version', N'4.0.0000', N'01478', '20110603 13:12:20.470')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'ce41c2b1-e182-4f16-a72a-29c6540bc1c6', N'DB_Version', N'4.0.0000', N'01480', '20110603 13:12:20.960')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'ce77faa9-fdef-4739-9ab4-c540dd4122f7', N'DB_Version', N'4.0.0000', N'01514', '20110610 07:22:41.540')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'd0b60e2b-67be-4b76-b747-7da41fff7b45', N'DB_Version', N'4.1.0000', N'01486', '20110603 13:12:21.440')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'de0b3072-1a6d-44d2-8c82-b3d9e4a7d1da', N'DB_Version', N'4.1.0000', N'01470', '20110603 13:12:18.493')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'e2d70f19-e506-484b-b7c6-8594ab7655b4', N'DB_Version', N'4.0.0000', N'01469', '20110603 13:12:18.303')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'e5b0fb2f-db4c-4198-846b-7566fd287734', N'DB_Version', N'4.1.0000', N'01468', '20110603 13:12:17.723')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'e5b2b8fd-b2a7-49d3-be20-c2911cafcf9a', N'DB_Version', N'4.1.0000', N'01475', '20110603 13:12:19.920')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'edbdf971-21f8-4398-9e81-4f57af73bf32', N'DB_Version', N'4.1.0000', N'01484', '20110603 13:12:21.110')
INSERT INTO [dbo].[sVersion] ([sVersionId], [AppName], [Version], [LastScriptRun], [TimeStamp]) VALUES (N'f0abb595-ce0d-4ca1-8b91-3f68e8f92b0b', N'DB_Version', N'4.0.0000', N'01471', '20110603 13:12:19.097')
COMMIT TRANSACTION
GO

--
-- End of Sversion 
--
