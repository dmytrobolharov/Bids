IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'D612ADCB-BBBB-2211-AFCC-ABCD56C000DD')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('D612ADCB-BBBB-2211-AFCC-ABCD56C000DD','pSeasonYear','SeasonYearID','SeasonYearID','ChangeLogItem_Advanced.xml')
END

IF(NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID='df9f7814-45e6-44fc-baaa-ccc9dfd67286'))
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('df9f7814-45e6-44fc-baaa-ccc9dfd67286','pMaterialTemplate','MaterialTemplateID','MaterialTemplateID','ChangeLogItem_Advanced.xml')
END

IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'D6121122-BBBB-3332-AFC1-ABCD56CBBDDD')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('D6121122-BBBB-3332-AFC1-ABCD56CBBDDD','pMaterialColor','MaterialColorID','MaterialColorID','ChangeLogItem_Advanced.xml')
END

IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '5612ADDD-CDAB-2211-AACC-DDCD78C000DD')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('5612ADDD-CDAB-2211-AACC-DDCD78C000DD','pImage','ImageID','ImageID','ChangeLogItem_Advanced.xml')
END

IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '0610ADDD-CD00-DCBA-BBDC-DDCD7BC000AA')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('0610ADDD-CD00-DCBA-BBDC-DDCD7BC000AA','pMaterialDocument','MaterialDocumentID','MaterialDocumentID','ChangeLogItem_Advanced.xml')
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04348', GetDate())
GO