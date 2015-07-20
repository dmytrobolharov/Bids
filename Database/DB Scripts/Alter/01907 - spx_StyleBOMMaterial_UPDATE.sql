IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMaterial_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMMaterial_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMaterial_UPDATE]    Script Date: 09/07/2011 18:00:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_StyleBOMMaterial_UPDATE]
(
@StyleMaterialId uniqueidentifier,
@StyleId uniqueidentifier,
@StyleSet int,
@MainMaterial nvarchar(5),
@Artwork int,
@License int,
@Colorway int,
@Qty decimal(19,3),
@UOM nvarchar(50),
@MaterialSize nvarchar(200),
@MaterialPrice money , 
@Placement nvarchar(4000) 
)
AS

DECLARE @StyleMaterialMasterId uniqueidentifier
DECLARE @MaterialId uniqueidentifier
DECLARE @MaterialImageId uniqueidentifier
DECLARE @MaterialImageVersion int
DECLARE @MaterialNo nvarchar(50)
DECLARE @MaterialName nvarchar(200)
DECLARE @MaterialNull nvarchar(50)
DECLARE @Ext money
DECLARE @UOMValue decimal(19,3)
DECLARE @QtyValue decimal(19,3)

DECLARE  @MaterialSizeID UNIQUEIDENTIFIER 


/*******************************************************************************************************************************************************************************************************************
 GET MATERIALSIZEID
********************************************************************************************************************************************************************************************************************/ 
SELECT @MaterialID  = MaterialID FROM pStyleBOM WITH (NOLOCK) WHERE StyleMaterialID = @StyleMaterialID 
SELECT @MaterialSizeID = MaterialSizeID FROM pMaterialSize WITH (NOLOCK) WHERE MaterialSize = @MaterialSize AND  MaterialID = @MaterialID 


IF @MaterialSizeID IS NULL AND  LOWER(@MaterialSize) = '*na'
	SET @MaterialSizeID = '00000000-0000-0000-0000-000000000000'


--SELECT @UOMValue = UOMValue FROM UOM WITH (NOLOCK) WHERE UOM = @UOM

SET @QtyValue = ISNULL(@Qty,0)
SET @Ext = @MaterialPrice * ISNULL(@QtyValue,0)





UPDATE  dbo.pStyleBOM
	SET  MainMaterial = @MainMaterial, Artwork = @Artwork, License = @License, 
	Colorway = @Colorway, Qty = @Qty, UOM = @UOM, 
	MaterialSize = @MaterialSize, MaterialPrice = @MaterialPrice, Ext = @Ext,  Placement = @Placement  ,
	MaterialSizeID = @MaterialSizeID
WHERE StyleMaterialId = @StyleMaterialId AND StyleId = @StyleId


--exec spx_StyleMaterialVariation_UPDATE  @StyleMaterialId 	
--exec spx_StyleMaterialGlobal_UPDATE @StyleMaterialId, @StyleId, @StyleSet
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01907'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01907', GetDate())
END

GO
