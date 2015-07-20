IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimMiscMaterialColor_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimMiscMaterialColor_select]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimMiscMaterialColor_select]
(
@StyleMaterialId nvarchar(50),
@StyleMiscMaterialId nvarchar(50),
@StyleBOMDimensionId nvarchar(50)
)
as

select  p.* from  pStyleBOMMiscItem p Inner Join pstylebom b ON  b.stylematerialId = p.stylematerialId
and b.StyleBOMDimensionId = p.StyleBOMDimensionId  
where 	b.StyleBOMDimensionId = @StyleBOMDimensionId and p.StyleMaterialId=@StyleMaterialId
and p.StyleMaterialMiscId=@StyleMiscMaterialId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03640', GetDate())
GO