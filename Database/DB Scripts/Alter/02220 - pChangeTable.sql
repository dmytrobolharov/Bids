
if not EXISTS (select ChangeTableID from pChangeTable where ChangeTableID = '00000010-c1cc-df11-af06-005056c00008')
Begin
	INSERT INTO pChangeTable(ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML) 
	VALUES ('00000010-c1cc-df11-af06-005056c00008', 'pMaterial', 'MaterialID', 'MaterialID', 'ChangeLog_Material_Default.xml')
end

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02220'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02220', GetDate())
END	
GO