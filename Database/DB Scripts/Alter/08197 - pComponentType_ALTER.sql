IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pComponentType]') AND name = 'ComponentPlanningColorWhereUsedSearchSchema')
BEGIN 
	ALTER TABLE dbo.pComponentType ADD ComponentPlanningColorWhereUsedSearchSchema nvarchar(200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pComponentType]') AND name = 'ComponentPlanningColorWhereUsedSchema')
BEGIN 
	ALTER TABLE dbo.pComponentType ADD ComponentPlanningColorWhereUsedSchema nvarchar(200) NULL
END
GO
	
IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 10)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Wovens.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Wovens.xml'
		WHERE ComponentTypeID = 10
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 11)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Knits.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Knits.xml'
		WHERE ComponentTypeID = 11
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 12)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Yarns.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Yarns.xml'
		WHERE ComponentTypeID = 12
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 13)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Other.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Other.xml'
		WHERE ComponentTypeID = 13
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 16)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Interlining.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Interlining.xml'
		WHERE ComponentTypeID = 16
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 18)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Thread.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Thread.xml'
		WHERE ComponentTypeID = 18
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 21)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Artwork.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Artwork.xml'
		WHERE ComponentTypeID = 21
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 23)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Embroidery.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Embroidery.xml'
		WHERE ComponentTypeID = 23
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 27)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Trimmings.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Trimmings.xml'
		WHERE ComponentTypeID = 27
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 29)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Labels.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Labels.xml'
		WHERE ComponentTypeID = 29
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 31)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Packaging.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Packaging.xml'
		WHERE ComponentTypeID = 31
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 32)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Zippers.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Zippers.xml'
		WHERE ComponentTypeID = 32
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 33)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Lining.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Lining.xml'
		WHERE ComponentTypeID = 33
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 34)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Wovens_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Wovens_Sourced.xml'
		WHERE ComponentTypeID = 34
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 36)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Knits_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Knits_Sourced.xml'
		WHERE ComponentTypeID = 36
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 38)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Yarns_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Yarns_Sourced.xml'
		WHERE ComponentTypeID = 38
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 40)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Other_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Other_Sourced.xml'
		WHERE ComponentTypeID = 40
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 42)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Interlining_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Interlining_Sourced.xml'
		WHERE ComponentTypeID = 42
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 44)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Thread_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Thread_Sourced.xml'
		WHERE ComponentTypeID = 44
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 46)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Artwork_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Artwork_Sourced.xml'
		WHERE ComponentTypeID = 46
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 48)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Embroidery_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Embroidery_Sourced.xml'
		WHERE ComponentTypeID = 48
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 50)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Trimmings_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Trimmings_Sourced.xml'
		WHERE ComponentTypeID = 50
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 52)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Labels_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Labels_Sourced.xml'
		WHERE ComponentTypeID = 52
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 54)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Packaging_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Packaging_Sourced.xml'
		WHERE ComponentTypeID = 54
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 56)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Zippers_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Zippers_Sourced.xml'
		WHERE ComponentTypeID = 56
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 58)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningColorWhereUsedSchema = 'PlanningColor_WhereUsed_Material_Lining_Sourced.xml', ComponentPlanningColorWhereUsedSearchSchema = 'PlanningColor_WhereUsed_Material_Search_Lining_Sourced.xml'
		WHERE ComponentTypeID = 58
	END
	GO
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08197', GetDate())
GO
