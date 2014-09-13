IF EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '10000001-AAAA-DFDF-AF06-00101FF00019')
BEGIN
	UPDATE pChangeTable SET ChangeTableXML = 'ChangeLogItem_LinePlan_Header.xml' WHERE ChangeTableID = '10000001-AAAA-DFDF-AF06-00101FF00019'
END
ELSE
BEGIN
	INSERT INTO pChangeTable 
	VALUES('10000001-AAAA-DFDF-AF06-00101FF00019', 'pLinePlan', 'LinePlanID', 'LinePlanID', 'ChangeLogItem_LinePlan_Header.xml')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04270', GetDate())
GO
