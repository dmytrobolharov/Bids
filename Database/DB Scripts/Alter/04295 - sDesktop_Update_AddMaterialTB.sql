UPDATE sDeskTop SET DeskMain = '../Material/Material_List_Grid.aspx?TB=S' WHERE DeskName = 'Material'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04295', GetDate())
GO
