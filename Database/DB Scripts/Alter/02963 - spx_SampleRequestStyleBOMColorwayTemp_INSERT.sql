IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestStyleBOMColorwayTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestStyleBOMColorwayTemp_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestStyleBOMColorwayTemp_INSERT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_SampleRequestStyleBOMColorwayTemp_INSERT]
(
@SampleRequestGroupID uniqueidentifier,
@StyleID uniqueidentifier,
@ItemDim1Id uniqueidentifier,
@ItemDim2Id uniqueidentifier,
@ItemDim3Id uniqueidentifier,
@StyleSet nvarchar(10),
@CreatedBy nvarchar(200),
@CreatedDate nvarchar(100),
@WorkFlowItemID uniqueidentifier,
@StyleBOMDimensionID uniqueidentifier
)

AS

DECLARE @StyleBOMDimensionItemID  NVARCHAR(50)

DELETE FROM  pSampleRequestStyleBOMColorwayTemp WHERE ItemDim1Id = @ItemDim1Id AND ItemDim2Id = @ItemDim2Id AND ItemDim3Id = @ItemDim3Id  AND SampleRequestGroupID = @SampleRequestGroupID AND StyleSet = @StyleSet AND  StyleID = @StyleID 

SELECT @StyleBOMDimensionItemID = StyleBOMDimensionItemID FROM pStyleBOMDimensionItems WHERE ItemDim1Id=@ItemDim1Id AND ItemDim2Id=@ItemDim2Id AND ItemDim3Id=@ItemDim3Id  AND StyleBOMDimensionID=@StyleBOMDimensionID AND StyleID=@StyleID

IF (SELECT COUNT(*) FROM pSampleRequestStyleBOMColorwayTemp WITH (NOLOCK) WHERE ItemDim1Id = @ItemDim1Id AND ItemDim2Id = @ItemDim2Id AND ItemDim3Id = @ItemDim3Id AND StyleID = @StyleID AND SampleRequestGroupID = @SampleRequestGroupID AND StyleSet = @StyleSet)  = 0

BEGIN
	INSERT INTO pSampleRequestStyleBOMColorwayTemp
	(SampleRequestGroupID, ItemDim1Id,ItemDim2Id,ItemDim3Id, StyleID, StyleSet, CUser, CDate, MUser, MDate, Submit,WorkFlowItemID,StyleBOMDimensionID,StyleBOMDimensionItemID)
	VALUES (@SampleRequestGroupID, @ItemDim1Id,@ItemDim2Id,@ItemDim3Id, @StyleID, @StyleSet,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1,@WorkFlowItemID,@StyleBOMDimensionID,@StyleBOMDimensionItemID)
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02963'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02963', GetDate())
END
GO