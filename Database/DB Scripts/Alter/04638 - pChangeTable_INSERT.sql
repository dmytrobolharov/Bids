if NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID = '7938a3fd-0580-435f-a3a6-895ca0333a8f')
begin
	INSERT [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) 
	VALUES (N'7938a3fd-0580-435f-a3a6-895ca0333a8f', N'pColorFolderSeasonYear', N'ColorFolderID', N'ColorFolderID', N'ChangeLogItem_Advanced.xml')
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04638', GetDate())
GO