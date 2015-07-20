-- Line Planning Colors
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID='11000001-AAAA-DFDF-AF06-00101FF00019')
BEGIN
	INSERT INTO pChangeTable
	VALUES ('11000001-AAAA-DFDF-AF06-00101FF00019', 'pLinePlanColor', 'LinePlanColorID', 'LinePlanID', 'ChangeLogItem_LinePlan.xml')
END

-- Line Planning Materials
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID='11000002-AAAA-DFDF-AF06-00101FF00019')
BEGIN
	INSERT INTO pChangeTable
	VALUES ('11000002-AAAA-DFDF-AF06-00101FF00019', 'pLinePlanMaterial', 'LinePlanMaterialID', 'LinePlanID', 'ChangeLogItem_LinePlan.xml')
END

-- Line Planning Showrooms
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID='11000003-AAAA-DFDF-AF06-00101FF00019')
BEGIN
	INSERT INTO pChangeTable
	VALUES ('11000003-AAAA-DFDF-AF06-00101FF00019', 'pLinePlanShowroom', 'LinePlanShowroomID', 'LinePlanID', 'ChangeLogItem_LinePlan.xml')
END

-- Line Planning Attributes
IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID='11000004-AAAA-DFDF-AF06-00101FF00019')
BEGIN
	INSERT INTO pChangeTable
	VALUES ('11000004-AAAA-DFDF-AF06-00101FF00019', 'pLinePlanStyleAttribute', 'LinePlanStyleAttributeID', 'LinePlanID', 'ChangeLogItem_LinePlan.xml')
END


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04274', GetDate())
GO
