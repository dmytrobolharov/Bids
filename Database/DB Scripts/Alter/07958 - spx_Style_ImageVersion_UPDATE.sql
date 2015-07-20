IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_ImageVersion_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_ImageVersion_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Style_ImageVersion_UPDATE]
	@StyleID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER,
	@ImageVersion NVARCHAR(10)
AS
BEGIN	
	UPDATE pStyleHeader SET DesignSketchVersion = @ImageVersion WHERE StyleID = @StyleID AND DesignSketchID = @ImageID AND DesignSketchVersion != @ImageVersion
	UPDATE pStyleHeader SET DesignSketchBackVersion = @ImageVersion WHERE StyleID = @StyleID AND DesignSketchBackID = @ImageID AND DesignSketchBackVersion != @ImageVersion
	UPDATE pStyleMaterials SET MaterialImageVersion = @ImageVersion WHERE StyleID = @StyleID AND MaterialImageID = @ImageID AND MaterialImageVersion != @ImageVersion
	UPDATE pStyleDetailForm SET ImageVersion = @ImageVersion WHERE StyleID = @StyleID AND ImageID = @ImageID AND ImageVersion != @ImageVersion
	UPDATE pStyleImageItem SET ImageVersion = @ImageVersion WHERE StyleID = @StyleID AND ImageID = @ImageID AND ImageVersion != @ImageVersion

	UPDATE pStyleImage SET SpecSketchVersion1 = @ImageVersion WHERE StyleID = @StyleID AND SpecSketchID1 = @ImageID AND SpecSketchVersion1 != @ImageVersion
	UPDATE pStyleImage SET SpecSketchVersion2 = @ImageVersion WHERE StyleID = @StyleID AND SpecSketchID2 = @ImageID AND SpecSketchVersion2 != @ImageVersion
	UPDATE pStyleImage SET SpecSketchVersion3 = @ImageVersion WHERE StyleID = @StyleID AND SpecSketchID3 = @ImageID AND SpecSketchVersion3 != @ImageVersion
	UPDATE pStyleImage SET SpecSketchVersion4 = @ImageVersion WHERE StyleID = @StyleID AND SpecSketchID4 = @ImageID AND SpecSketchVersion4 != @ImageVersion

	UPDATE pStyleImageMeasurements SET ImageVersionSet1 = @ImageVersion WHERE StyleID = @StyleID AND ImageSet1Id = @ImageID AND ImageVersionSet1 != @ImageVersion
	UPDATE pStyleImageMeasurements SET ImageVersionSet2 = @ImageVersion WHERE StyleID = @StyleID AND ImageSet2Id = @ImageID AND ImageVersionSet2 != @ImageVersion
	UPDATE pStyleImageMeasurements SET ImageVersionSet3 = @ImageVersion WHERE StyleID = @StyleID AND ImageSet3Id = @ImageID AND ImageVersionSet3 != @ImageVersion
	UPDATE pStyleImageMeasurements SET ImageVersionSet4 = @ImageVersion WHERE StyleID = @StyleID AND ImageSet4Id = @ImageID AND ImageVersionSet4 != @ImageVersion
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07958', GetDate())
GO
