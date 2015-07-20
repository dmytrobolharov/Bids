
GO

-- insert default values into pControlPanelType
if not exists (select * from pControlPanelType WHERE UPPER(ControlPanelTypeName) = 'VALIDATED TABLES')
	begin		
		INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate], [Active], [Sort]) VALUES (N'ecc16935-3677-e011-8802-000c29807141', N'Validated Tables', N'Validated Tables', N'administrator ', CAST(0x00009EDA00C00BAC AS DateTime), N'administrator ', CAST(0x00009EDA00D6DD78 AS DateTime), 1, N'002')
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'DIVISION')
		begin	
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (10, N'Division', N'Division', 140, NULL, N'Control_Custom_iCustom1_Default.xml', N'Control_Custom_iCustom1_Search.xml', N'iCustom1', N'Control_Custom_List.aspx?CPID=10', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'72546312-66c1-4050-a6ff-7fde465f69ea')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'SIZE RANGE')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (16, N'Size Range ', N'Style Size Range Yunique', 235, NULL, N'Control_SizeRange_Default.xml', N'Control_SizeRange_Search.xml', N'pSizeRange', N'Control_SizeRange_ListYnique.aspx?CPID=16', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'428ad14f-53ed-4e26-8591-ae84911ed59d')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'SEASON')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (25, N'Season', N'Season', 225, NULL, N'Control_pSeason_Default.xml', N'Control_pSeason_Search.xml', N'pSeason', N'Control_Custom_List.aspx?CPID=25', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'a3bbcf78-d00c-46de-a455-3d724328f27b')
		end
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'STATUS')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (305, N'Status', N'Status', 240, NULL, N'Control_Custom_xCustom8_Default.xml', N'Control_Custom_xCustom8_Search.xml', N'xCustom8', N'Control_Custom_List.aspx?CPID=305', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'4f3c67a8-4849-41e4-bc32-2518049a7656')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'CATEGORY')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (318, N'Category', N'Category', 125, NULL, N'Control_xCustom2_Default.xml', N'Control_xCustom2_Search.xml', N'xCustom2', N'Control_Custom_List.aspx?CPID=318', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'de2282ab-f2a3-4c7d-9bfa-1f8f09b9aaaf')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'PRODUCT TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (319, N'Product Type', N'Product Type', 215, NULL, N'Control_xCustom3_Default.xml', N'Control_xCustom3_Search.xml', N'xCustom3', N'Control_Custom_List.aspx?CPID=319', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'3e09ca75-787c-46c3-9a8f-ccbc2c4cc186')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'CUSTOMER')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (320, N'Customer', N'Customer', 115, NULL, N'Control_xCustom4_Default.xml', N'Control_xCustom4_Search.xml', N'xCustom4', N'Control_Custom_List.aspx?CPID=320', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'f8562762-a91b-48cb-beda-63fafbb79d41')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'GARMENT TREATMENT')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (321, N'Garment Treatment', N'Garment Treatment', 160, NULL, N'Control_xCustom5_Default.xml', N'Control_xCustom5_Search.xml', N'xCustom5', N'Control_Custom_List.aspx?CPID=321', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'08b70208-1368-4472-babe-7965231cf734')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'MATERIAL TREATMENT')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (322, N'Material Treatment', N'Material Treatment', 195, NULL, N'Control_pMaterialTreatment_Default.xml', N'Control_pMaterialTreatment_Search.xml', N'pMaterialTreatment', N'Control_Custom_List.aspx?CPID=322', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'12799e0f-296f-481a-a722-b9f0e4afb4e9')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'SIZE CLASS')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (323, N'Size Class', N'Size Class', 230, NULL, N'Control_pSizeClass_Default.xml', N'Control_pSizeClass_Search.xml', N'pSizeClass', N'Control_Custom_List.aspx?CPID=323', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'6c1ee973-b94a-4aa2-bded-3e53e39973e5')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'YEAR')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (324, N'Year', N'Year', 275, NULL, N'Control_pYear_Default.xml', N'Control_pYear_Search.xml', N'pYear', N'Control_Custom_List.aspx?CPID=324', NULL, NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'881e8391-09fb-47c5-9ce4-72a4df833c06')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'EXCHANGE RATE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (325, N'Exchange Rate', N'Exchange Rate', 157, NULL, N'Control_Custom_ExchangeRate_Default.xml', N'Control_Custom_ExchangeRate_Search.xml', N'sExchangeRate', N'Control_ExchangeRate_List.aspx?CPID=325', N'Control_Custom_ExchangeRateEdit_Default.xml', NULL, NULL, N'ecc16935-3677-e011-8802-000c29807141', N'f6f69237-f80e-4f37-890a-00d7e8f94bff')
			end
			
	end
	GO
