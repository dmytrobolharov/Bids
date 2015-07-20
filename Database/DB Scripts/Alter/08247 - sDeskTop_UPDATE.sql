UPDATE sDeskTop SET DeskMain = '../Style/Style_List_Search.aspx?' WHERE DeskName = 'Style'
UPDATE sDeskTop SET DeskMain = '../Style/Style_List_Search.aspx?Silho=1' WHERE DeskName = 'Silhouette'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08247', GetDate())
GO
