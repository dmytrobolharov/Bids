IF NOT EXISTS (SELECT * FROM Mapping WHERE Map = '40000000-0000-0000-0000-000000000085')
BEGIN
	INSERT INTO [Mapping]
			   ([Map]
			   ,[MapDetail]
			   ,[MapUrl]
			   ,[MapEditUrl]
			   ,[MapEmlUrl]
			   ,[MapFolder]
			   ,[Sort]
			   ,[MapConceptUrl]
			   ,[MapConceptEditUrl]
			   ,[MapPageUrl])
		 VALUES
			   ('40000000-0000-0000-0000-000000000085'
			   ,'Wardrobe'
			   ,'Style_Wardrobe.aspx'
			   ,'Style_Wardrobe.aspx'
			   ,NULL
			   ,'StyleFolder'
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05702', GetDate())
GO

