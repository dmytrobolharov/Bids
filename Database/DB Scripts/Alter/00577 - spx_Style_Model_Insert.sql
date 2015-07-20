SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Style_Model_Insert') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Style_Model_Insert
GO

CREATE procedure [dbo].[spx_Style_Model_Insert] (
@ID UNIQUEIDENTIFIER ,
@StyleID UNIQUEIDENTIFIER ,
@CADDB varchar(50),
@Catalog varchar(50),
@Model_Code int,
@CUser nvarchar(200),
@CDate datetime,
@MUser nvarchar(200),
@MDate datetime
)
AS
Declare @Linked  int
Declare @strCADModel nvarchar(max)
Declare @strCADPiece nvarchar(max)
Declare @ImageID  UNIQUEIDENTIFIER 
Declare @pID UNIQUEIDENTIFIER 
DECLARE @BodyID  UNIQUEIDENTIFIER
Set @BodyID = null
set @CDate = getdate()

BEGIN


IF not exists  (select * from dbo.pBodyPatternSheetModel where ID = @ID)
Set @Linked = 1


SELECT @strCADModel ='
INSERT INTO dbo.pBodyPatternSheetModel' + 
' SELECT '+  CHAR(39) + Convert(varchar(36),@ID) + CHAR(39) + ' as ID, 
null as BodyID,'+ CHAR(39) + Convert(varchar(36),@StyleID) + CHAR(39) 
+' as StyleID ,[Model_Code]
 ,[Model_Name],[Last_Updated],1 as [Active], 0 as [IsLinkedBF], 1 as [IsLinked],' 
  + convert(nvarchar(50), CAST(@CDate AS DATETIME), 101) +' as [CDate],' 
+ CHAR(39) + Convert(varchar(36),@CUser) + CHAR(39) +' as [CUser],'
+ CHAR(39) + Convert(varchar(36),@MUser) + CHAR(39) + ' as [MUser],'
+ convert(nvarchar(50), CAST(@CDate AS DATETIME), 101)  + ' as [MDate]          
--,[ClassifierId],[SystemId]
,[Marker_Code],[Model_Description],[Model_CrOpId],[Model_Create]
,[Model_RevOp1],[Model_Rev1],[Model_RevOp2],[Model_Rev2],[Model_GRTable],[Model_MTMFile]
,[Model_SAName],[Model_SYNTable],[Model_HPTable],[Model_SampleSize],[Model_nMaterials],[Model_nPieces]
,[Model_nSizes],[Model_Image_SN],[Model_Image_Name],[Model_Comments],[PreferMetric],[UserDefined1]
,[UserDefined2],[UserDefined3],[UserDefined4],[UserDefined5],[Total_Area],[LastCADRefresh]
,[PlotFileLocation],[NotchFile],[AnnotationFile],[StorageType], null as ImageID' +

' FROM ' +  @CADDB + '.' + @Catalog + 
 '.dbo.Cad_Model_Details WHERE  Model_Code = ' + Convert(varchar(50),@Model_Code)
--print @strCADModel
--return
-- EXEC [spx_BodyPatternsheet_Model_Insert]'119c1d8e-b113-4677-ba0e-93b4c71e4026','d888c2ec-9ea0-460e-89fc-693930d8e780','[SIVA-PC]','[kellwood]','17610','siva nandigam','2010-10-04T11:49:41.253','siva nandigam','2010-10-04T11:49:41.253'
EXEC (@strCADModel)

Exec [spx_Body_Model_Piece_INSERT] @CADDB,@Catalog,@Model_Code

END
GO

--------------------------------------------------------------
--------------------------------------------------------------
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '577', GetDate())
GO

