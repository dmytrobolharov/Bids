IF EXISTS (SELECT * FROM Mapping Where UPPER(MapDetail)='DIMENSIONAL BOM' AND UPPER(MapPageUrl)='STYLE_DIMENSIONALBOM_READ.ASPX' )
BEGIN

	UPDATE 
		Mapping 
	SET
		MapPageUrl='Style_DimensionalBOM.aspx'
	WHERE 
		UPPER(MapDetail)='DIMENSIONAL BOM' 
		AND UPPER(MapPageUrl)='STYLE_DIMENSIONALBOM_READ.ASPX'
END
GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03595', GetDate())
GO