IF NOT EXISTS (SELECT * FROM Mapping WHERE UPPER(Map) = 'BILL OF LABOR V.2')
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
			   ('40000000-0000-0000-0000-000000000078'
			   ,'Bill Of Labor v.2'
			   ,'Style_WorkFlowItems.aspx'
			   ,'Style_NBOL_Edit.aspx'
			   ,'Style_NBOL_Eml.aspx'
			   ,'StyleFolder'
			   ,NULL
			   ,NULL
			   ,NULL
			   ,'Style_NBOL.aspx')
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03552', GetDate())
GO