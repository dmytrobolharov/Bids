IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingType' and COLUMN_NAME = N'StyleCostingCompareSchema')
BEGIN 	
	ALTER TABLE pStyleCostingType add StyleCostingCompareSchema nvarchar(200) NULL
END
GO
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingType' and COLUMN_NAME = N'StyleCostingSearchSchema')
BEGIN 	
	ALTER TABLE pStyleCostingType add StyleCostingSearchSchema nvarchar(200) NULL
END
GO
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingType' and COLUMN_NAME = N'StyleCostingGridSchema')
BEGIN 	
	ALTER TABLE pStyleCostingType add StyleCostingGridSchema nvarchar(200) NULL
END
GO
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingType' and COLUMN_NAME = N'StyleCostingEditSchema')
BEGIN 	
	ALTER TABLE pStyleCostingType add StyleCostingEditSchema nvarchar(200) NULL
END
GO
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingType' and COLUMN_NAME = N'StyleCostingHeaderSchema')
BEGIN 	
	ALTER TABLE pStyleCostingType add StyleCostingHeaderSchema nvarchar(200) NULL
END
GO
Update pStyleCostingType set StyleCostingCompareSchema ='Style_Costing_Compare_Import.xml' where StyleCostingTypeID = 1
GO
Update pStyleCostingType set StyleCostingCompareSchema ='Style_Costing_Compare_Domestic.xml' where StyleCostingTypeID = 3
GO
Update pStyleCostingType set StyleCostingCompareSchema ='Style_Costing_Compare_Indirect.xml' where StyleCostingTypeID = 4
GO
Update pStyleCostingType set StyleCostingSearchSchema ='Style_Costing_Search.xml' 
GO
Update pStyleCostingType set StyleCostingSearchSchema ='Style_Costing_Search.xml' 
GO
Update pStyleCostingType set StyleCostingSearchSchema ='Style_Costing_Search.xml' 
GO
Update pStyleCostingType set StyleCostingGridSchema ='Style_Costing_Grid.xml' 
GO
Update pStyleCostingType set StyleCostingGridSchema ='Style_Costing_Grid.xml' 
GO
Update pStyleCostingType set StyleCostingGridSchema ='Style_Costing_Grid.xml' 
GO
Update pStyleCostingType set StyleCostingEditSchema ='Style_Costing_Edit_Import.xml' where StyleCostingTypeID = 1
GO
Update pStyleCostingType set StyleCostingEditSchema ='Style_Costing_Edit_Domestic.xml' where StyleCostingTypeID = 3
GO
Update pStyleCostingType set StyleCostingEditSchema ='Style_Costing_Edit_InDirect.xml' where StyleCostingTypeID = 4
GO
Update pStyleCostingType set StyleCostingHeaderSchema ='Style_Costing_Header.xml' 
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03884', GetDate())
GO