if not exists (select * from pControlPanelType WHERE UPPER(ControlPanelTypeName) = 'CARE')
	begin	
		INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate], [Active], [Sort]) VALUES (N'd15ca3b7-3777-e011-8802-000c29807141', N'Care', N'Care', N'administrator ', CAST(0x00009EDA00C3030C AS DateTime), N'administrator ', CAST(0x00009EDA00D77A80 AS DateTime), 1, N'004')
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'WASHING')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (33, N'Washing', N'Washing Care Instructions', 260, NULL, N'Control_Custom_pStyleCareWash_Default.xml', N'Control_Custom_pStyleCareWash_Search.xml', N'pStyleCareWash', N'Control_Custom_List.aspx?CPID=33', NULL, NULL, NULL, N'd15ca3b7-3777-e011-8802-000c29807141', N'3fcd2841-8fe8-457e-bfd9-364af8fe97c0')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'IRONING')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (35, N'Ironing', N'Ironing Care Instructions', 170, NULL, N'Control_Custom_pStyleCareIron_Default.xml', N'Control_Custom_pStyleCareIron_Search.xml', N'pStyleCareIron', N'Control_Custom_List.aspx?CPID=35', NULL, NULL, NULL, N'd15ca3b7-3777-e011-8802-000c29807141', N'eb255a85-b79c-4ba3-80d3-12d348e724aa')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'CYCLE')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (37, N'Cycle', N'Cycle Care Instructions', 120, NULL, N'Control_Custom_pStyleCareCycle_Default.xml', N'Control_Custom_pStyleCareCycle_Search.xml', N'pStyleCareCycle', N'Control_Custom_List.aspx?CPID=37', NULL, NULL, NULL, N'd15ca3b7-3777-e011-8802-000c29807141', N'77474d9f-15f7-43dc-8249-a03271971dd6')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'BLEACH')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (39, N'Bleach', N'Bleaching Care Instructions', 105, NULL, N'Control_Custom_pStyleCareBleach_Default.xml', N'Control_Custom_pStyleCareBleach_Search.xml', N'pStyleCareBleach', N'Control_Custom_List.aspx?CPID=39', NULL, NULL, NULL, N'd15ca3b7-3777-e011-8802-000c29807141', N'1f8bad11-0a09-477f-8b00-fcd740ff77a9')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'DRYING')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (41, N'Drying', N'Drying Care Instructions', 150, NULL, N'Control_Custom_pStyleCareDry_Default.xml', N'Control_Custom_pStyleCareDry_Search.xml', N'pStyleCareDry', N'Control_Custom_List.aspx?CPID=41', NULL, NULL, NULL, N'd15ca3b7-3777-e011-8802-000c29807141', N'650a7ff4-794e-468a-8609-a3fbeb79b186')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'DRY CLEANING')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (43, N'Dry Cleaning', N'Dry Cleaning Care Instructions', 145, NULL, N'Control_Custom_pStyleCareDryClean_Default.xml', N'Control_Custom_pStyleCareDryClean_Search.xml', N'pStyleCareDryClean', N'Control_Custom_List.aspx?CPID=43', NULL, NULL, NULL, N'd15ca3b7-3777-e011-8802-000c29807141', N'a3b47301-66f8-4904-97d5-1f8c054bc638')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'CARE TEMPLATE')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (202, N'Care Template', N'Care Template', 110, NULL, N'Control_Care_Default.xml', N'Control_Care_Search.xml', N'pTemplateCare', N'Control_Care_List.aspx?CPID=202', NULL, NULL, NULL, N'd15ca3b7-3777-e011-8802-000c29807141', N'0fe285d3-68a9-42a9-9a38-534812636f10')
		end
		
	end
	GO
