

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBodyPatternSheetPiece'
    AND  COLUMN_NAME = 'Piece_Name')
	
	ALTER TABLE dbo.pBodyPatternSheetPiece ALTER COLUMN Piece_Name nvarchar(100) NOT NULL 
GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05862', GetDate())
GO