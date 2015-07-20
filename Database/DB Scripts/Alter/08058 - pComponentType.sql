IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pComponentType]') AND name = 'ComponentPlanningSearchSchema')
BEGIN 
	ALTER TABLE dbo.pComponentType ADD ComponentPlanningSearchSchema nvarchar(200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pComponentType]') AND name = 'ComponentPlanningSchema')
BEGIN 
	ALTER TABLE dbo.pComponentType ADD ComponentPlanningSchema nvarchar(200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pComponentType]') AND name = 'ComponentPlanningWhereUsedSearchSchema')
BEGIN 
	ALTER TABLE dbo.pComponentType ADD ComponentPlanningWhereUsedSearchSchema nvarchar(200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pComponentType]') AND name = 'ComponentPlanningWhereUsedSchema')
BEGIN 
	ALTER TABLE dbo.pComponentType ADD ComponentPlanningWhereUsedSchema nvarchar(200) NULL
END
GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 10)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Wovens.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Wovens.xml'
		WHERE ComponentTypeID = 10
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 11)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Knits.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Knits.xml'
		WHERE ComponentTypeID = 11
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 12)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Yarns.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Yarns.xml'
		WHERE ComponentTypeID = 12
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 13)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Other.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Other.xml'
		WHERE ComponentTypeID = 13
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 16)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Interlining.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Interlining.xml'
		WHERE ComponentTypeID = 16
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 18)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Thread.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Thread.xml'
		WHERE ComponentTypeID = 18
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 21)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Artwork.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Artwork.xml'
		WHERE ComponentTypeID = 21
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 23)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Embroidery.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Embroidery.xml'
		WHERE ComponentTypeID = 23
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 27)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Trimmings.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Trimmings.xml'
		WHERE ComponentTypeID = 27
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 29)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Labels.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Labels.xml'
		WHERE ComponentTypeID = 29
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 31)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Packaging.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Packaging.xml'
		WHERE ComponentTypeID = 31
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 32)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Zippers.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Zippers.xml'
		WHERE ComponentTypeID = 32
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 33)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Lining.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Lining.xml'
		WHERE ComponentTypeID = 33
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 34)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Wovens_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Wovens_Sourced.xml'
		WHERE ComponentTypeID = 34
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 36)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Knits_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Knits_Sourced.xml'
		WHERE ComponentTypeID = 36
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 38)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Yarns_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Yarns_Sourced.xml'
		WHERE ComponentTypeID = 38
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 40)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Other_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Other_Sourced.xml'
		WHERE ComponentTypeID = 40
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 42)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Interlining_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Interlining_Sourced.xml'
		WHERE ComponentTypeID = 42
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 44)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Thread_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Thread_Sourced.xml'
		WHERE ComponentTypeID = 44
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 46)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Artwork_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Artwork_Sourced.xml'
		WHERE ComponentTypeID = 46
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 48)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Embroidery_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Embroidery_Sourced.xml'
		WHERE ComponentTypeID = 48
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 50)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Trimmings_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Trimmings_Sourced.xml'
		WHERE ComponentTypeID = 50
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 52)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Labels_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Labels_Sourced.xml'
		WHERE ComponentTypeID = 52
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 54)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Packaging_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Packaging_Sourced.xml'
		WHERE ComponentTypeID = 54
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 56)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Zippers_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Zippers_Sourced.xml'
		WHERE ComponentTypeID = 56
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 58)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningSchema = 'PlanningMaterial_Lining_Sourced.xml', ComponentPlanningSearchSchema = 'PlanningMaterial_Search_Lining_Sourced.xml'
		WHERE ComponentTypeID = 58
	END
	GO
	
IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 10)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Wovens.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Wovens.xml'
		WHERE ComponentTypeID = 10
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 11)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Knits.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Knits.xml'
		WHERE ComponentTypeID = 11
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 12)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Yarns.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Yarns.xml'
		WHERE ComponentTypeID = 12
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 13)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Other.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Other.xml'
		WHERE ComponentTypeID = 13
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 16)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Interlining.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Interlining.xml'
		WHERE ComponentTypeID = 16
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 18)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Thread.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Thread.xml'
		WHERE ComponentTypeID = 18
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 21)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Artwork.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Artwork.xml'
		WHERE ComponentTypeID = 21
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 23)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Embroidery.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Embroidery.xml'
		WHERE ComponentTypeID = 23
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 27)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Trimmings.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Trimmings.xml'
		WHERE ComponentTypeID = 27
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 29)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Labels.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Labels.xml'
		WHERE ComponentTypeID = 29
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 31)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Packaging.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Packaging.xml'
		WHERE ComponentTypeID = 31
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 32)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Zippers.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Zippers.xml'
		WHERE ComponentTypeID = 32
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 33)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Lining.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Lining.xml'
		WHERE ComponentTypeID = 33
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 34)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Wovens_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Wovens_Sourced.xml'
		WHERE ComponentTypeID = 34
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 36)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Knits_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Knits_Sourced.xml'
		WHERE ComponentTypeID = 36
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 38)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Yarns_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Yarns_Sourced.xml'
		WHERE ComponentTypeID = 38
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 40)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Other_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Other_Sourced.xml'
		WHERE ComponentTypeID = 40
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 42)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Interlining_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Interlining_Sourced.xml'
		WHERE ComponentTypeID = 42
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 44)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Thread_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Thread_Sourced.xml'
		WHERE ComponentTypeID = 44
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 46)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Artwork_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Artwork_Sourced.xml'
		WHERE ComponentTypeID = 46
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 48)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Embroidery_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Embroidery_Sourced.xml'
		WHERE ComponentTypeID = 48
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 50)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Trimmings_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Trimmings_Sourced.xml'
		WHERE ComponentTypeID = 50
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 52)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Labels_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Labels_Sourced.xml'
		WHERE ComponentTypeID = 52
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 54)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Packaging_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Packaging_Sourced.xml'
		WHERE ComponentTypeID = 54
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 56)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Zippers_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Zippers_Sourced.xml'
		WHERE ComponentTypeID = 56
	END
	GO

IF EXISTS(SELECT * FROM pComponentType WHERE ComponentTypeID = 58)
	BEGIN
		UPDATE pComponentType Set ComponentPlanningWhereUsedSchema = 'PlanningMaterial_WhereUsed_Lining_Sourced.xml', ComponentPlanningWhereUsedSearchSchema = 'PlanningMaterial_WhereUsed_Search_Lining_Sourced.xml'
		WHERE ComponentTypeID = 58
	END
	GO
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08058', GetDate())
GO
