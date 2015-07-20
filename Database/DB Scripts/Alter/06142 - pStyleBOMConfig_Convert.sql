IF NOT EXISTS (SELECT * FROM pStyleBOMConfig)
BEGIN

	INSERT INTO pStyleBOMConfig (StyleBOMDimensionID, DimBOM, DefaultBOMPage, FillColorway, ActiveColor)
	SELECT StyleBOMDimensionID, 1, 1, 1, 1 FROM pStyleBOMDimension

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06142', GetDate())
GO
