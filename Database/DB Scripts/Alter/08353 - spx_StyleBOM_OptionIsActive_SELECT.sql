IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_OptionIsActive_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_OptionIsActive_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOM_OptionIsActive_SELECT](
@StyleBOMDimensionID nvarchar(50),
@DimRow nvarchar(5),
@DimColumn nvarchar(5),
@DimTab nvarchar(5),
@DimRowId nvarchar(50),
@DimColumnId nvarchar(50),
@DimTabId nvarchar(50)
)
AS 
IF @DimTab <> ''
	BEGIN
		SELECT ComboActive FROM pStyleBOMDimensionItems 
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		AND ItemDim1Id = @DimRowId AND ItemDim2Id = @DimColumnId AND ItemDim3Id = @DimTabId
	END
ELSE
	BEGIN
		IF @DimRow <> '' 
			BEGIN
				IF @DimRow = '1' 
					BEGIN
						IF @DimColumn = '2' 
							BEGIN
								SELECT TOP 1 ComboActive FROM pStyleBOMDimensionItems
								WHERE StyleBOMDimensionID = @StyleBOMDimensionID
									AND ItemDim1Id = @DimRowId AND ItemDim2Id = @DimColumnId
									AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1
								ORDER BY ComboActive DESC
							END
						ELSE IF @DimColumn = '3'
							BEGIN
								SELECT TOP 1 ComboActive FROM pStyleBOMDimensionItems
								WHERE StyleBOMDimensionID = @StyleBOMDimensionID
									AND ItemDim1Id = @DimRowId AND ItemDim3Id = @DimColumnId
									AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1
								ORDER BY ComboActive DESC
							END	
						END		
				 ELSE IF @DimRow = '2'
					BEGIN 
						IF @DimColumn = '3' 
							BEGIN
								SELECT TOP 1 ComboActive FROM pStyleBOMDimensionItems
								WHERE StyleBOMDimensionID = @StyleBOMDimensionID
									AND ItemDim2Id = @DimRowId AND ItemDim3Id = @DimColumnId
									AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1
								ORDER BY ComboActive DESC
							END
					END		
			END
		ELSE
			BEGIN
				IF @DimColumn = '1' 
					BEGIN
						SELECT TOP 1 ComboActive FROM pStyleBOMDimensionItems
						WHERE StyleBOMDimensionID = @StyleBOMDimensionID
							AND ItemDim1Id = @DimColumnId
							AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1
						ORDER BY ComboActive DESC
					END   
				ELSE IF @DimColumn = '2' 
					BEGIN
						SELECT TOP 1 ComboActive FROM pStyleBOMDimensionItems
						WHERE StyleBOMDimensionID = @StyleBOMDimensionID
							AND ItemDim2Id = @DimColumnId
							AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1
						ORDER BY ComboActive DESC
					END
				ELSE IF @DimColumn = '3' 
					BEGIN
						SELECT TOP 1 ComboActive FROM pStyleBOMDimensionItems
						WHERE StyleBOMDimensionID = @StyleBOMDimensionID
							AND ItemDim3Id = @DimColumnId
							AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1
						ORDER BY ComboActive DESC
					END
			END
   
	END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08353', GetDate())
GO
