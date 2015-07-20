IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleType' AND COLUMN_NAME = 'MaterialWhereUsedStyleSchema')
BEGIN
	ALTER TABLE pStyleType ADD MaterialWhereUsedStyleSchema nvarchar(200)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleType' AND COLUMN_NAME = 'MaterialWhereUsedStyleSearchSchema')
BEGIN
	ALTER TABLE pStyleType ADD MaterialWhereUsedStyleSearchSchema nvarchar(200)	
END

GO

UPDATE pStyleType SET MaterialWhereUsedStyleSchema='Material_WhereUsed_Style_Apparel.xml' WHERE StyleTypeID='10' AND MaterialWhereUsedStyleSchema IS NULL
UPDATE pStyleType SET MaterialWhereUsedStyleSchema='Material_WhereUsed_Style_Accessory.xml' WHERE StyleTypeID='18' AND MaterialWhereUsedStyleSchema IS NULL
UPDATE pStyleType SET MaterialWhereUsedStyleSchema='Material_WhereUsed_Silhouette_Apparel.xml' WHERE StyleTypeID='19' AND MaterialWhereUsedStyleSchema IS NULL
UPDATE pStyleType SET MaterialWhereUsedStyleSchema='Material_WhereUsed_Silhouette_Accessory.xml' WHERE StyleTypeID='20' AND MaterialWhereUsedStyleSchema IS NULL
UPDATE pStyleType SET MaterialWhereUsedStyleSchema='Material_WhereUsed_Style_Apparel.xml' WHERE StyleTypeID='21' AND MaterialWhereUsedStyleSchema IS NULL 


UPDATE pStyleType SET MaterialWhereUsedStyleSearchSchema='Material_StyleSearch_Apparel.xml' WHERE StyleTypeID='10' AND MaterialWhereUsedStyleSearchSchema IS NULL
UPDATE pStyleType SET MaterialWhereUsedStyleSearchSchema='Material_StyleSearch_Accessory.xml' WHERE StyleTypeID='18' AND MaterialWhereUsedStyleSearchSchema IS NULL
UPDATE pStyleType SET MaterialWhereUsedStyleSearchSchema='Material_SilhouetteSearch_Apparel.xml' WHERE StyleTypeID='19' AND MaterialWhereUsedStyleSearchSchema IS NULL
UPDATE pStyleType SET MaterialWhereUsedStyleSearchSchema='Material_SilhouetteSearch_Accessory.xml' WHERE StyleTypeID='20' AND MaterialWhereUsedStyleSearchSchema IS NULL
UPDATE pStyleType SET MaterialWhereUsedStyleSearchSchema='Material_StyleSearch_Apparel.xml' WHERE StyleTypeID='21' AND MaterialWhereUsedStyleSearchSchema IS NULL

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08375', GetDate())
GO
