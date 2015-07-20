IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pComponentType' and COLUMN_NAME = N'ComponentPlanningMaterialAddSearchSchema')
BEGIN 			
	ALTER TABLE pComponentType ADD ComponentPlanningMaterialAddSearchSchema nvarchar(200) NULL
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pComponentType' and COLUMN_NAME = N'ComponentPlanningMaterialAddSearchSchema')
BEGIN	   
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Wovens.xml' where ComponentSearchSchema = 'Material_Search_Wovens.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Knits.xml' where ComponentSearchSchema = 'Material_Search_Knits.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Yarns.xml' where ComponentSearchSchema = 'Material_Search_Yarns.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Other.xml' where ComponentSearchSchema = 'Material_Search_Other.xml'		   
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Interlining.xml' where ComponentSearchSchema = 'Material_Search_Interlining.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Thread.xml' where ComponentSearchSchema = 'Material_Search_Thread.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Artwork.xml' where ComponentSearchSchema = 'Material_Search_Artwork.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Embroidery.xml' where ComponentSearchSchema = 'Material_Search_Embroidery.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Trimming.xml' where ComponentSearchSchema = 'Material_Search_Trimming.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Labels.xml' where ComponentSearchSchema = 'Material_Search_Labels.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Packaging.xml' where ComponentSearchSchema = 'Material_Search_Packaging.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Zippers.xml' where ComponentSearchSchema = 'Material_Search_Zippers.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Lining.xml' where ComponentSearchSchema = 'Material_Search_Lining.xml'
   
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Wovens.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Wovens.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Knits.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Knits.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Yarns.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Yarns.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Other.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Other.xml'		   
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Interlining.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Interlining.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Thread.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Thread.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Artwork.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Artwork.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Embroidery.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Embroidery.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Trimming.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Trimming.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Labels.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Labels.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Packaging.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Packaging.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Zippers.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Zippers.xml'
   Update pComponentType set ComponentPlanningMaterialAddSearchSchema = 'PlanningMaterial_Add_Search_Sourced_Lining.xml' where ComponentSearchSchema = 'Material_Search_Sourced_Lining.xml'
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08610', GetDate())
GO