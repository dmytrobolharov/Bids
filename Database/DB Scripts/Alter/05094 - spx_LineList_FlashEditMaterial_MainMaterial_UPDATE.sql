/****** Object:  StoredProcedure [dbo].[spx_LineList_FlashEditMaterial_MainMaterial_UPDATE]    Script Date: 02/22/2013 11:30:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineList_FlashEditMaterial_MainMaterial_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineList_FlashEditMaterial_MainMaterial_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineList_FlashEditMaterial_MainMaterial_UPDATE]    Script Date: 02/22/2013 11:30:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineList_FlashEditMaterial_MainMaterial_UPDATE]
	@MainMaterial INT,
	@StyleMaterialID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE pStyleBOM SET MainMaterial = @MainMaterial WHERE StyleMaterialID = @StyleMaterialID
    
    -- Pushing MainMaterial to Flash Costing page
    IF @MainMaterial = 1
    BEGIN
		DECLARE @StyleID UNIQUEIDENTIFIER
		DECLARE @MaterialID UNIQUEIDENTIFIER
		SELECT @StyleID = StyleID, @MaterialID = MaterialID FROM pStyleBOM
		WHERE StyleMaterialID = @StyleMaterialID
		
		UPDATE pLineListFlashCosting SET MaterialID = @MaterialID
		FROM pLineListFlashCosting lfc
		INNER JOIN pLineFolderItem lfi ON lfi.LineFolderItemID = lfc.LineFolderItemID
		WHERE lfi.StyleID=@StyleID
    END
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05094', GetDate())
GO
