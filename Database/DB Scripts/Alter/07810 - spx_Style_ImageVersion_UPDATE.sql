IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_ImageVersion_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_ImageVersion_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Style_ImageVersion_UPDATE]
	@StyleID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER,
	@ImageVersion NVARCHAR(10)
AS
BEGIN	
	IF (SELECT COUNT(*) FROM pStyleMaterials WHERE StyleID = @StyleID AND MaterialImageID = @ImageID AND MaterialImageVersion <> @ImageVersion) > 0
	   UPDATE pStyleMaterials SET MaterialImageVersion = @ImageVersion WHERE StyleID = @StyleID AND MaterialImageID = @ImageID
	
	IF (SELECT COUNT(*) FROM pStyleDetailForm WHERE StyleID = @StyleID AND ImageID = @ImageID AND ImageVersion <> @ImageVersion) > 0   
	   UPDATE pStyleDetailForm SET ImageVersion = @ImageVersion WHERE StyleID = @StyleID AND ImageID = @ImageID
	   
	IF (SELECT COUNT(*) FROM pStyleImageItem WHERE StyleID = @StyleID AND ImageID = @ImageID AND ImageVersion <> @ImageVersion) > 0
	   UPDATE pStyleImageItem SET ImageVersion = @ImageVersion WHERE StyleID = @StyleID AND ImageID = @ImageID
	   
	IF (SELECT COUNT(*) FROM pStyleImage WHERE StyleID = @StyleID AND SpecSketchID1 = @ImageID AND SpecSketchVersion1 <> @ImageVersion) > 0
	   UPDATE pStyleImage SET SpecSketchVersion1 = @ImageVersion WHERE StyleID = @StyleID AND SpecSketchID1 = @ImageID
	   
	IF (SELECT COUNT(*) FROM pStyleImage WHERE StyleID = @StyleID AND SpecSketchID2 = @ImageID AND SpecSketchVersion2 <> @ImageVersion) > 0
	   UPDATE pStyleImage SET SpecSketchVersion2 = @ImageVersion WHERE StyleID = @StyleID AND SpecSketchID2 = @ImageID
	   
	IF (SELECT COUNT(*) FROM pStyleImage WHERE StyleID = @StyleID AND SpecSketchID3 = @ImageID AND SpecSketchVersion3 <> @ImageVersion) > 0	   
	   UPDATE pStyleImage SET SpecSketchVersion3 = @ImageVersion WHERE StyleID = @StyleID AND SpecSketchID3 = @ImageID
	   
	IF (SELECT COUNT(*) FROM pStyleImage WHERE StyleID = @StyleID AND SpecSketchID4 = @ImageID AND SpecSketchVersion4 <> @ImageVersion) > 0
	   UPDATE pStyleImage SET SpecSketchVersion4 = @ImageVersion WHERE StyleID = @StyleID AND SpecSketchID4 = @ImageID
	   
	IF (SELECT COUNT(*) FROM pStyleImageMeasurements WHERE StyleID = @StyleID AND ImageSet1Id = @ImageID AND ImageVersionSet1 <> @ImageVersion) > 0
	   UPDATE pStyleImageMeasurements SET ImageVersionSet1 = @ImageVersion WHERE StyleID = @StyleID AND ImageSet1Id = @ImageID
	   
	IF (SELECT COUNT(*) FROM pStyleImageMeasurements WHERE StyleID = @StyleID AND ImageSet2Id = @ImageID AND ImageVersionSet2 <> @ImageVersion) > 0
	   UPDATE pStyleImageMeasurements SET ImageVersionSet2 = @ImageVersion WHERE StyleID = @StyleID AND ImageSet2Id = @ImageID
	   
	IF (SELECT COUNT(*) FROM pStyleImageMeasurements WHERE StyleID = @StyleID AND ImageSet3Id = @ImageID AND ImageVersionSet3 <> @ImageVersion) > 0
	   UPDATE pStyleImageMeasurements SET ImageVersionSet3 = @ImageVersion WHERE StyleID = @StyleID AND ImageSet3Id = @ImageID
	   
	IF (SELECT COUNT(*) FROM pStyleImageMeasurements WHERE StyleID = @StyleID AND ImageSet4Id = @ImageID AND ImageVersionSet4 <> @ImageVersion) > 0
	   UPDATE pStyleImageMeasurements SET ImageVersionSet4 = @ImageVersion WHERE StyleID = @StyleID AND ImageSet4Id = @ImageID
END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07810', GetDate())
GO
