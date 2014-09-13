/****** Object:  StoredProcedure [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOMSizeActive_UPDATE]    Script Date: 06/27/2013 12:17:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleLink_MeasTemplate_DimensionalBOMSizeActive_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOMSizeActive_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOMSizeActive_UPDATE]    Script Date: 06/27/2013 12:17:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleLink_MeasTemplate_DimensionalBOMSizeActive_UPDATE]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@DimLevel INT,
	@SizeName NVARCHAR(200),
	@SizeActive INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @SizeDimTypeID UNIQUEIDENTIFIER
	SELECT @SizeDimTypeID = DimTypeID FROM pStyleBOMDimType WHERE DimTypeName = 'Size'

    IF @DimLevel = 1
		UPDATE pStyleBOMDimensionItem SET ItemDim1Active = @SizeActive
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		AND ItemDim1Id IS NOT NULL AND ItemDim2Id IS NULL AND ItemDim3Id IS NULL
		AND ItemDim1TypeId = @SizeDimTypeID
		AND ItemDim1Name = @SizeName
	ELSE IF @DimLevel = 2
		UPDATE pStyleBOMDimensionItem SET ItemDim2Active = @SizeActive
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		AND ItemDim1Id IS NULL AND ItemDim2Id IS NOT NULL AND ItemDim3Id IS NULL
		AND ItemDim2TypeId = @SizeDimTypeID
		AND ItemDim2Name = @SizeName
	ELSE IF @DimLevel = 3
		UPDATE pStyleBOMDimensionItem SET ItemDim3Active = @SizeActive
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		AND ItemDim1Id IS NULL AND ItemDim2Id IS NULL AND ItemDim3Id IS NOT NULL
		AND ItemDim3TypeId = @SizeDimTypeID
		AND ItemDim3Name = @SizeName
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05933', GetDate())
GO
