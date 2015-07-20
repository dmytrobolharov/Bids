IF NOT EXISTS (SELECT * FROM Mapping WHERE UPPER(Map) = 'ATTRIBUTE')
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
			   ('40000000-0000-0000-0000-000000000021'
			   ,'Attribute'
			   ,'Style_ColorwaySeasonal.aspx'
			   ,'Style_ColorwaySeasonal_Edit.aspx'
			   ,NULL
			   ,'StyleFolder'
			   ,NULL
			   ,NULL
			   ,NULL
			   ,NULL)
END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05037', GetDate())
GO