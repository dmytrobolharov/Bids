IF EXISTS (SELECT * FROM Mapping Where UPPER(MapDetail)='DIMENSIONAL BOM' AND UPPER(MapPageUrl)='STYLE_DIMENSIONALBOM.ASPX' )
BEGIN

	UPDATE 
		Mapping 
	SET
		MapPageUrl='Style_DimensionalBOM_Read.aspx'
	WHERE 
		UPPER(MapDetail)='DIMENSIONAL BOM' 
		AND UPPER(MapPageUrl)='Style_DimensionalBOM.aspx'
END
GO

	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03619', GetDate())
GO

