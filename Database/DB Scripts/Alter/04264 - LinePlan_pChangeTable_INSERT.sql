-- Line Plan Header
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '10000001-AAAA-DFDF-AF06-00101FF00019')
BEGIN
	INSERT INTO pChangeTable 
	VALUES('10000001-AAAA-DFDF-AF06-00101FF00019', 'pLinePlan', 'LinePlanID', 'LinePlanID', 'ChangeLogItem_LinePlan.xml')
END

-- Range planning
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '10000002-AAAA-DFDF-AF06-00101FF00019')
BEGIN
	INSERT INTO pChangeTable 
	VALUES('10000002-AAAA-DFDF-AF06-00101FF00019', 'pLinePlanRange', 'LinePlanRangeID', 'LinePlanAttributeItemID', 'ChangeLogItem_LinePlan.xml')
END

-- Color planning
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '10000003-AAAA-DFDF-AF06-00101FF00019')
BEGIN
	INSERT INTO pChangeTable 
	VALUES('10000003-AAAA-DFDF-AF06-00101FF00019', 'pLinePlanColorItem', 'LinePlanRangeID', 'LinePlanAttributeItemID', 'ChangeLogItem_LinePlan.xml')
END

-- Material planning
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '10000004-AAAA-DFDF-AF06-00101FF00019')
BEGIN
	INSERT INTO pChangeTable 
	VALUES('10000004-AAAA-DFDF-AF06-00101FF00019', 'pLinePlanMaterialItem', 'LinePlanRangeID', 'LinePlanAttributeItemID', 'ChangeLogItem_LinePlan.xml')
END

-- Line planning
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '10000005-AAAA-DFDF-AF06-00101FF00019')
BEGIN
	INSERT INTO pChangeTable 
	VALUES('10000005-AAAA-DFDF-AF06-00101FF00019', 'pLinePlanItem', 'LinePlanRangeID', 'LinePlanAttributeItemID', 'ChangeLogItem_LinePlan.xml')
END

-- Financial plan
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'D612AAAA-BBBB-DF11-AFCC-FF5056C000DD')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES('D612AAAA-BBBB-DF11-AFCC-FF5056C000DD','pLinePlanBusiness','LinePlanBusinessID','LinePlanBusinessID','ChangeLogItem_LinePlan.xml')
END

-- Silhouette plan
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'D612AACD-DDDD-DF11-AFCC-CC5056C000DD')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES('D612AACD-DDDD-DF11-AFCC-CC5056C000DD','pLinePlanBodyItem','LinePlanBodyItemID','LinePlanBodyItemID','ChangeLogItem_LinePlan.xml')
END

-- Sourcing plan
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'D612AAAA-BBBB-DF11-AFCC-BB5056C0AA34')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES('D612AAAA-BBBB-DF11-AFCC-BB5056C0AA34','pLinePlanTradePartner','LinePlanTradePartnerID','LinePlanTradePartnerID','ChangeLogItem_LinePlan.xml')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04264', GetDate())
GO
