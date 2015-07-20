IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimMiscMaterialColor_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimMiscMaterialColor_UPDATE]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimMiscMaterialColor_UPDATE] (
@StyleMaterialMiscId nvarchar(50),
@CustomColValue nvarchar(200),
@StyleMaterialID nvarchar(50),
@StyleColorID nvarchar(50),
@StyleID nvarchar(50),
@Styleset int,
@StyleBOMDimensionId nvarchar(50),
@Materialno nvarchar(50),
@Materialname nvarchar(200),
@DimColor nVarchar(2),
@MUser nvarchar(200),
@MDate datetime
)
AS 	

declare @Rowcnt int	

update pStyleBOMMiscItem set MaterialNo=@Materialno, MaterialName=@MaterialName
where StyleMaterialID=@StyleMaterialID
and StyleBOMDimensionId=@StyleBOMDimensionId and StyleMaterialMiscId=@StyleMaterialMiscId 

select @Rowcnt = Count(StyleMaterialID) from pStyleBOMMiscItem where StyleMaterialID=@StyleMaterialID
and StyleBOMDimensionId=@StyleBOMDimensionId and StyleMaterialMiscId=@StyleMaterialMiscId 
and StyleBOMDimensionitemId	=@StyleColorID 

if @Rowcnt>0
	begin
		update pStyleBOMMiscItem set Custom1=@CustomColValue
		where StyleMaterialID=@StyleMaterialID
		and StyleBOMDimensionId=@StyleBOMDimensionId and StyleMaterialMiscId=@StyleMaterialMiscId 
		and StyleBOMDimensionitemId	=@StyleColorID 
	end
else
	begin
		insert into pStyleBOMMiscItem (StyleBOMDimensionId, StyleBOMDimensionItemId, StyleMaterialMiscId, StyleMaterialID,
		MaterialNo, MaterialName, SubMaterial, Custom1,  CDate, CUser, MDate, MUser)
		values (@StyleBOMDimensionId, @StyleColorID, @StyleMaterialMiscId, @StyleMaterialID,
		@MaterialNo, @MaterialName, 1, @CustomColValue,  @MDate, @MUser, @MDate, @MUser)
	end
	


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03633', GetDate())
GO