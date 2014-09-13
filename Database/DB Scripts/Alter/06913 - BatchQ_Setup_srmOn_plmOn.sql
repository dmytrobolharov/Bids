--** Add new column to table pBatchQueueType
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = N'pBatchQueueType' and COLUMN_NAME = N'srmOn')
	BEGIN 
		ALTER TABLE pBatchQueueType ADD srmOn INT DEFAULT 0
	END
	
	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = N'pBatchQueueType' and COLUMN_NAME = N'srmOn')
			EXEC('UPDATE pBatchQueueType SET srmOn = 0 WHERE srmOn IS NULL')
	
GO


--** Add new column to table pBatchQueue
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = N'pBatchQueue' and COLUMN_NAME = N'srmOn')
	BEGIN 
		ALTER TABLE pBatchQueue ADD srmOn INT DEFAULT 0
	END
	
	IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_NAME = N'pBatchQueue' and COLUMN_NAME = N'srmOn')
		EXEC('UPDATE pBatchQueue SET srmOn = 0 WHERE srmOn IS NULL')
GO

--** Enable StyleFolder BatchQ to be shown in srmOn
UPDATE dbo.pBatchQueueType SET srmOn = 1 WHERE BatchQueueTypeID = 'F459C2F2-657A-E011-9848-005056C00008'


--*// Download Techpack from srmOn
DELETE FROM dbo.pBatchQueue WHERE BatchQueueID LIKE '50000000-%-000000000001'
DELETE FROM dbo.pBatchQueuePageType WHERE BatchQueuePageTypeID LIKE '50000000-%-000000000001'
DELETE FROM dbo.pBatchQueuePage WHERE BatchQueuePageID LIKE '50000000-%-000000000001'
DELETE FROM dbo.pBatchQueuePageDep WHERE BatchQueuePageDepID LIKE '50000000-%-000000000001'

INSERT INTO [dbo].[pBatchQueue] ([BatchQueueID], [BatchQueueTypeID], [BatchQueueName], [BatchQueueDesc], [BatchQueueUrl], [BatchQueueIcon], [CUser], [CDate], [MUser], [MDate], [BatchQueuePageHistoryUrl], [srmOn]) VALUES ('50000000-0000-0000-0000-000000000001', 'f459c2f2-657a-e011-9848-005056c00008', N'Download Tech Pack', 'Download Multiple Tech Packs', 'BatchQ_Page.aspx', 'icon_tables_stacks.gif', NULL, NULL, NULL, NULL, N'BatchQ_TechPack_CreateZip.aspx', 1)

