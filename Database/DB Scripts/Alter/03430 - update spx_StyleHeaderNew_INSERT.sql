IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeaderNew_INSERT]'))
drop procedure spx_StyleHeaderNew_INSERT
go


/****** Object:  StoredProcedure [dbo].[spx_StyleHeaderNew_INSERT]    Script Date: 05/09/2012 10:16:34 ******/
create  PROCEDURE [dbo].[spx_StyleHeaderNew_INSERT]
(@StyleID uniqueidentifier,
@WorkflowTemplateID uniqueidentifier,
@CreatedBy nvarchar(50),
@CreatedDate datetime)
AS 

DECLARE @NoOfStyleHeader int 
SELECT  @NoOfStyleHeader = COUNT(*)  FROM  pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID


	IF @NoOfStyleHeader = 0


		BEGIN

		INSERT INTO pStyleHeader
                     	 (StyleID, StyleMasterID, CUser, CDate, MUser, MDate, Change, MaterialID, MaterialImageID, DesignSketchID, TechSketchID, ConceptSketchID, ColorSketchID, 
                     	 DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, 
                     	 DesignSketchVersion, TechSketchVersion, ConceptSketchVersion, ColorSketchVersion, DetailSketchVersion1, DetailSketchVersion2, 
                      	 DetailSketchVersion3, DetailSketchVersion4, SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, WorkflowTemplateID)
		 VALUES     (@StyleID , @StyleID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, '1', '{00000000-0000-0000-0000-000000000000}', 
                     	 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                     	 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                    	 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                     	 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                     	 '{00000000-0000-0000-0000-000000000000}', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @WorkflowTemplateID)

		SELECT 1

		END

	ELSE

		BEGIN

		SELECT 0

		END

go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03430', GetDate())
	

GO


