IF NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID = '31caa67d-dd7d-41f6-ae5b-a27c3204b9fc')
BEGIN
	INSERT [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) 
	VALUES (N'31caa67d-dd7d-41f6-ae5b-a27c3204b9fc', N'pLineFolder', N'PlanningID', N'LineFolderID', N'ChangeLogItem_Default.xml')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06686', GetDate())
GO