if not exists (select * from pControlPanelType WHERE UPPER(ControlPanelTypeName) = 'MATERIAL FOLDER')
	begin	
		INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate], [Active], [Sort]) VALUES (N'd25ca3b7-3777-e011-8802-000c29807141', N'Material Folder', N'Material Folder', N'administrator ', CAST(0x00009EDA00C3030C AS DateTime), N'administrator ', CAST(0x00009EDA00D6DD78 AS DateTime), 1, N'003')
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'KNIT TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (306, N'Knit Type', N'Knit Type', 175, NULL, N'Control_xCustom10_Default.xml', N'Control_xCustom10_Search.xml', N'xCustom10', N'Control_Custom_List.aspx?CPID=306', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'ca2cd5e1-d590-4394-bde6-4d2685e0b09c')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'WOVEN TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (307, N'Woven Type', N'Woven Type', 265, NULL, N'Control_xCustom12_Default.xml', N'Control_xCustom12_Search.xml', N'xCustom12', N'Control_Custom_List.aspx?CPID=307', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'bba608f7-c149-4367-b5d4-7801e08b1ee9')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'ZIPPER TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (308, N'Zipper Type', N'Zipper Type', 280, NULL, N'Control_xCustom13_Default.xml', N'Control_xCustom13_Search.xml', N'xCustom13', N'Control_Custom_List.aspx?CPID=308', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'23e25563-5f6f-4a5e-baa9-424ee2bc3127')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'TRIMMING TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (309, N'Trimming Type', N'Trimming Type', 255, NULL, N'Control_xCustom14_Default.xml', N'Control_xCustom14_Search.xml', N'xCustom14', N'Control_Custom_List.aspx?CPID=309', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'003ae606-7d68-4239-8800-66b713009000')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'LABEL TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (310, N'Label Type', N'Label Type', 180, NULL, N'Control_xCustom15_Default.xml', N'Control_xCustom15_Search.xml', N'xCustom15', N'Control_Custom_List.aspx?CPID=310', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'156090d7-eb69-4709-8213-5aab2532d1de')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'PACKAGING TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (311, N'Packaging Type', N'Packaging Type', 200, NULL, N'Control_xCustom16_Default.xml', N'Control_xCustom16_Search.xml', N'xCustom16', N'Control_Custom_List.aspx?CPID=311', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'0ea28819-c0bb-4d6a-b43a-ea6a62b5cb7c')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'INTERLINING TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (312, N'Interlining Type', N'Interlining Type', 165, NULL, N'Control_xCustom17_Default.xml', N'Control_xCustom17_Search.xml', N'xCustom17', N'Control_Custom_List.aspx?CPID=312', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'f1e8570a-2792-4c05-8f27-b9dc15ae199a')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'LINING TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (313, N'Lining Type', N'Lining Type', 185, NULL, N'Control_xCustom18_Default.xml', N'Control_xCustom18_Search.xml', N'xCustom18', N'Control_Custom_List.aspx?CPID=313', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'8cc54df8-9b77-44ff-92f4-c53368730b52')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'EMBROIDERY TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (314, N'Embroidery Type', N'Embroidery Type', 155, NULL, N'Control_xCustom19_Default.xml', N'Control_xCustom19_Search.xml', N'xCustom19', N'Control_Custom_List.aspx?CPID=314', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'5a745fb2-09a1-4732-bcb1-9353119e6454')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'ARTWORK TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (315, N'Artwork Type', N'Artwork Type', 100, NULL, N'Control_xCustom22_Default.xml', N'Control_xCustom22_Search.xml', N'xCustom22', N'Control_Custom_List.aspx?CPID=315', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'764b8a42-e587-49f7-accb-fcd2854feecc')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'THREAD TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (316, N'Thread Type', N'Thread Type', 250, NULL, N'Control_xCustom23_Default.xml', N'Control_xCustom23_Search.xml', N'xCustom23', N'Control_Custom_List.aspx?CPID=316', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'379ea58a-4fcd-4af4-9e62-44aa1afd266a')
			end
			
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'YARN TYPE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (317, N'Yarn Type', N'Yarn Type', 270, NULL, N'Control_xCustom24_Default.xml', N'Control_xCustom24_Search.xml', N'xCustom24', N'Control_Custom_List.aspx?CPID=317', NULL, NULL, NULL, N'd25ca3b7-3777-e011-8802-000c29807141', N'5b7c589c-8615-480d-95a9-846a097fb497')
			end
			
	end
	GO
