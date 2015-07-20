IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMColorwayHdr_Sel]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMColorwayHdr_Sel]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMColorwayHdr_Sel]    Script Date: 09/06/2011 12:28:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_StyleBOMColorwayHdr_Sel] (
@ItemDimTypeId nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
@StyleID nvarchar(50), 
@StyleSet INT ,
@WorkflowID nvarchar(50), 
@WorkflowItemID nvarchar(50),
@DimLevel Int 
)
AS 	

	begin		
		if @DimLevel=1
			begin
				SELECT distinct(b.styleColorName) as Dim1Name, b.Sort, b.MainColor
				FROM pStyleColorwaySeasonYear a 
				INNER JOIN pStyleColorway b ON a.StyleColorwayID = b.StyleColorID
				INNER JOIN pColorPalette c ON c.ColorPaletteID = b.ColorPaletteID 
				WHERE  b.StyleID = cast(@StyleID as nvarchar(50)) and b.Styleset = @StyleSet				
				ORDER BY b.Sort, b.MainColor
			end
		if @DimLevel=2
			begin
				SELECT distinct(b.styleColorName) as Dim2Name, b.Sort, b.MainColor
				FROM pStyleColorwaySeasonYear a 
				INNER JOIN pStyleColorway b ON a.StyleColorwayID = b.StyleColorID
				INNER JOIN pColorPalette c ON c.ColorPaletteID = b.ColorPaletteID 
				WHERE  b.StyleID = cast(@StyleID as nvarchar(50)) and b.Styleset = @StyleSet				
				ORDER BY b.Sort, b.MainColor
			end
		if @DimLevel=3
			begin
				SELECT distinct(b.styleColorName) as Dim3Name, b.Sort, b.MainColor
				FROM pStyleColorwaySeasonYear a 
				INNER JOIN pStyleColorway b ON a.StyleColorwayID = b.StyleColorID
				INNER JOIN pColorPalette c ON c.ColorPaletteID = b.ColorPaletteID 
				WHERE  b.StyleID = cast(@StyleID as nvarchar(50)) and b.Styleset = @StyleSet				
				ORDER BY b.Sort, b.MainColor
			end							
	end
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01880'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01880', GetDate())
END

GO