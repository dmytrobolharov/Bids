IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimValue_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimValue_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[spx_StyleBOMDimValue_Select]
(
@StyleBOMDimensionId nvarchar(50),
@Dimlevel int
)
AS 

If @Dimlevel = 1
	begin
		Select ItemDim1Id , ItemDim1Name FROM 
		pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
		and ItemDim1Id is not null  and ItemDim1Active=1 order by ItemDim1sort, ItemDim1Name
	end
else if  @Dimlevel = 2  
	begin
		Select ItemDim2Id, ItemDim2Name FROM 
		pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
		and ItemDim2Id is not null  and ItemDim2Active=1 order by ItemDim2sort, ItemDim2Name
	end
else if @Dimlevel = 3
	begin		
		Select ItemDim3Id, ItemDim3Name FROM 
		pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
		and ItemDim3Id is not null  and ItemDim3Active=1 order by ItemDim3sort, ItemDim3Name
    end
    
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03475', GetDate())
GO