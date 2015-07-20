DECLARE @RowID INT
DECLARE @Total INT 
DECLARE @Query NVARCHAR(500)


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlan]') AND type in (N'U'))
	BEGIN
		CREATE TABLE  #tmpLP (
			RowId int IDENTITY (1,1),
			Query NVARCHAR(500)
		)

		INSERT INTO #tmpLP  (Query)
		SELECT 'DELETE FROM pLinePlan WHERE LinePlanID = ''' + CAST(LinePlanID AS NVARCHAR(50)) + ''' '  FROM pLinePlan

		SELECT @Total  = COUNT(*) FROM #tmpLP
		SET @RowID = 1 

		WHILE @RowID <= @Total 
		BEGIN
			SELECT @Query = Query FROM #tmpLP WHERE RowId = @RowID 
			EXEC (@Query)
			SET @RowID = @RowID + 1
		END 
		DROP TABLE #tmpLP
	END


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleHeader]') AND type in (N'U'))
	BEGIN
		CREATE TABLE  #tmpST (
			RowId int IDENTITY (1,1),
			Query NVARCHAR(500)
		)

		INSERT INTO #tmpST(Query)
		SELECT 'DELETE FROM pStyleHeader WHERE StyleID = ''' + CAST(StyleID AS NVARCHAR(50)) + ''' ' FROM pStyleHeader

		SELECT @Total  = COUNT(*) FROM #tmpST
		SET @RowID = 1 

		WHILE @RowID <= @Total 
		BEGIN
			SELECT @Query = Query FROM #tmpST WHERE RowId = @RowID 
			EXEC (@Query)
			SET @RowID = @RowID + 1
		END 
		DROP TABLE #tmpST
	END




IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cDeskGroupFolderAccess]') AND type in (N'U')) DELETE FROM dbo.cDeskGroupFolderAccess
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cDeskUserApplicationAccess]') AND type in (N'U')) DELETE FROM dbo.cDeskUserApplicationAccess
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cDeskUserFolderAccess]') AND type in (N'U')) DELETE FROM dbo.cDeskUserFolderAccess
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cDeskUserImageFolderAccess]') AND type in (N'U')) DELETE FROM dbo.cDeskUserImageFolderAccess

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ColorLibraryPending]') AND type in (N'U')) DELETE FROM dbo.ColorLibraryPending

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hImage]') AND type in (N'U')) DELETE FROM dbo.hImage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hSampleHistory]') AND type in (N'U')) DELETE FROM dbo.hSampleHistory
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hStyleHistory]') AND type in (N'U')) DELETE FROM dbo.hStyleHistory
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hStyleQuoteHistory]') AND type in (N'U')) DELETE FROM dbo.hStyleQuoteHistory


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBody]') AND type in (N'U')) DELETE FROM dbo.pBody
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBodyDevelopmentItem]') AND type in (N'U')) DELETE FROM dbo.pBodyDevelopmentItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBodyImage]') AND type in (N'U')) DELETE FROM dbo.pBodyImage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBodySpec]') AND type in (N'U')) DELETE FROM dbo.pBodySpec
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBodySpecSize]') AND type in (N'U')) DELETE FROM dbo.pBodySpecSize
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBodyWorkflow]') AND type in (N'U')) DELETE FROM dbo.pBodyWorkflow

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pColorFolder]') AND type in (N'U')) DELETE FROM dbo.pColorFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pColorFolderSeasonYear]') AND type in (N'U')) DELETE FROM dbo.pColorFolderSeasonYear
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pColorPalette]') AND type in (N'U')) DELETE FROM dbo.pColorPalette
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pColorPaletteComment]') AND type in (N'U')) DELETE FROM dbo.pColorPaletteComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pColorPaletteDocument]') AND type in (N'U')) DELETE FROM dbo.pColorPaletteDocument
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pColorPaletteSeasonYear]') AND type in (N'U')) DELETE FROM dbo.pColorPaletteSeasonYear

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pCompliance]') AND type in (N'U')) DELETE FROM dbo.pCompliance
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pConceptFolder]') AND type in (N'U')) DELETE FROM dbo.pConceptFolder

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImage]') AND type in (N'U')) DELETE FROM dbo.pImage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageAttribute]') AND type in (N'U')) DELETE FROM dbo.pImageAttribute
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageCatalog]') AND type in (N'U')) DELETE FROM dbo.pImageCatalog
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageCatalogItem]') AND type in (N'U')) DELETE FROM dbo.pImageCatalogItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageCatalogTeam]') AND type in (N'U')) DELETE FROM dbo.pImageCatalogTeam
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageComment]') AND type in (N'U')) DELETE FROM dbo.pImageComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageFolder]') AND type in (N'U')) DELETE FROM dbo.pImageFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageHistory]') AND type in (N'U')) DELETE FROM dbo.pImageHistory

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLabDip]') AND type in (N'U')) DELETE FROM dbo.pLabDip
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolder]') AND type in (N'U')) DELETE FROM dbo.pLineFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderItem]') AND type in (N'U')) DELETE FROM dbo.pLineFolderItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderItemColor]') AND type in (N'U')) DELETE FROM dbo.pLineFolderItemColor
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderItemMessage]') AND type in (N'U')) DELETE FROM dbo.pLineFolderItemMessage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderUser]') AND type in (N'U')) DELETE FROM dbo.pLineFolderUser

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlan]') AND type in (N'U')) DELETE FROM dbo.pLinePlan
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanAttribute]') AND type in (N'U')) DELETE FROM dbo.pLinePlanAttribute
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanAttributeItem]') AND type in (N'U')) DELETE FROM dbo.pLinePlanAttributeItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanBodyItem]') AND type in (N'U')) DELETE FROM dbo.pLinePlanBodyItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanBusiness]') AND type in (N'U')) DELETE FROM dbo.pLinePlanBusiness
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanBusinessItem]') AND type in (N'U')) DELETE FROM dbo.pLinePlanBusinessItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanColor]') AND type in (N'U')) DELETE FROM dbo.pLinePlanColor
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanColorItem]') AND type in (N'U')) DELETE FROM dbo.pLinePlanColorItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanComment]') AND type in (N'U')) DELETE FROM dbo.pLinePlanComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanFolder]') AND type in (N'U')) DELETE FROM dbo.pLinePlanFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanItem]') AND type in (N'U')) DELETE FROM dbo.pLinePlanItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanItemComment]') AND type in (N'U')) DELETE FROM dbo.pLinePlanItemComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanMaterial]') AND type in (N'U')) DELETE FROM dbo.pLinePlanMaterial
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanMaterialItem]') AND type in (N'U')) DELETE FROM dbo.pLinePlanMaterialItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanRange]') AND type in (N'U')) DELETE FROM dbo.pLinePlanRange
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanShowroom]') AND type in (N'U')) DELETE FROM dbo.pLinePlanShowroom
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanShowroomItem]') AND type in (N'U')) DELETE FROM dbo.pLinePlanShowroomItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanShowroomStyleColor]') AND type in (N'U')) DELETE FROM dbo.pLinePlanShowroomStyleColor
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanTempItemShowroom]') AND type in (N'U')) DELETE FROM dbo.pLinePlanTempItemShowroom
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanTempItemShowroomItem]') AND type in (N'U')) DELETE FROM dbo.pLinePlanTempItemShowroomItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanTempItemShowroomStyleColor]') AND type in (N'U')) DELETE FROM dbo.pLinePlanTempItemShowroomStyleColor
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanTradePartner]') AND type in (N'U')) DELETE FROM dbo.pLinePlanTradePartner
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanTradePartnerItem]') AND type in (N'U')) DELETE FROM dbo.pLinePlanTradePartnerItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineTemp]') AND type in (N'U')) DELETE FROM dbo.pLineTemp

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterial]') AND type in (N'U')) DELETE FROM dbo.pMaterial
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialActivity]') AND type in (N'U')) DELETE FROM dbo.pMaterialActivity
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialColor]') AND type in (N'U')) DELETE FROM dbo.pMaterialColor
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialColorPending]') AND type in (N'U')) DELETE FROM dbo.pMaterialColorPending
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialColorSeasonYear]') AND type in (N'U')) DELETE FROM dbo.pMaterialColorSeasonYear

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialComment]') AND type in (N'U')) DELETE FROM dbo.pMaterialComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialContent]') AND type in (N'U')) DELETE FROM dbo.pMaterialContent

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialCore]') AND type in (N'U')) DELETE FROM dbo.pMaterialCore
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialCoreItem]') AND type in (N'U')) DELETE FROM dbo.pMaterialCoreItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialDesign]') AND type in (N'U')) DELETE FROM dbo.pMaterialDesign
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialDocument]') AND type in (N'U')) DELETE FROM dbo.pMaterialDocument
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialHistory]') AND type in (N'U')) DELETE FROM dbo.pMaterialHistory
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialLink]') AND type in (N'U')) DELETE FROM dbo.pMaterialLink
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialLinkColorway]') AND type in (N'U')) DELETE FROM dbo.pMaterialLinkColorway
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialLinkColorwayItem]') AND type in (N'U')) DELETE FROM dbo.pMaterialLinkColorwayItem

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialPackLabelGroupImage]') AND type in (N'U')) DELETE FROM dbo.pMaterialPackLabelGroupImage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialPackLabelGroupItem]') AND type in (N'U')) DELETE FROM dbo.pMaterialPackLabelGroupItem

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialProcess]') AND type in (N'U')) DELETE FROM dbo.pMaterialProcess
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestAgentVendorTemp]') AND type in (N'U')) DELETE FROM dbo.pMaterialRequestAgentVendorTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSeasonColorTemp]') AND type in (N'U')) DELETE FROM dbo.pMaterialRequestSeasonColorTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmit]') AND type in (N'U')) DELETE FROM dbo.pMaterialRequestSubmit
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitComment]') AND type in (N'U')) DELETE FROM dbo.pMaterialRequestSubmitComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitDocument]') AND type in (N'U')) DELETE FROM dbo.pMaterialRequestSubmitDocument
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitItem]') AND type in (N'U')) DELETE FROM dbo.pMaterialRequestSubmitItem


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestSubmitWorkflow]') AND type in (N'U')) DELETE FROM dbo.pMaterialRequestSubmitWorkflow
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialRequestTemp]') AND type in (N'U')) DELETE FROM dbo.pMaterialRequestTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialSeasonYear]') AND type in (N'U')) DELETE FROM dbo.pMaterialSeasonYear
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialSize]') AND type in (N'U')) DELETE FROM dbo.pMaterialSize
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTesting]') AND type in (N'U')) DELETE FROM dbo.pMaterialTesting
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartner]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartner
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerColor]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerColor
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerLabDip]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerLabDip

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerLabDipItem]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerLabDipItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerLabDipSubmitComment]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerLabDipSubmitComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerLabDipSubmitDocument]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerLabDipSubmitDocument
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerLabDipSubmitItem]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerLabDipSubmitItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerTemp]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerTesting]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerTesting
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerTestingSubmit]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerTestingSubmit
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerTestingSubmitComment]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerTestingSubmitComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerTestingSubmitDocument]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerTestingSubmitDocument
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerTestingSubmitItem]') AND type in (N'U')) DELETE FROM dbo.pMaterialTradePartnerTestingSubmitItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialVendorTesting]') AND type in (N'U')) DELETE FROM dbo.pMaterialVendorTesting

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMedia]') AND type in (N'U')) DELETE FROM dbo.pMedia

--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPOMLibrary]') AND type in (N'U')) DELETE FROM dbo.pPOMLibrary
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPOMTemplate]') AND type in (N'U')) DELETE FROM dbo.pPOMTemplate
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPOMTemplateGroup]') AND type in (N'U')) DELETE FROM dbo.pPOMTemplateGroup
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPOMTemplateItem]') AND type in (N'U')) DELETE FROM dbo.pPOMTemplateItem
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPOMTemplateItemTemp]') AND type in (N'U')) DELETE FROM dbo.pPOMTemplateItemTemp


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQuoteFolder]') AND type in (N'U')) DELETE FROM dbo.pQuoteFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQuoteFolderItem]') AND type in (N'U')) DELETE FROM dbo.pQuoteFolderItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQuoteFolderItemLog]') AND type in (N'U')) DELETE FROM dbo.pQuoteFolderItemLog
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQuoteFolderItemMessage]') AND type in (N'U')) DELETE FROM dbo.pQuoteFolderItemMessage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQuoteFolderItemTeam]') AND type in (N'U')) DELETE FROM dbo.pQuoteFolderItemTeam
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQuoteFolderPage]') AND type in (N'U')) DELETE FROM dbo.pQuoteFolderPage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQuoteFolderType]') AND type in (N'U')) DELETE FROM dbo.pQuoteFolderType
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQuoteTeam]') AND type in (N'U')) DELETE FROM dbo.pQuoteTeam

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestActivity]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestActivity
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestComment]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestFolder]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestGroupTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestGroupTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestLog]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestLog
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestMaterial]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestMaterial
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestMaterialTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestMaterialTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSetItem]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestSetItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSetItemTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestSetItemTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSpecItem]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestSpecItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSpecItemTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestSpecItemTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSpecSize]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestSpecSize
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSpecSizeTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestSpecSizeTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestStyle]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestStyle
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestStyleColorway]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestStyleColorway
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestStyleColorwayTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestStyleColorwayTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestStyleTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestStyleTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmit]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestSubmit
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitImage]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestSubmitImage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestSubmitTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestSubmitTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestTeamTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestTeamTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestTrade]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestTrade
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestVendorTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestVendorTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflow]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestWorkflow
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestWorkflowTemp]') AND type in (N'U')) DELETE FROM dbo.pSampleRequestWorkflowTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleWorkflowItemTemplate]') AND type in (N'U')) DELETE FROM dbo.pSampleWorkflowItemTemplate
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleWorkflowTemplate]') AND type in (N'U')) DELETE FROM dbo.pSampleWorkflowTemplate
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleWorkflowViewAgent]') AND type in (N'U')) DELETE FROM dbo.pSampleWorkflowViewAgent
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleWorkflowViewSubmit]') AND type in (N'U')) DELETE FROM dbo.pSampleWorkflowViewSubmit

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSeason]') AND type in (N'U')) DELETE FROM dbo.pSeason
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSeasonYear]') AND type in (N'U')) DELETE FROM dbo.pSeasonYear
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pShowroom]') AND type in (N'U')) DELETE FROM dbo.pShowroom


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleHeader]') AND type in (N'U')) DELETE FROM dbo.pStyleHeader


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleActivityTemp]') AND type in (N'U')) DELETE FROM dbo.pStyleActivityTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleAttribute]') AND type in (N'U')) DELETE FROM dbo.pStyleAttribute
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleAttributeTable]') AND type in (N'U')) DELETE FROM dbo.pStyleAttributeTable
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCalendarTemp]') AND type in (N'U')) DELETE FROM dbo.pStyleCalendarTemp

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCare]') AND type in (N'U')) DELETE FROM dbo.pStyleCare
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCareBleach]') AND type in (N'U')) DELETE FROM dbo.pStyleCareBleach
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCareCycle]') AND type in (N'U')) DELETE FROM dbo.pStyleCareCycle
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCareDry]') AND type in (N'U')) DELETE FROM dbo.pStyleCareDry
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCareDryClean]') AND type in (N'U')) DELETE FROM dbo.pStyleCareDryClean
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCareIron]') AND type in (N'U')) DELETE FROM dbo.pStyleCareIron
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCareSpecial]') AND type in (N'U')) DELETE FROM dbo.pStyleCareSpecial
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCareTemplateItem]') AND type in (N'U')) DELETE FROM dbo.pStyleCareTemplateItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCareWash]') AND type in (N'U')) DELETE FROM dbo.pStyleCareWash
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleChange]') AND type in (N'U')) DELETE FROM dbo.pStyleChange
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleChannel]') AND type in (N'U')) DELETE FROM dbo.pStyleChannel
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorway]') AND type in (N'U')) DELETE FROM dbo.pStyleColorway
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwayAvailTemp]') AND type in (N'U')) DELETE FROM dbo.pStyleColorwayAvailTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwayItem]') AND type in (N'U')) DELETE FROM dbo.pStyleColorwayItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwayItemTemp]') AND type in (N'U')) DELETE FROM dbo.pStyleColorwayItemTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwaySeasonYear]') AND type in (N'U')) DELETE FROM dbo.pStyleColorwaySeasonYear
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleColorwaySeasonYearTemp]') AND type in (N'U')) DELETE FROM dbo.pStyleColorwaySeasonYearTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleComment]') AND type in (N'U')) DELETE FROM dbo.pStyleComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCostFreight]') AND type in (N'U')) DELETE FROM dbo.pStyleCostFreight
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCosting]') AND type in (N'U')) DELETE FROM dbo.pStyleCosting
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCostingHeader]') AND type in (N'U')) DELETE FROM dbo.pStyleCostingHeader
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDeleteTemp]') AND type in (N'U')) DELETE FROM dbo.pStyleDeleteTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDelivery]') AND type in (N'U')) DELETE FROM dbo.pStyleDelivery
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDetail]') AND type in (N'U')) DELETE FROM dbo.pStyleDetail
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDetailGrid]') AND type in (N'U')) DELETE FROM dbo.pStyleDetailGrid
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDetailGrid2]') AND type in (N'U')) DELETE FROM dbo.pStyleDetailGrid2
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDetailGrid3]') AND type in (N'U')) DELETE FROM dbo.pStyleDetailGrid3
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDetailGrid4]') AND type in (N'U')) DELETE FROM dbo.pStyleDetailGrid4
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDevelopment]') AND type in (N'U')) DELETE FROM dbo.pStyleDevelopment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDevelopmentItem]') AND type in (N'U')) DELETE FROM dbo.pStyleDevelopmentItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDocument]') AND type in (N'U')) DELETE FROM dbo.pStyleDocument
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleFeature]') AND type in (N'U')) DELETE FROM dbo.pStyleFeature
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleFlag]') AND type in (N'U')) DELETE FROM dbo.pStyleFlag
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleGroup]') AND type in (N'U')) DELETE FROM dbo.pStyleGroup
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleHistory]') AND type in (N'U')) DELETE FROM dbo.pStyleHistory
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImage]') AND type in (N'U')) DELETE FROM dbo.pStyleImage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleImageItem]') AND type in (N'U')) DELETE FROM dbo.pStyleImageItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleLicensee]') AND type in (N'U')) DELETE FROM dbo.pStyleLicensee
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleMaterials]') AND type in (N'U')) DELETE FROM dbo.pStyleMaterials
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleMaterialTemp]') AND type in (N'U')) DELETE FROM dbo.pStyleMaterialTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleMedia]') AND type in (N'U')) DELETE FROM dbo.pStyleMedia
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuote]') AND type in (N'U')) DELETE FROM dbo.pStyleQuote
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteComment]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteComment
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteDocument]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteDocument
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItem]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItemActivity]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteItemActivity
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItemFreightCost]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteItemFreightCost
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItemTeam]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteItemTeam
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItemVersion]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteItemVersion
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteLog]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteLog
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteMessage]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteMessage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteVariation]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteVariation
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteVariationFreightCost]') AND type in (N'U')) DELETE FROM dbo.pStyleQuoteVariationFreightCost
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSeason]') AND type in (N'U')) DELETE FROM dbo.pStyleSeason
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSeasonYear]') AND type in (N'U')) DELETE FROM dbo.pStyleSeasonYear

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSourcing]') AND type in (N'U')) DELETE FROM dbo.pStyleSourcing
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSourcingItem]') AND type in (N'U')) DELETE FROM dbo.pStyleSourcingItem
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSpec]') AND type in (N'U')) DELETE FROM dbo.pStyleSpec
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSpecSize]') AND type in (N'U')) DELETE FROM dbo.pStyleSpecSize
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSpecSizeTemp]') AND type in (N'U')) DELETE FROM dbo.pStyleSpecSizeTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSpecTemp]') AND type in (N'U')) DELETE FROM dbo.pStyleSpecTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleTeam]') AND type in (N'U')) DELETE FROM dbo.pStyleTeam
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleUPC]') AND type in (N'U')) DELETE FROM dbo.pStyleUPC
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflow]') AND type in (N'U')) DELETE FROM dbo.pStyleWorkflow
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflowSchedule]') AND type in (N'U')) DELETE FROM dbo.pStyleWorkflowSchedule
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleWorkflowTeam]') AND type in (N'U')) DELETE FROM dbo.pStyleWorkflowTeam

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTechPack]') AND type in (N'U')) DELETE FROM dbo.pTechPack
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTechPackActivity]') AND type in (N'U')) DELETE FROM dbo.pTechPackActivity
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTechPackLog]') AND type in (N'U')) DELETE FROM dbo.pTechPackLog
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTechPackMessage]') AND type in (N'U')) DELETE FROM dbo.pTechPackMessage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTechPackPage]') AND type in (N'U')) DELETE FROM dbo.pTechPackPage
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTechPackStyle]') AND type in (N'U')) DELETE FROM dbo.pTechPackStyle
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTechPackTeam]') AND type in (N'U')) DELETE FROM dbo.pTechPackTeam


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTradingPartner]') AND type in (N'U')) DELETE FROM dbo.pTradingPartner
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pUniversalProductCode]') AND type in (N'U')) DELETE FROM dbo.pUniversalProductCode
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pUserAccess]') AND type in (N'U')) DELETE FROM dbo.pUserAccess
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pUserTitle]') AND type in (N'U')) DELETE FROM dbo.pUserTitle



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rReportStyleTemp]') AND type in (N'U')) DELETE FROM dbo.rReportStyleTemp
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rReportSubTable1]') AND type in (N'U')) DELETE FROM dbo.rReportSubTable1
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rReportSubTable2]') AND type in (N'U')) DELETE FROM dbo.rReportSubTable2
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rReportSubTable3]') AND type in (N'U')) DELETE FROM dbo.rReportSubTable3
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rReportTable]') AND type in (N'U')) DELETE FROM dbo.rReportTable

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessColorFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessColorFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessComplianceFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessComplianceFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessControlPanel]') AND type in (N'U')) DELETE FROM dbo.sAccessControlPanel
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessCosting]') AND type in (N'U')) DELETE FROM dbo.sAccessCosting
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroup]') AND type in (N'U')) DELETE FROM dbo.sAccessGroup
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupColorFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupColorFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupComplianceFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupComplianceFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupControlPanel]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupControlPanel
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupCosting]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupCosting
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupImageFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupImageFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupLineFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupLineFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupLinePlanFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupLinePlanFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupLinePlanTab]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupLinePlanTab

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupMaterialFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupMaterialFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupQuotationFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupQuotationFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupSampleFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupSampleFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupShareFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupShareFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupStyleFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessGroupStyleFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessImageFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessImageFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessLineFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessLineFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessLinePlanFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessLinePlanFolder

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessMaterialFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessMaterialFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessMember]') AND type in (N'U')) DELETE FROM dbo.sAccessMember
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessQuotationFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessQuotationFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessSampleFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessSampleFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessShareFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessShareFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessStyleFolder]') AND type in (N'U')) DELETE FROM dbo.sAccessStyleFolder
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessUser]') AND type in (N'U')) DELETE FROM dbo.sAccessUser
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sApplicationLog]') AND type in (N'U')) DELETE FROM dbo.sApplicationLog

--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uGroup]') AND type in (N'U')) DELETE FROM dbo.uGroup
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartner]') AND type in (N'U')) DELETE FROM dbo.uTradePartner
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerContact]') AND type in (N'U')) DELETE FROM dbo.uTradePartnerContact
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerVendor]') AND type in (N'U')) DELETE FROM dbo.uTradePartnerVendor
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerVendorContact]') AND type in (N'U')) DELETE FROM dbo.uTradePartnerVendorContact
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uUserGroup]') AND type in (N'U')) DELETE FROM dbo.uUserGroup
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uVendor]') AND type in (N'U')) DELETE FROM dbo.uVendor
