insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('D613FAAE-7ACD-DF11-AF06-FF5056C00025','pStyleWardrobeRelation','StyleWardrobeRelataionID','StyleWardrobeRelataionID','ChangeLogItem_Advanced.xml')
INSERT INTO pStyleWorkflowToChangeTable(WorkflowID, ChangeTableID) values('40000000-0000-0000-0000-000000000085','D613FAAE-7ACD-DF11-AF06-FF5056C00025')

GO 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05700', GetDate())
GO



