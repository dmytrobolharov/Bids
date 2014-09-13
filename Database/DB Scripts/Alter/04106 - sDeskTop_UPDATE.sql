UPDATE sDeskTop SET DeskMain = '../Sourcing/Sourcing_Page_List_Search.aspx?' WHERE DeskName = 'Sourcing'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04106', GetDate())
GO