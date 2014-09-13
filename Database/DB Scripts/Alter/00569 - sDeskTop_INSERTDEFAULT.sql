

DELETE FROM sDeskTop
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (1, 'Home', 'Home Page', 'icon_home.gif', 'Home', null, 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=1'';', '01', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (3, 'Color', 'Color Folder', 'icon_colorway.gif', 'Color', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=3'';', '03', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (4, 'Image', 'Image Folder', 'icon_image.gif', 'Image', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=4'';', '04', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (5, 'Material', 'Raw Material Folder', 'icon_puzzle.gif', 'Raw Material', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=5'';', '05', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (7, 'Body', 'Body Folder', 'icon_body.gif', 'Body', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=7'';', '07', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (8, 'Style', 'Style Folder', 'icon_shirt.gif', 'Style', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=8'';', '08', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (9, 'Line List', 'Line List Folder', 'icon_image_catalog.gif', 'Line List', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=9'';', '09', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (11, 'BI', 'Business Intelligence Folder', 'icon_report.gif', 'Business', 'Intelligence', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=11'';', '50', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (15, 'Compliance', 'Compliance Folder', 'icon_globe.gif', 'Compliance', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=15'';', '15', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (25, 'Flash Edit', 'Flash Edit Folder', 'icon_tables_stacks.gif', 'Flash Edit', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=25'';', '25', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (26, 'Batch Queue', 'Batch Queue Folder', 'icon_storeF.gif', 'Batch Queue', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=26'';', '26', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (30, 'Control', 'Control Panel', 'icon_toolbox.gif', 'Control', 'Panel', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=30'';', '30', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (40, 'Administrator', 'Administrator Folder', 'icon_locked.gif', 'Administrator', 'Folder', 'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=40'';', '40', 1)
GO
INSERT INTO sDeskTop(DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskSort, DeskActive) VALUES (100, 'Log Off', 'Log Off', 'icon_close_1.gif', 'Log Off', null, 'parent.dbody.location = ''../Desk/Desk_LogOff.aspx?DTID=100'';', '99', 1)
GO
UPDATE AspNet_SqlCacheTablesForChangeNotification SET changeId = 101 WHERE TableName = 'sDeskTop'
GO


