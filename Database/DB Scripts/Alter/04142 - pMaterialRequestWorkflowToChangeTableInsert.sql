
insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00008','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')

insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00009','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')


insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00010','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')


insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00011','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')


insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00012','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')


insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00013','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')


insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00014','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')



insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00015','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')


insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00016','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')


insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00017','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')


insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00018','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')


insert into pChangeTable(ChangeTableID,ChangetableName,ChangetableFieldName,ChangetablePKName,ChangetableXML) values('40000000-aaaa-dfdf-af06-005056c00019','pMaterialRequestWorkflow','MaterialID','MaterialWorkflowID','ChangeLogItem_AdvancedMR.xml')


insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A10','40000000-aaaa-dfdf-af06-005056c00008')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A15','40000000-aaaa-dfdf-af06-005056c00009')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A20','40000000-aaaa-dfdf-af06-005056c00010')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A30','40000000-aaaa-dfdf-af06-005056c00011')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A40','40000000-aaaa-dfdf-af06-005056c00012')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A80','40000000-aaaa-dfdf-af06-005056c00013')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A84','40000000-aaaa-dfdf-af06-005056c00014')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A88','40000000-aaaa-dfdf-af06-005056c00015')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A90','40000000-aaaa-dfdf-af06-005056c00016')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A94','40000000-aaaa-dfdf-af06-005056c00017')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A96','40000000-aaaa-dfdf-af06-005056c00018')

insert into pMaterialRequestToChangeTable(MaterialRequestWorkflowID,ChangeTableID) values('A98','40000000-aaaa-dfdf-af06-005056c00019')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04142', GetDate())
GO