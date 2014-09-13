IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pStyleType]') AND name = 'PlanningItemSearchSchema')
BEGIN 
	ALTER TABLE dbo.pStyleType ADD PlanningItemSearchSchema nvarchar(200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pStyleType]') AND name = 'PlanningItemSchema')
BEGIN 
	ALTER TABLE dbo.pStyleType ADD PlanningItemSchema nvarchar(200) NULL
END
GO

UPDATE dbo.pStyleType Set PlanningItemSchema = 'Planning_Item_Apparel.xml', 
PlanningItemSearchSchema = 'Planning_Item_Search_Apparel.xml'
WHERE StyleTypeID = 10

UPDATE dbo.pStyleType Set PlanningItemSchema = 'Planning_Item_Accessory.xml', 
PlanningItemSearchSchema = 'Planning_Item_Search_Accessory.xml'
WHERE StyleTypeID = 18



UPDATE pStyleType Set PlanningItemSchema = 'Planning_Item_Silhouette_Apparel.xml', 
PlanningItemSearchSchema = 'Planning_Item_Search_Silhouette_Apparel.xml'
WHERE StyleTypeID = 19



UPDATE pStyleType Set PlanningItemSchema = 'Planning_Item_Silhouette_Accessory.xml', 
PlanningItemSearchSchema = 'Planning_Item_Search_Silhouette_Accessory.xml'
WHERE StyleTypeID = 20


UPDATE pStyleType Set PlanningItemSchema = 'Planning_Item_Suit.xml', 
PlanningItemSearchSchema = 'Planning_Item_Search_Suit.xml'
WHERE StyleTypeID = 21

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08215', GetDate())
GO
