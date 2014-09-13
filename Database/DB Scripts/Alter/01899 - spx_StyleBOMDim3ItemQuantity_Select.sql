IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDim3ItemQuantity_Select]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMDim3ItemQuantity_Select]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDim3ItemQuantity_Select]    Script Date: 09/06/2011 13:43:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create  PROCEDURE [dbo].[spx_StyleBOMDim3ItemQuantity_Select](
@StyleMaterialID nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
@StyleID nvarchar(50), 
@StyleSet INT ,
@WorkflowID nvarchar(50), 
@WorkflowItemID nvarchar(50),
@StyleBOMDimensionItemId nvarchar(50)
)
AS 


begin
	SELECT top 1 MaterialQuantity FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID 
	and  StyleBOMDimensionItemId= @StyleBOMDimensionItemId
end
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01899'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01899', GetDate())
END

GO