if not exists (select * from pControlPanelType WHERE UPPER(ControlPanelTypeName) = 'WORKFLOWS')
	begin	
		INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate], [Active], [Sort]) VALUES (N'4bf85575-3877-e011-8802-000c29807141', N'Workflows', N'Workflows', N'administrator ', CAST(0x00009EDA00C478E0 AS DateTime), N'administrator ', CAST(0x00009EDF0098CD30 AS DateTime), 1, N'001')
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'DEVELOPMENT WORKFLOW')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (28, N'Development Workflow', N'Development Workflow', 135, NULL, N'Control_Workflow_Default.xml', NULL, NULL, N'Control_Workflow_List.aspx?CPID=28', NULL, NULL, NULL, N'4bf85575-3877-e011-8802-000c29807141', N'0ab649b9-5994-441c-a503-9ed235d4a7c5')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'SAMPLE WORKFLOW')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (30, N'Sample Workflow', N'Sample Workflow Template', 220, NULL, N'Control_Workflow_Sample_Default.xml', N'Control_Workflow_Sample_Search.xml', N'pSampleWorkflowTemplate', N'Control_Workflow_Sample_List.aspx?CPID=30', NULL, NULL, NULL, N'4bf85575-3877-e011-8802-000c29807141', N'2ce73eef-7e80-40cf-865d-16d292fcc5c7')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'MATERIAL REQUEST WORKFLOW')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (60, N'Material Request Workflow', N'Material Request Workflow Template', 190, NULL, N'Control_Workflow_Sample_Default.xml', N'Control_Workflow_Sample_Search.xml', N'pSampleWorkflowTemplate', N'Control_Workflow_MaterialRequest_List.aspx?CPID=60', NULL, NULL, NULL, N'4bf85575-3877-e011-8802-000c29807141', N'16d5c2ec-3397-4448-804b-8847bfb69528')
		end
		
	end
	GO
if not exists (select * from pControlPanelType WHERE UPPER(ControlPanelTypeName) = 'DETAILS')
	begin	
		INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate], [Active], [Sort]) VALUES (N'be3fa19c-3877-e011-8802-000c29807141', N'Details', N'Details', N'administrator ', CAST(0x00009EDA00C4C638 AS DateTime), N'administrator ', CAST(0x00009EDA00D6DD78 AS DateTime), 1, N'005')
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'DESIGN TEMPLATE')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (19, N'Design Template', N'Design Detail Template', 130, NULL, N'Control_DesignDetail_Default.xml', NULL, NULL, N'Control_DesignDetail_List.aspx?CPID=19', NULL, NULL, NULL, N'be3fa19c-3877-e011-8802-000c29807141', N'65d9a93f-1928-41b4-b5e0-def98eff53a5')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'STITCH TYPE')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (201, N'Stitch Type', N'Stitch Type', 245, NULL, N'Control_Custom_pStitchType_Default.xml', N'Control_Custom_pStitchType_Search.xml', N'pStitchType', N'Control_Custom_List.aspx?CPID=201', NULL, NULL, NULL, N'be3fa19c-3877-e011-8802-000c29807141', N'3a828c05-029b-4007-84c5-ba900996f992')
		end
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'PROCESS DETAILS')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (326, N'Process Details', N'Process Details', 281, NULL, NULL, NULL, N'pConstructTree', N'Control_ConstructionDetails_List.aspx?CPID=326', NULL, NULL, NULL, N'be3fa19c-3877-e011-8802-000c29807141', N'248c6b12-7122-4a48-979b-a535b1158d28')
		end
		
	end
	GO
