IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Body_PatternSheetPiece_Sel]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Body_PatternSheetPiece_Sel]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROC  [dbo].[spx_Body_PatternSheetPiece_Sel]
(
	@BodyID uniqueidentifier,
	@StyleSet int,
	@ModelCode int,
	@Imperial nvarchar(2)
)
AS

BEGIN
	if Len(@Imperial)= 0
		begin
			select ID, 
			Model_Code, 
			Piece_Code, 			 
			IsLinked, 
			Piece_Name, 			
			Piece_Description,
			Piece_Comments,
			Piece_Image_Name,
			Material_Code,
			Piece_Category,
			Rule_Table_Name,
			Piece_nUnflipped,
			Piece_nOpposite,
			Round(Piece_Area,4) as Piece_Area,				
			Round(Piece_Perimeter,4) as Piece_Perimeter,	
			Piece_HPTable,
			Piece_Bias,
			Piece_Flip,
			Piece_Nap,
			Round(Piece_XVariance,4) as Piece_XVariance,
			Piece_XVar_Type,
			Round(Piece_YVariance,4) as Piece_YVariance,	
			Piece_YVar_Type,
			Piece_Ign_Splice,
			Piece_Standard,
			Piece_Buffering,
			Piece_nSplits					 
			from pBodyPatternSheetPiece WHERE Model_Code =@ModelCode AND BodyID = @BodyID AND StyleSet = @StyleSet ORDER BY PiecePosition			
		end		
	else
		begin
			select ID, 
			Model_Code, 
			Piece_Code, 			 
			IsLinked, 
			Piece_Name, 			
			Piece_Description,
			Piece_Comments,
			Piece_Image_Name,
			Material_Code,
			Piece_Category,
			Rule_Table_Name,
			Piece_nUnflipped,
			Piece_nOpposite,
			Round([Piece_Area]*6.4516,4) as Piece_Area,				
			Round([Piece_Perimeter]*2.54,4) as Piece_Perimeter,			
			Piece_HPTable,
			Piece_Bias,
			Piece_Flip,
			Piece_Nap,
			Round([Piece_XVariance]*2.54,4) as Piece_XVariance,
			Piece_XVar_Type,
			Round([Piece_YVariance]*2.54,4) as Piece_YVariance,			
			Piece_YVar_Type,
			Piece_Ign_Splice,
			Piece_Standard,
			Piece_Buffering,
			Piece_nSplits					 
			from pBodyPatternSheetPiece WHERE Model_Code =@ModelCode AND BodyID = @BodyID AND StyleSet = @StyleSet ORDER BY PiecePosition					
		end
		
		
End
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01308', GetDate())

GO