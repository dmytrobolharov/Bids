IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '7938A3FD-0579-435F-A3A6-895CA0333A8F')
INSERT INTO pChangeTable(ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML) 
VALUES ('7938A3FD-0580-435F-A3A6-895CA0333A8F', 'pColorFolderSeasonYear', 'ColorFolderID', 'ColorFolderID', 'ChangeLogItem_Advanced.xml')
ELSE
BEGIN
UPDATE pChangeTable SET ChangeTableName = 'pColorFolderSeasonYear',
						ChangeTableFieldName = 'ColorFolderID',
						ChangeTablePKName = 'ColorFolderID',
						ChangeTableXML = 'ChangeLogItem_Advanced.xml'
						WHERE ChangeTableID = '7938A3FD-0580-435F-A3A6-895CA0333A8F'
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04261', GetDate())
GO