INSERT INTO [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES ('50000000-0000-0000-1000-000000000001', N'Find Season & Year', N'Select season and year', 'SeasonYearID', 'BatchQ_SeasonYear_Search.xml', NULL, 'BatchQ_SeasonYear_Default.xml', 'BatchQ_SeasonYear_Default.xml', 'BatchQ_Grid.aspx', 'S', 1, 'spx_SRMBatchQGrid_SeasonYear_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES ('50000000-0000-0000-2000-000000000001', N'Select multiple styles', N'Please select multiple styles ', 'StyleID', 'BatchQ_StyleSeasonal_Search.xml', NULL, 'BatchQ_StyleSeasonal_Default.xml', 'BatchQ_StyleHeader_Selected.xml', 'BatchQ_Grid.aspx', 'M', 50, 'spx_SRMBatchQGrid_Agent_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES ('50000000-0000-0000-3000-000000000001', N'Select predifined tech pack', N'Select predifined tech pack', 'ReportTechPackFolderID', 'BatchQ_ReportTechPackFolder_Search.xml', NULL, 'BatchQ_ReportTechPackFolder_Default.xml', 'BatchQ_ReportTechPackFolder_Default.xml', 'BatchQ_Grid.aspx', 'S', 1, 'spx_SRMBatchQGrid_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES ('50000000-0000-0000-4000-000000000001', N'Create Zip File', N'Create Zip File', 'StyleID', NULL, NULL, 'BatchQ_CreateZip_Style_Default.xml', NULL, 'BatchQ_TechPack_CreateZip.aspx', NULL, NULL, 'spx_BatchQGrid_TechPack_CreateZip_Review_SELECT', N'spx_BatchQJob_ZipStyleTechpack_EXECUTE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)

INSERT INTO [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES ('50000000-0000-0000-1000-000000000001', '50000000-0000-0000-1000-000000000001', '50000000-0000-0000-0000-000000000001', '0000', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES ('50000000-0000-0000-2000-000000000001', '50000000-0000-0000-2000-000000000001', '50000000-0000-0000-0000-000000000001', '0001', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES ('50000000-0000-0000-3000-000000000001', '50000000-0000-0000-3000-000000000001', '50000000-0000-0000-0000-000000000001', '0002', NULL, NULL, NULL, NULL)
INSERT INTO [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES ('50000000-0000-0000-4000-000000000001', '50000000-0000-0000-4000-000000000001', '50000000-0000-0000-0000-000000000001', '0003', NULL, NULL, NULL, NULL)

INSERT INTO [dbo].[pBatchQueuePageDep] ([BatchQueuePageDepID], [BatchQueuePageID], [BatchQueuePageRelationID]) VALUES ('50000000-0000-0000-2000-000000000001', '50000000-0000-0000-2000-000000000001', '50000000-0000-0000-1000-000000000001')


--*// Create TechPack from plmOn
DELETE FROM dbo.pBatchQueue WHERE BatchQueueID LIKE '90000000-%-000000000030'
DELETE FROM dbo.pBatchQueuePageType WHERE BatchQueuePageTypeID LIKE '90000000-%-000000000030'
DELETE FROM dbo.pBatchQueuePage WHERE BatchQueuePageID LIKE '90000000-%-000000000030'
DELETE FROM dbo.pBatchQueuePageDep WHERE BatchQueuePageDepID LIKE '90000000-%-000000000030'

INSERT [dbo].[pBatchQueue] ([BatchQueueID], [BatchQueueTypeID], [BatchQueueName], [BatchQueueDesc], [BatchQueueUrl], [BatchQueueIcon], [CUser], [CDate], [MUser], [MDate], [BatchQueuePageHistoryUrl], [srmOn]) VALUES (N'90000000-0000-0000-0000-000000000030', N'f459c2f2-657a-e011-9848-005056c00008', N'Create Tech Pack', N'Create Tech Pack to Multiple Styles', N'BatchQ_Page.aspx', N'icon_tables_stacks.gif', NULL, NULL, NULL, NULL, N'BatchQ_TechPack_Review.aspx', 0)

INSERT [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES (N'90000000-0000-A000-0000-000000000030', N'Find Season & Year', N'Select season and year', N'SeasonYearID', N'SeasonYear_Search.xml', NULL, N'BatchQ_SeasonYear_Default.xml', N'BatchQ_SeasonYear_Default.xml', N'BatchQ_Grid.aspx', N'S', 1, N'spx_BatchQGrid_SeasonYear_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES (N'90000000-0000-A000-0001-000000000030', N'Select multiple styles', N'Please select multiple styles ', N'StyleID', N'BatchQ_StyleIntroSeasonal_Search.xml', NULL, N'BatchQ_StyleSeasonal_Default.xml', N'BatchQ_StyleHeader_Selected.xml', N'BatchQ_Grid.aspx', N'M', 50, N'spx_BatchQGrid_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES (N'90000000-0000-A000-0002-000000000030', N'Select agent', N'Select agent', N'TradePartnerRelationshipLevelID', N'BatchQ_TradePartner_Search.xml', NULL, N'BatchQ_TradePartner_Default.xml', N'BatchQ_TradePartner_Default.xml', N'BatchQ_Grid.aspx', N'M', 50, N'spx_BatchQGrid_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES (N'90000000-0000-A000-0003-000000000030', N'Select predefined tech pack', N'Select predefined tech pack', N'ReportTechPackFolderID', N'BatchQ_TechPackPredefined_Default.xml', NULL, N'BatchQ_TechPackPredefined_Default.xml', N'BatchQ_TechPackPredefined_Default.xml', N'BatchQ_TechPack_Select.aspx', N'S', 1, N'spx_BatchQGrid_SELECT', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[pBatchQueuePageType] ([BatchQueuePageTypeID], [BatchQueuePageTypeName], [BatchQueuePageTypeDesc], [BatchQueuePagePkID], [BatchQueuePageXmlSearch], [BatchQueuePageXmlForm], [BatchQueuePageXmlGrid], [BatchQueuePageXmlSelected], [BatchQueuePageUrl], [BatchQueuePageRecType], [BatchQueuePageRecMax], [BatchQueuePageSPX], [BatchQueueExecuteSPX], [CUser], [CDate], [MUser], [MDate], [BatchQueueLogicInsertSPX], [BatchQueuepageXMLGridAlternating], [BatchQueueGridAlternatingName], [BatchQueueGridXMLThumbnail], [BatchQueuePageXmlColorGrid]) VALUES (N'90000000-0000-A000-0005-000000000030', N'Create Tech Pack', N'Batch Queue Tech Pack', N'StyleID', NULL, NULL, NULL, NULL, N'BatchQ_TechPack_Review.aspx', N'M', 0, N'spx_BatchQGrid_StyleMaterialColor_Review_SELECT', N'spx_BatchQJob_TechPack_EXECUTE', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)

INSERT [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES (N'90000000-0000-0000-0000-000000000030', N'90000000-0000-A000-0000-000000000030', N'90000000-0000-0000-0000-000000000030', N'0000', NULL, NULL, NULL, NULL)
INSERT [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES (N'90000000-0000-0000-0001-000000000030', N'90000000-0000-A000-0001-000000000030', N'90000000-0000-0000-0000-000000000030', N'0001', NULL, NULL, NULL, NULL)
INSERT [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES (N'90000000-0000-0000-0002-000000000030', N'90000000-0000-A000-0002-000000000030', N'90000000-0000-0000-0000-000000000030', N'0002', NULL, NULL, NULL, NULL)
INSERT [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES (N'90000000-0000-0000-0003-000000000030', N'90000000-0000-A000-0003-000000000030', N'90000000-0000-0000-0000-000000000030', N'0003', NULL, NULL, NULL, NULL)
INSERT [dbo].[pBatchQueuePage] ([BatchQueuePageID], [BatchQueuePageTypeID], [BatchQueueID], [BatchQueuePageOrder], [CUser], [CDate], [MUser], [MDate]) VALUES (N'90000000-0000-0000-0005-000000000030', N'90000000-0000-A000-0005-000000000030', N'90000000-0000-0000-0000-000000000030', N'0005', NULL, NULL, NULL, NULL)

INSERT [dbo].[pBatchQueuePageDep] ([BatchQueuePageDepID], [BatchQueuePageID], [BatchQueuePageRelationID]) VALUES (N'90000000-0000-B000-0000-000000000030', N'90000000-0000-0000-0001-000000000030', N'90000000-0000-0000-0000-000000000030')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06913', GetDate())
GO
