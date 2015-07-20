IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pStyleType]') AND name = 'PlanningMaterialWhereUsedStyleSearchSchema')
BEGIN 
	ALTER TABLE dbo.pStyleType ADD PlanningMaterialWhereUsedStyleSearchSchema nvarchar(200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pStyleType]') AND name = 'PlanningMaterialWhereUsedStyleSchema')
BEGIN 
	ALTER TABLE dbo.pStyleType ADD PlanningMaterialWhereUsedStyleSchema nvarchar(200) NULL
END
GO

IF EXISTS(SELECT * FROM dbo.pStyleType WHERE StyleTypeID = 10)
	BEGIN
		UPDATE dbo.pStyleType Set PlanningMaterialWhereUsedStyleSchema = 'PlanningMaterial_WhereUsed_Style_Apparel.xml', 
		PlanningMaterialWhereUsedStyleSearchSchema = 'PlanningMaterial_WhereUsed_Style_Search_Apparel.xml'
		WHERE StyleTypeID = 10
	END
	GO

IF EXISTS(SELECT * FROM dbo.pStyleType WHERE StyleTypeID = 18)
	BEGIN
		UPDATE dbo.pStyleType Set PlanningMaterialWhereUsedStyleSchema = 'PlanningMaterial_WhereUsed_Style_Accessory.xml', 
		PlanningMaterialWhereUsedStyleSearchSchema = 'PlanningMaterial_WhereUsed_Style_Search_Accessory.xml'
		WHERE StyleTypeID = 18
	END
	GO

IF EXISTS(SELECT * FROM pStyleType WHERE StyleTypeID = 19)
	BEGIN
		UPDATE pStyleType Set PlanningMaterialWhereUsedStyleSchema = 'PlanningMaterial_WhereUsed_Silhouette_Apparel.xml', 
		PlanningMaterialWhereUsedStyleSearchSchema = 'PlanningMaterial_WhereUsed_Style_Search_Silhouette_Apparel.xml'
		WHERE StyleTypeID = 19
	END
	GO

IF EXISTS(SELECT * FROM pStyleType WHERE StyleTypeID = 20)
	BEGIN
		UPDATE pStyleType Set PlanningMaterialWhereUsedStyleSchema = 'PlanningMaterial_WhereUsed_Silhouette_Accessory.xml', 
		PlanningMaterialWhereUsedStyleSearchSchema = 'PlanningMaterial_WhereUsed_Style_Search_Silhouette_Accessory.xml'
		WHERE StyleTypeID = 20
	END
	GO

IF EXISTS(SELECT * FROM pStyleType WHERE StyleTypeID = 21)
	BEGIN
		UPDATE pStyleType Set PlanningMaterialWhereUsedStyleSchema = 'PlanningMaterial_WhereUsed_Style_Suit.xml', 
		PlanningMaterialWhereUsedStyleSearchSchema = 'PlanningMaterial_WhereUsed_Style_Search_Suit.xml'
		WHERE StyleTypeID = 21
	END
	GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08059', GetDate())
GO