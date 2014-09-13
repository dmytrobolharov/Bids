IF EXISTS (SELECT * FROM pStyleBOMDimension WHERE StyleBOMDimensionID NOT IN (SELECT StyleBOMDimensionID FROM pStyleBOMConfig))
BEGIN

	INSERT INTO pStyleBOMConfig (StyleBOMDimensionID, DimBOM, DefaultBOMPage, FillColorway, ActiveColor)
	SELECT StyleBOMDimensionID, 1, 1, 1, 1 FROM pStyleBOMDimension WHERE StyleBOMDimensionID NOT IN (SELECT StyleBOMDimensionID FROM pStyleBOMConfig)

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06209', GetDate())
GO
