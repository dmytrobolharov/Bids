IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_pBodyPatternSheetPiece_Metric')
    BEGIN
         DROP VIEW vwx_pBodyPatternSheetPiece_Metric
    END
GO

CREATE VIEW vwx_pBodyPatternSheetPiece_Metric
AS
   select ID, 			
   Piece_Code, 			 			
   Piece_Name, 			
   Piece_Description,			
   Piece_Image_Name,			
   Piece_Category,			
   Round([Piece_Area]*6.4516,4) as Piece_Area,				
   Round([Piece_Perimeter]*2.54,4) as Piece_Perimeter										 
   from pBodyPatternSheetPiece
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01479', GetDate())
GO