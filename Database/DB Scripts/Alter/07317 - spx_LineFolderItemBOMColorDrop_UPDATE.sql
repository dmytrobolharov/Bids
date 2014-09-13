IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemBOMColorDrop_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemBOMColorDrop_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_LineFolderItemBOMColorDrop_UPDATE]
(
@StyleColorID uniqueidentifier,
@StyleBOMDimensionID uniqueidentifier,
@DropStatus int
)
AS 

DECLARE @Active INT = 1

IF @DropStatus = 1 
	SET @Active = 0
ELSE
	SET @Active = 1

UPDATE pStyleBOMDimensionItem
SET ItemDim1Active = @Active
WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @StyleColorID
UPDATE pStyleBOMDimensionItem
SET ItemDim2Active = @Active
WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @StyleColorID
UPDATE pStyleBOMDimensionItem
SET ItemDim3Active = @Active
WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @StyleColorID

UPDATE pStyleBOMDimensionItems
SET ItemDim1Active = @Active
WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @StyleColorID
UPDATE pStyleBOMDimensionItems
SET ItemDim2Active = @Active
WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @StyleColorID
UPDATE pStyleBOMDimensionItems
SET ItemDim3Active = @Active
WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @StyleColorID
		
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07317', GetDate())
GO
