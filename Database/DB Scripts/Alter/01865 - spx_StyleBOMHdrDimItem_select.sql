IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMHdrDimItem_select]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMHdrDimItem_select]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMHdrDimItem_select]    Script Date: 09/06/2011 12:03:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create  PROCEDURE [dbo].[spx_StyleBOMHdrDimItem_select](
@ItemDimTypeId nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
@StyleID nvarchar(50), 
@StyleSet INT ,
@WorkflowID nvarchar(50), 
@WorkflowItemID nvarchar(50),
@DimLevel Int
)
AS 

Declare @TotalCnt int

SELECT @TotalCnt = Count(StyleBOMDimensionItemID) FROM pStyleBOMDimensionItem  where StyleBOMDimensionId = @StyleBOMDimensionId
				
if @TotalCnt > 0
	begin		
		if @DimLevel=1
			begin
				SELECT StyleBOMDimensionItemID, ItemDim1Id as ItemTypeId, ItemDim1Name as Dim1Name
				FROM pStyleBOMDimensionItem  where StyleBOMDimensionId = @StyleBOMDimensionId
				and ItemDim1Id is not null order by ItemDim1Sort, Dim1Name
			end
		if @DimLevel=2
			begin
				SELECT StyleBOMDimensionItemID, ItemDim2Id as ItemTypeId, ItemDim2Name as Dim2Name
				FROM pStyleBOMDimensionItem  where StyleBOMDimensionId = @StyleBOMDimensionId
				and ItemDim2Id is not null order by ItemDim2Sort, Dim2Name
			end
		if @DimLevel=3
			begin
				SELECT StyleBOMDimensionItemID, ItemDim3Id as ItemTypeId, ItemDim3Name as Dim3Name
				FROM pStyleBOMDimensionItem  where StyleBOMDimensionId = @StyleBOMDimensionId
				and ItemDim3Id is not null order by ItemDim3Sort, Dim3Name
			end							
	end
	
	GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01865'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01865', GetDate())
END

GO