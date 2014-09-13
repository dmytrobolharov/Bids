IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeaderNew_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleHeaderNew_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleHeaderNew_INSERT]
(
	@StyleID UNIQUEIDENTIFIER
	, @WorkflowTemplateID UNIQUEIDENTIFIER
	, @CreatedBy NVARCHAR(200)
	, @CreatedDate DATETIME
)
AS

BEGIN 

	DECLARE @NoOfStyleHeader INT 
	SELECT  @NoOfStyleHeader = COUNT(*)  FROM  pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID
	
	IF @NoOfStyleHeader = 0
	BEGIN
		INSERT INTO pStyleHeader
                 		 (StyleID, StyleMasterID, CUser, CDate, MUser, MDate, Change, MaterialID, MaterialImageID, DesignSketchID, TechSketchID, ConceptSketchID, ColorSketchID, 
                 		 DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
                 		 DesignSketchVersion, TechSketchVersion, ConceptSketchVersion, ColorSketchVersion, DetailSketchVersion1, DetailSketchVersion2, 
                  		 DetailSketchVersion3, DetailSketchVersion4, SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, WorkflowTemplateID, StyleWorkflowID)
		VALUES     (@StyleID , @StyleID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, '1', '{00000000-0000-0000-0000-000000000000}', 
                 		 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                 		 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                		 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                 		 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                 		 '{00000000-0000-0000-0000-000000000000}', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @WorkflowTemplateID, @WorkflowTemplateID)
		EXEC spx_StyleFeature_INSERT @StyleID
		SELECT 1
	END
	ELSE
	BEGIN
		SELECT 0
	END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07611', GetDate())
GO