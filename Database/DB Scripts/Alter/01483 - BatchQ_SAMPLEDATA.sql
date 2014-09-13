
INSERT pBatchQueueType(BatchQueueTypeID,BatchQueueTypeName,BatchQueueTypeDesc,BatchQueueTypeURL,BatchQueueTypeIcon,CUser,CDate,MUser,MDate,Active) VALUES('F459C2F2-657A-E011-9847-005056C00008','Material Folder',NULL,NULL,'icon_folder_table.gif',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121),'1')
GO
INSERT pBatchQueueType(BatchQueueTypeID,BatchQueueTypeName,BatchQueueTypeDesc,BatchQueueTypeURL,BatchQueueTypeIcon,CUser,CDate,MUser,MDate,Active) VALUES('F459C2F2-657A-E011-9848-005056C00008','Style Folder',NULL,NULL,'icon_folder_table.gif',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121),'1')
GO
INSERT pBatchQueue
(BatchQueueID,BatchQueueTypeID,BatchQueueName,BatchQueueDesc,BatchQueueUrl,BatchQueueIcon,CUser,CDate,MUser,MDate) 
VALUES
('90000000-0000-0000-0000-000000000003','F459C2F2-657A-E011-9848-005056C00008','Mass Add Materials',NULL,'BatchQ_Page.aspx','icon_tables_stacks.gif',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121))
GO

INSERT pBatchQueuePageType(BatchQueuePageTypeID,BatchQueuePageTypeName,BatchQueuePageTypeDesc,BatchQueuePagePkID,BatchQueuePageXmlSearch,BatchQueuePageXmlForm,BatchQueuePageXmlGrid,BatchQueuePageXmlSelected,BatchQueuePageUrl,BatchQueuePageRecType,BatchQueuePageRecMax,CUser,CDate,MUser,MDate) VALUES('44E5E4E3-DD70-E011-9039-8EF3DCCB61B1','Select Raw Materials','Please select raw materials','MaterialID','BatchQ_Material_Seasonal_Search.xml',NULL,'BatchQ_Material_Seasonal_Default.xml','BatchQ_Material_Seasonal_Selected.xml','BatchQ_Grid.aspx','M','5',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121))
GO
INSERT pBatchQueuePageType(BatchQueuePageTypeID,BatchQueuePageTypeName,BatchQueuePageTypeDesc,BatchQueuePagePkID,BatchQueuePageXmlSearch,BatchQueuePageXmlForm,BatchQueuePageXmlGrid,BatchQueuePageXmlSelected,BatchQueuePageUrl,BatchQueuePageRecType,BatchQueuePageRecMax,CUser,CDate,MUser,MDate) VALUES('44E5E4E3-DD70-E011-9039-8EF3DCCB61B2','Select Styles','Please select styles','StyleID','BatchQ_StyleSeasonal_Search.xml',NULL,'BatchQ_StyleSeasonal_Default.xml','BatchQ_StyleSeasonal_Selected.xml','BatchQ_Grid.aspx','M','10',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121))
GO
INSERT pBatchQueuePageType(BatchQueuePageTypeID,BatchQueuePageTypeName,BatchQueuePageTypeDesc,BatchQueuePagePkID,BatchQueuePageXmlSearch,BatchQueuePageXmlForm,BatchQueuePageXmlGrid,BatchQueuePageXmlSelected,BatchQueuePageUrl,BatchQueuePageRecType,BatchQueuePageRecMax,CUser,CDate,MUser,MDate) VALUES('99A5E4E3-DD70-E011-9039-8EF3DCCB61B6','Find Season & Year','Select season and year','SeasonYearID','SeasonYear_Search.xml',NULL,'BatchQ_SeasonYear_Default.xml','BatchQ_SeasonYear_Default.xml','BatchQ_Grid.aspx','S','1',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121))
GO
INSERT pBatchQueuePageType(BatchQueuePageTypeID,BatchQueuePageTypeName,BatchQueuePageTypeDesc,BatchQueuePagePkID,BatchQueuePageXmlSearch,BatchQueuePageXmlForm,BatchQueuePageXmlGrid,BatchQueuePageXmlSelected,BatchQueuePageUrl,BatchQueuePageRecType,BatchQueuePageRecMax,CUser,CDate,MUser,MDate) VALUES('34E5E4E3-DD70-E011-9039-8EF3DCCB61B6','Find Color Folder','Please select a color folder','ColorFolderID','BatchQ_ColorFolder_Search.xml',NULL,'BatchQ_ColorFolder_Default.xml','BatchQ_ColorFolder_Default.xml','BatchQ_Grid.aspx','S','1',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121))
GO
INSERT pBatchQueuePageType(BatchQueuePageTypeID,BatchQueuePageTypeName,BatchQueuePageTypeDesc,BatchQueuePagePkID,BatchQueuePageXmlSearch,BatchQueuePageXmlForm,BatchQueuePageXmlGrid,BatchQueuePageXmlSelected,BatchQueuePageUrl,BatchQueuePageRecType,BatchQueuePageRecMax,CUser,CDate,MUser,MDate) VALUES('1734DB07-DE70-E011-9039-8EF3DCCB61B6','Select a color palette','Please select a single color palette','ColorPaletteID','BatchQ_Color_Palette_Search.xml',NULL,'BatchQ_Color_Palette_Default.xml','BatchQ_Color_Palette_Default.xml','BatchQ_Grid.aspx','M','0',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121))
GO
INSERT pBatchQueuePage(BatchQueuePageID,BatchQueuePageTypeID,BatchQueueID,BatchQueuePageOrder,CUser,CDate,MUser,MDate) VALUES('7C3D653A-1288-E011-81E9-005056C00008','99A5E4E3-DD70-E011-9039-8EF3DCCB61B6','90000000-0000-0000-0000-000000000003','0000',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121))
GO
INSERT pBatchQueuePage(BatchQueuePageID,BatchQueuePageTypeID,BatchQueueID,BatchQueuePageOrder,CUser,CDate,MUser,MDate) VALUES('7D3D653A-1288-E011-81E9-005056C00008','44E5E4E3-DD70-E011-9039-8EF3DCCB61B1','90000000-0000-0000-0000-000000000003','0001',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121))
GO
INSERT pBatchQueuePage(BatchQueuePageID,BatchQueuePageTypeID,BatchQueueID,BatchQueuePageOrder,CUser,CDate,MUser,MDate) VALUES('4ACB8240-1288-E011-81E9-005056C00008','44E5E4E3-DD70-E011-9039-8EF3DCCB61B2','90000000-0000-0000-0000-000000000003','0002',NULL,convert(datetime,NULL,121),NULL,convert(datetime,NULL,121))
GO
INSERT pBatchQueuePageDep(BatchQueuePageDepID,BatchQueuePageID,BatchQueuePageRelationID) VALUES('EB1B7BEB-1988-E011-81E9-005056C00008','7D3D653A-1288-E011-81E9-005056C00008','7C3D653A-1288-E011-81E9-005056C00008')
GO
INSERT pBatchQueuePageDep(BatchQueuePageDepID,BatchQueuePageID,BatchQueuePageRelationID) VALUES('4FDED4F3-1988-E011-81E9-005056C00008','4ACB8240-1288-E011-81E9-005056C00008','7C3D653A-1288-E011-81E9-005056C00008')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01483', GetDate())
GO
