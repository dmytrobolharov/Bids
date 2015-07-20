IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'B610ADCB-CD22-CABA-BBDC-AACD7BC1230AD')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('B610ADCB-CD22-CABA-BBDC-AACD7BC1230AD','pMaterialColor','MaterialColorID','MaterialColorID','ChangeLogItem_Advanced.xml')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04355', GetDate())
GO
