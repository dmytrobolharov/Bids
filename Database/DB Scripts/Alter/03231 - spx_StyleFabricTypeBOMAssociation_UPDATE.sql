/****** Object:  StoredProcedure [dbo].[spx_StyleFabricTypeBOMAssociation_UPDATE]    Script Date: 03/14/2012 15:11:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFabricTypeBOMAssociation_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFabricTypeBOMAssociation_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleFabricTypeBOMAssociation_UPDATE]    Script Date: 03/14/2012 15:11:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- inserts or updates fabric type to BOM association for style
CREATE PROCEDURE [dbo].[spx_StyleFabricTypeBOMAssociation_UPDATE]
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@ModelID UNIQUEIDENTIFIER,
	@FabricType NVARCHAR(50),
	@StyleMaterialID UNIQUEIDENTIFIER,
	@CADModel2BOMID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF @CADModel2BOMID <> '00000000-0000-0000-0000-000000000000'
    BEGIN
		IF EXISTS(SELECT * FROM pCADModel2BOM WHERE CADModel2BOMId = @CADModel2BOMID)
		BEGIN
			UPDATE pCADModel2BOM 
			SET ModelId = @ModelID,
				FabricType = @FabricType,
				MaterialId = @StyleMaterialID,
				MUser = @CUser,
				MDate = @CDate
			WHERE CADModel2BOMId = @CADModel2BOMId
		END
		ELSE
		BEGIN
			INSERT INTO pCADModel2BOM(CADModel2BOMId, ModelId, FabricType, MaterialId, StyleId, StyleSet, CUser, CDate)
            VALUES(@CADModel2BOMID, @ModelID, @FabricType, @StyleMaterialID, @StyleID, @StyleSet, @CUser, @CDate)
		END
    END
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03231'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03231', GetDate())

END

GO 