if not exists (select * from pControlPanelType WHERE UPPER(ControlPanelTypeName) = 'MEASUREMENTS')
	begin	
		INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate], [Active], [Sort]) VALUES (N'8de249f4-3e77-e011-8802-000c29807141', N'Measurements', N'Measurements', N'administrator ', CAST(0x00009EDA00D13E68 AS DateTime), N'administrator ', CAST(0x00009EDA00D6DD78 AS DateTime), 1, N'006')
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'MEASUREMENTS')
			begin				
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (15, N'Measurements', N'Measurements Library', 2, NULL, NULL, NULL, NULL, N'Control_Measurement.aspx?CPID=15', NULL, NULL, NULL, N'8de249f4-3e77-e011-8802-000c29807141', N'e6c62d07-d9b1-4a1b-8ba8-a7ad7ed2a3a3')
			end
			
			if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'MEASUREMENTS SIZE CLASS')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (17, N'Measurements Size Class', N'Measurements Size Class', 3, NULL, N'Control_GRSizeClass_Library.xml', N'Control_GRSizeClass_SearchLibrary.xml', N'pGRSizeClass', N'Control_SizeClass_GR.aspx?CPID=17', NULL, NULL, NULL, N'8de249f4-3e77-e011-8802-000c29807141', N'7a28d0c5-4018-49ed-a7cb-43ff1c8fa65a')
			end
			
			if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'MEASUREMENTS SIZE RANGE')
			begin		
				INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (20, N'Measurements Size Range', N'Measurements Size Range', 2, NULL, N'Control_GRSizeRange_Default.xml', N'Control_GRSizeRange_Search.xml', N'pGRSizeRange', N'Control_SizeRange_GR.aspx?CPID=20', NULL, NULL, NULL, N'8de249f4-3e77-e011-8802-000c29807141', N'f104cbc4-4a4f-405a-987b-3f221dd78e71')
			end
			
	end
	GO
	
if not exists (select * from pControlPanelType WHERE UPPER(ControlPanelTypeName) = 'POM')
	begin	
		INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate], [Active], [Sort]) VALUES (N'b7f6792b-3f77-e011-8802-000c29807141', N'POM', N'POM', N'administrator ', CAST(0x00009EDA00D1AA38 AS DateTime), N'administrator ', CAST(0x00009EDA00D6DD78 AS DateTime), 1, N'007')
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'POM LIBRARY')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (26, N'POM Library', N'POM Library', 205, NULL, NULL, NULL, N'pPOMTemplate', N'Control_POMLibrary_Edit.aspx?CPID=26', NULL, NULL, NULL, N'b7f6792b-3f77-e011-8802-000c29807141', N'd6eae844-7519-4e4b-89d8-ca979e0aaff1')
		end
		
		
		if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'POM TEMPLATE')
		begin		
			INSERT [dbo].[pControlPanel] ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelIdSchema], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [SPXLogicInsert], [SPXLogicUpdate], [ControlPanelTypeID], [ControlPanelRepId]) VALUES (27, N'POM Template', N'POM', 210, NULL, N'Control_POMTemplate_Default.xml', NULL, NULL, N'Control_POMTemplate_List.aspx?CPID=27', NULL, NULL, NULL, N'b7f6792b-3f77-e011-8802-000c29807141', N'4c9b9f14-583f-4e40-a9e7-b90a553b6ec9')
		end
		
	end
	GO
if not exists (select * from pControlPanelType WHERE UPPER(ControlPanelTypeName) = 'OTHER')
	begin	
		INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate], [Active], [Sort]) VALUES (N'd15ca3b7-3777-e011-8802-000c29807142', N'Other', N'Other', N'administrator ', CAST(0x00009EDA00C3030C AS DateTime), N'administrator ', CAST(0x00009EDA00D77A80 AS DateTime), 1, N'008')
		begin
		UPDATE pControlPanel SET 
			ControlPanelTypeID = (SELECT ControlPanelTypeID FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) ='OTHER')
			WHERE     (ControlPanelTypeID IS NULL)
		end
		
	END 
	GO


-- insert default values into pControlPanel



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01459', GetDate())
GO
