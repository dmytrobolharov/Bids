
/****** Object:  StoredProcedure [dbo].[spx_BodyPatternsheet_Model_Insert]    Script Date: 09/10/2010 15:26:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_BodyPatternsheet_Model_Insert') and sysstat & 0xf = 4)
    drop procedure spx_BodyPatternsheet_Model_Insert
GO

CREATE procedure spx_BodyPatternsheet_Model_Insert (
@ID UNIQUEIDENTIFIER ,
@BodyID UNIQUEIDENTIFIER ,
@Model_Code int,
@CUser nvarchar(200),
@CDate datetime,
@MUser nvarchar(200),
@MDate datetime
)
AS
BEGIN
Declare @Linked as int

Declare @ImageID as UNIQUEIDENTIFIER 
Set @ImageID = null

IF not exists  (select * from dbo.pBodyPatternSheetModel where ID = @ID)
Set @Linked = 1

INSERT INTO dbo.pBodyPatternSheetModel 
SELECT @ID as ID,@BodyID as BodyID ,null as StyleID
 ,[Model_Code]
 ,[Model_Name],[Last_Updated],1 as [Active],1 as [IsLinked]
 ,@CDate as [CDate],@CUser as [CUser],@MUser as [MUser],@MDate as [MDate]                
 --,[ClassifierId],[SystemId]
,[Marker_Code],[Model_Description],[Model_CrOpId],[Model_Create]
,[Model_RevOp1],[Model_Rev1],[Model_RevOp2],[Model_Rev2],[Model_GRTable],[Model_MTMFile]
,[Model_SAName],[Model_SYNTable],[Model_HPTable],[Model_SampleSize],[Model_nMaterials],[Model_nPieces]
,[Model_nSizes],[Model_Image_SN],[Model_Image_Name],[Model_Comments],[PreferMetric],[UserDefined1]
,[UserDefined2],[UserDefined3],[UserDefined4],[UserDefined5],[Total_Area],[LastCADRefresh]
,[PlotFileLocation],[NotchFile],[AnnotationFile],[StorageType]

FROM Cad_Model_Details
WHERE  Model_Code = @Model_Code

IF not exists  (select * from dbo.pBodyPatternSheetPiece where Model_Code = @Model_Code)
Begin
select newid() as ID,[Piece_Code]
,[Piece_Name],[Last_Updated],1 as [Active],1 as [IsLinked]--,[ClassifierId],[SystemId] 
,@Model_Code as Model_Code,[Material_Code],[Piece_Description],[Piece_Category],[Piece_CrOpId],[Piece_Create],[Piece_RevOp1],[Piece_Rev1]
,[Piece_RevOp2],[Piece_Rev2],[Piece_Message],[Piece_HPTable],[Piece_Bias],[Piece_Flip],[Piece_Nap]
,[Piece_Ign_Splice] ,[Piece_Standard] ,[Piece_Buffering] ,[Piece_nSplits],[Piece_Tilt_CW],[Piece_DieBlock],[Piece_Pri_XBlock]
,[Piece_Pri_XBlkType],[Piece_Pri_YBlock],[Piece_Pri_YBlkType],[Piece_Sec_XBlock],[Piece_Sec_XBlkType]
,[Piece_Sec_YBlock],[Piece_Sec_YBlkType],[Piece_XVariance],[Piece_XVar_Type],[Piece_YVariance] ,[Piece_YVar_Type]
,[Piece_nUnflipped],[Piece_nOpposite],[Piece_nFilpY],[Piece_nFlipXY],[Piece_IsMirror],[Piece_Area]
,[Piece_Perimeter],[Piece_PreRotation],[Piece_Image_SN],[Piece_Image_Name],[Piece_Comments],[UserDefined1],[UserDefined2]
,[UserDefined3],[UserDefined4],[UserDefined5],[Piece_Size],[Piece_Tilt_CCW],[Piece_CW_Type],[Piece_CCW_Type],[Piece_PreRotationType]
,[PiecePosition],[mPiece_Area],[mPiece_Perimeter], @ImageID as ImageID

INTO #tempTBL1
FROM Cad_Piece_Details
WHERE  Model_Code = @Model_Code

INSERT INTO pBodyPatternSheetPiece
SELECT *

From #tempTBL1

Drop Table #tempTBL1
End
END
GO
--------------------------------------------------------------
--------------------------------------------------------------


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '380', GetDate())
GO