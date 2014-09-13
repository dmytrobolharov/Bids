Alter table pBodyPatternSheetPiece alter column Piece_Name nvarchar(64)
Alter table pBodyPatternSheetPiece alter column Piece_Description nvarchar(510)
Alter table pBodyPatternSheetPiece alter column Piece_Category nvarchar(510)
Alter table pBodyPatternSheetPiece alter column Rule_Table_Name nvarchar(64)
Alter table pBodyPatternSheetPiece alter column Piece_CrOpId nvarchar(100)
Alter table pBodyPatternSheetPiece alter column Piece_RevOp1 nvarchar(100)
Alter table pBodyPatternSheetPiece alter column Piece_RevOp2 nvarchar(100)
Alter table pBodyPatternSheetPiece alter column Piece_Message nvarchar(510)
Alter table pBodyPatternSheetPiece alter column Piece_HPTable nvarchar(100)
Alter table pBodyPatternSheetPiece alter column UserDefined1 nvarchar(50)
Alter table pBodyPatternSheetPiece alter column UserDefined2 nvarchar(50)
Alter table pBodyPatternSheetPiece alter column UserDefined3 nvarchar(50)
Alter table pBodyPatternSheetPiece alter column UserDefined4 nvarchar(50)
Alter table pBodyPatternSheetPiece alter column UserDefined5 nvarchar(50)
Alter table pBodyPatternSheetPiece alter column Piece_Image_Name nvarchar(100)
Alter table pBodyPatternSheetPiece alter column Piece_Comments nvarchar(max)
Alter table pBodyPatternSheetPiece alter column Piece_Size nvarchar(64)


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02248'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02248', GetDate())
END	
GO