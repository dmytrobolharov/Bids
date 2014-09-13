/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMatColorMgmtHdr_Sort_UPDATE]    Script Date: 05/15/2013 12:05:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMatColorMgmtHdr_Sort_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMatColorMgmtHdr_Sort_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMatColorMgmtHdr_Sort_UPDATE]    Script Date: 05/15/2013 12:05:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMMatColorMgmtHdr_Sort_UPDATE]
(
@StyleBOMDimensionId VARCHAR(40),
@DimID VARCHAR(40),
@Dimlevel NVARCHAR(2),
@DimSort INT
)

AS
BEGIN
					
	IF @Dimlevel = '1'
	BEGIN
		UPDATE pStyleBOMDimensionItem SET ItemDim1Sort = @DimSort
		WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim1Id = @DimID
	END
	ELSE IF @Dimlevel = '2'  
	BEGIN
		UPDATE pStyleBOMDimensionItem SET ItemDim2Sort = @DimSort
		WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim2Id = @DimID
	END
	ELSE IF @Dimlevel = '3'
	BEGIN
		UPDATE pStyleBOMDimensionItem SET ItemDim3Sort = @DimSort
		WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim3Id = @DimID
	END

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05678', GetDate())
GO
