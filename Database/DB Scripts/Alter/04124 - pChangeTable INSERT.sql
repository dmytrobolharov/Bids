insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('10000000-cccc-dfdf-af06-005056c00008','pMaterialRequestVendor','MaterialID','MaterialVendorID','ChangeLogItem_AdvancedMR.xml')
insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('20000000-cccc-dfdf-af06-005056c00008','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')
insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('30000000-cccc-dfdf-af06-005056c00008','pMaterialRequestSubmits','MaterialRequestID','MaterialRequestID','ChangeLogItem_AdvancedMR.xml')
insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('10000000-caca-afaf-af06-005056c00008','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')
GO 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04124', GetDate())
GO