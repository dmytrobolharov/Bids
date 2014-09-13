update Mapping set MapEditUrl = 'Style_DimensionalBOM_Folder.aspx', MapPageUrl = 'Style_DimensionalBOM_Read.aspx'
where Map = '40000000-0000-0000-0000-000000000080'
GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03401', GetDate())



GO