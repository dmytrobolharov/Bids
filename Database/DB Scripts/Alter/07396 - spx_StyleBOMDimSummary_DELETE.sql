/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDimSummary_DELETE]    Script Date: 04/01/2014 16:00:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimSummary_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimSummary_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDimSummary_DELETE]    Script Date: 04/01/2014 16:00:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimSummary_DELETE] (
	@StyleMaterialID UNIQUEIDENTIFIER 
	,@StyleID UNIQUEIDENTIFIER = null
	,@StyleSet int =null
	,@StyleBOMDimensionId uniqueidentifier = null
	,@MDate datetime
	,@MUser nvarchar(200)	
)
AS 

DECLARE @StyleMaterialMasterID uniqueidentifier
DECLARE @StyleColorItemMasterId uniqueidentifier


SELECT @StyleMaterialMasterID = StyleMaterialMasterID FROM pStyleBOM WITH (NOLOCK) WHERE (StyleMaterialID = @StyleMaterialID)
--and StyleBOMDimensionId=@StyleBOMDimensionId


DECLARE
@MainMaterial int,
@MaterialId uniqueidentifier,
@MaterialImageId uniqueidentifier,
@MaterialImageVersion int,
@MaterialNo nvarchar(50),
@MaterialName nvarchar(200),
@MaterialNull nvarchar(50)


SELECT @MainMaterial = MainMaterial, 
	@StyleId = StyleId,
	@MaterialId = MaterialId,
	@MaterialImageId = MaterialImageId,
	@MaterialImageVersion = MaterialImageVersion,
	@MaterialNo = MaterialNo,
	@MaterialName = MaterialName 
FROM pStyleBOM WITH (NOLOCK) WHERE (StyleMaterialId = @StyleMaterialid)

BEGIN TRY
	BEGIN TRANSACTION
		IF @MainMaterial = 1
		BEGIN
			--select @MainMaterial as MainMaterial
			SET @MaterialNull = '{00000000-0000-0000-0000-000000000000}'

			DECLARE @StyleMasterId uniqueidentifier
			SELECT @StyleMasterId = StyleMasterId FROM pStyleHeader WITH (NOLOCK) WHERE StyleId = @StyleId
			
			UPDATE dbo.pStyleHeader
				SET  MaterialID = @MaterialNull, MaterialImageID = @MaterialNull, MaterialImageVersion = 0, MaterialNo = NULL, 
				MaterialName = NULL, StyleMaterialID = @MaterialNull
			WHERE  (StyleID = @StyleId)
			
			UPDATE dbo.pStyleHeader
				SET  MaterialID = @MaterialNull, MaterialImageID = @MaterialNull, MaterialImageVersion = 0, MaterialNo = NULL, 
				MaterialName = NULL, StyleMaterialID = @MaterialNull
			WHERE  (StyleMasterID = @StyleMasterId) 
			
		END

		DELETE FROM pStyleBOM WHERE StyleMaterialID = @StyleMaterialID		
		DELETE FROM pStyleBOMItem WHERE StyleMaterialID = @StyleMaterialID		
	COMMIT TRANSACTION;
	
	--If Successful
	SELECT 1

END TRY
BEGIN CATCH  
    ROLLBACK TRANSACTION;
    
    --If Error
    SELECT 0;
    
END CATCH;


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07396', GetDate())
GO

