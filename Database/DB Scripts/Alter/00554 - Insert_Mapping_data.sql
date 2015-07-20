begin

	if not exists (select * from Mapping WHERE Map = '80000000-0000-0000-0000-000000000008')
	
	begin
		
		INSERT INTO Mapping(Map, MapDetail, MapUrl, MapEditUrl, MapFolder)
		VALUES     ('80000000-0000-0000-0000-000000000008', 'Construction Details', 'Style_ConstructionDetail.aspx', 'Style_ConstructionDetail_Edit.aspx', 'StyleFolder')
	end

end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '554', GetDate())
GO