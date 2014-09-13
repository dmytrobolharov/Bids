/****** Object:  StoredProcedure [dbo].[spx_SampleMaterialColor_INSERT]    Script Date: 01/24/2012 18:36:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleMaterialColor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleMaterialColor_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleMaterialColor_INSERT]
(	
	
	@StyleBOMDimensionId		NVARCHAR(50), 
	@StyleBOMDimensionItemId	NVARCHAR(50),
	@Muser						VARCHAR(50),
	@MDate						DATETIME 
)
AS

BEGIN
	
	DECLARE @I AS INT
	DECLARE @Row_Count AS INT
	DECLARE @StyleMaterialID AS UniqueIdentifier
	
	SET @I = 1

	BEGIN
	CREATE TABLE #TempMaterials (
		Id int IDENTITY (1, 1) NOT NULL , 
		StyleMaterialID UniqueIdentifier,
		StyleBOMDimensionID UniqueIdentifier		
	) 
	END

	BEGIN
	
	INSERT INTO #TempMaterials
		(StyleMaterialID,StyleBOMDimensionID)
	SELECT 
		PSB.StyleMaterialID,
		PSB.StyleBOMDimensionId		
	FROM 
		pStyleBOM PSB		
	WHERE 
	PSB.StyleBOMDimensionID=@StyleBOMDimensionId
	--AND PSB.StyleMaterialID NOT IN (SELECT StyleMaterialID FROM pStyleBOMItem PSBI WHERE PSBI.StyleBOMDimensionID=@StyleBOMDimensionId )
	

	SELECT * FROM #TempMaterials
	
	SET @Row_Count = (SELECT COUNT(*) FROM #TempMaterials)

	WHILE @I <= @Row_Count 
		BEGIN

			SELECT @StyleMaterialID =StyleMaterialID FROM #TempMaterials WHERE ID = @I AND StyleBOMDimensionID=@StyleBOMDimensionID
			
			IF (SELECT COUNT(*) FROM pStyleBOMItem WITH (NOLOCK) WHERE StyleMaterialID=@StyleMaterialID AND StyleBOMDimensionID=@StyleBOMDimensionID AND StyleBOMDimensionItemID=@StyleBOMDimensionItemID) = 0
			BEGIN
			
				INSERT INTO pStyleBOMItem 
				(
					StyleBOMDimensionID,
					StyleBOMDimensionItemID,
					StyleMaterialID,
					WorkFlowID,
					WorkFlowItemID,
					MaterialColorID,
					StyleID,
					StyleSet,
					ItemDim1TypeId,
					ItemDim2TypeId,
					ItemDim3TypeId,
					ItemDim1Id,
					ItemDim1Name,
					ItemDim2Id,
					ItemDim2Name,
					ItemDim3Id,
					ItemDim3Name,
					MUser,
					MDate
				)
				SELECT 
					StyleBOMDimensionID,
					StyleBOMDimensionItemID,
					@StyleMaterialID,
					WorkFlowID,
					WorkFlowItemID,
					'00000000-0000-0000-0000-000000000000',
					StyleID,
					StyleSet,
					ItemDim1TypeId,
					ItemDim2TypeId,
					ItemDim3TypeId,
					ItemDim1Id,
					ItemDim1Name,
					ItemDim2Id,
					ItemDim2Name,
					ItemDim3Id,
					ItemDim3Name,
					MUser,
					MDate
				FROM 
					pStyleBOMDimensionItems 
				WHERE 							
					StyleBOMDimensionID=@StyleBOMDimensionId
					AND StyleBOMDimensionItemID=@StyleBOMDimensionItemId
			END
				
			SET @I = @I + 1
	END	

END

	IF OBJECT_ID('tempdb..#TempMaterials') IS NOT NULL
	BEGIN
		DROP TABLE #TempMaterials
	END
	
END


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03001'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03001', GetDate())
END
GO