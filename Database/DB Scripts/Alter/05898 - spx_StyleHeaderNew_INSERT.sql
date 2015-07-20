
/****** Object:  StoredProcedure [dbo].[spx_StyleHeaderNew_INSERT]    Script Date: 06/22/2013 04:44:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeaderNew_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleHeaderNew_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_StyleHeaderNew_INSERT]    Script Date: 06/22/2013 04:44:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



/****** Object:  StoredProcedure [dbo].[spx_StyleHeaderNew_INSERT]    Script Date: 05/09/2012 10:16:34 ******/
CREATE  PROCEDURE [dbo].[spx_StyleHeaderNew_INSERT]
(@StyleID uniqueidentifier,
@WorkflowTemplateID uniqueidentifier,
@CreatedBy nvarchar(200),
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
                      	 DetailSketchVersion3, DetailSketchVersion4, SpecSketchVersion1, SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, WorkflowTemplateID, StyleWorkflowID)
		 VALUES     (@StyleID , @StyleID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, '1', '{00000000-0000-0000-0000-000000000000}', 
                     	 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                     	 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                    	 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                     	 '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', '{00000000-0000-0000-0000-000000000000}', 
                     	 '{00000000-0000-0000-0000-000000000000}', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @WorkflowTemplateID, @WorkflowTemplateID)

		SELECT 1

		END

	ELSE

		BEGIN

		SELECT 0

		END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05898', GetDate())
GO
