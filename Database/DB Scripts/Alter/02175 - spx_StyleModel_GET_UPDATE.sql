IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleModel_GET_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleModel_GET_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC  [dbo].[spx_StyleModel_GET_UPDATE]
(
	@CADDB varchar(50),
	@Catalog varchar(50),
	@StyleID uniqueidentifier,
	@StyleSet int,
	@strSortOrder varchar(50)
)
AS

BEGIN

declare @ID uniqueidentifier
declare @Model_Code int

declare @Sortsql   nvarchar(max)
declare @strCADsql nvarchar(max)

SELECT ROW_NUMBER() OVER(ORDER BY Model_Code DESC) AS 'rownum', * 
into #tempTblBody

FROM pBodyPatternSheetModel where StyleID = @StyleID AND StyleSet = @StyleSet and IsLinked = 1

declare @ModelID uniqueidentifier
declare @RowCnt int
select @RowCnt = 1
declare @MaxRows int
select @MaxRows=count(*) from #tempTblBody

while @RowCnt <= @MaxRows
begin

------------------------------------------------
set @Model_Code = (select Model_Code from #tempTblBody where rownum = @RowCnt) 
set @StyleID =  (select StyleID from #tempTblBody where rownum = @RowCnt)
Set @ID =  (select ID from #tempTblBody where rownum = @RowCnt)

------------------------------------------------

CREATE TABLE #tempTBLCAD(
	[Model_Code] [int] NOT NULL DEFAULT ((0)),
	[Model_Name] [varchar](32)  NULL,
	[Last_Updated] [datetime] NULL,
	[IsActive] [int] NULL DEFAULT ((-1)),
	[IsLinked] [int] NULL DEFAULT ((0)),
	[ClassifierId] [int]  NULL,
	[SystemId] [int]  NULL,
	[Marker_Code] [int] NULL,
	[Model_Description] [varchar](255) NULL,
	[Model_CrOpId] [varchar](50) NULL,
	[Model_Create] [datetime] NULL,
	[Model_RevOp1] [varchar](50) NULL,
	[Model_Rev1] [datetime] NULL,
	[Model_RevOp2] [varchar](50) NULL,
	[Model_Rev2] [datetime] NULL,
	[Model_GRTable] [varchar](50) NULL,
	[Model_MTMFile] [varchar](50) NULL,
	[Model_SAName] [varchar](50) NULL,
	[Model_SYNTable] [varchar](50) NULL,
	[Model_HPTable] [varchar](50) NULL,
	[Model_SampleSize] [varchar](32) NULL,
	[Model_nMaterials] [int] NULL,
	[Model_nPieces] [int] NULL,
	[Model_nSizes] [int] NULL,
	[Model_Image_SN] [int] NULL,
	[Model_Image_Name] [varchar](255) NULL,
	[Model_Comments] [text] NULL,
	[PreferMetric] [int] NULL DEFAULT ((0)),
	[UserDefined1] [varchar](50) NULL,
	[UserDefined2] [varchar](50) NULL,
	[UserDefined3] [varchar](50) NULL,
	[UserDefined4] [varchar](50) NULL,
	[UserDefined5] [varchar](50) NULL,
	[Total_Area] [float] NULL,
	[LastCADRefresh] [datetime] NULL,
	[PlotFileLocation] [varchar](255) NULL,
	[NotchFile] [varchar](50) NULL,
	[AnnotationFile] [varchar](50) NULL,
	[StorageType] [int] NULL
)

SELECT  @strCADsql = 'INSERT
INTO #tempTBLCAD
SELECT 
	[Model_Code],
	[Model_Name],
	[Last_Updated],
	[IsActive],
	[IsLinked],
	[ClassifierId],
	[SystemId],
	[Marker_Code],
	[Model_Description],
	[Model_CrOpId],
	[Model_Create],
	[Model_RevOp1],
	[Model_Rev1],
	[Model_RevOp2],
	[Model_Rev2],
	[Model_GRTable],
	[Model_MTMFile],
	[Model_SAName],
	[Model_SYNTable],
	[Model_HPTable],
	[Model_SampleSize],
	[Model_nMaterials],
	[Model_nPieces],
	[Model_nSizes],
	[Model_Image_SN],
	[Model_Image_Name],
	[Model_Comments],
	[PreferMetric],
	[UserDefined1],
	[UserDefined2],
	[UserDefined3],
	[UserDefined4],
	[UserDefined5],
	[Total_Area],
	[LastCADRefresh],
	[PlotFileLocation],
	[NotchFile],
	[AnnotationFile],
	[StorageType] 
FROM ' + @CADDB + '.' + @Catalog + '.dbo.Cad_Model_Details WHERE  Model_Code = ' + Convert(varchar(50),@Model_Code)


EXEC (@strCADsql)

IF (SELECT COUNT(*) FROM #tempTBLCAD) > 0
BEGIN
	Update pBodyPatternSheetModel
	SET	 
	 
		  [Marker_Code] = (SELECT Model_Code from  #tempTBLCAD) 
		  ,[Model_Name] = (SELECT Model_Name from  #tempTBLCAD ) 
		  ,[Model_Description] = (SELECT Model_Description from  #tempTBLCAD ) 
		  ,[Active]= 1
		  ,[IsLinked] = 1
		  ,[Model_CrOpId]= (SELECT Model_CrOpId from  #tempTBLCAD) 
		  ,[Model_Create]= (SELECT Model_Create from  #tempTBLCAD) 
		  ,[Model_RevOp1]  = (SELECT Model_RevOp1 from  #tempTBLCAD) 
		  ,[Model_Rev1] = (SELECT Model_Rev1 from  #tempTBLCAD )
		  ,[Model_RevOp2] = (SELECT Model_RevOp2 from  #tempTBLCAD )
		  ,[Model_Rev2] = (SELECT Model_Rev2 from  #tempTBLCAD) 
		  ,[Model_GRTable] = (SELECT Model_GRTable from  #tempTBLCAD )
		  ,[Model_MTMFile]= (SELECT Model_MTMFile from  #tempTBLCAD) 
		  ,[Model_SAName] = (SELECT Model_SAName from  #tempTBLCAD )
		  ,[Model_SYNTable] = (SELECT Model_SYNTable from  #tempTBLCAD)
		  ,[Model_HPTable] = (SELECT Model_HPTable from  #tempTBLCAD )
		  ,[Model_SampleSize]= (SELECT Model_SampleSize from  #tempTBLCAD) 
		  ,[Model_nMaterials]= (SELECT Model_nMaterials from  #tempTBLCAD )
		  ,[Model_nPieces] = (SELECT Model_nPieces from  #tempTBLCAD )
		  ,[Model_nSizes] = (SELECT Model_nSizes from  #tempTBLCAD )
		  ,[Model_Image_SN]= (SELECT Model_Image_SN from  #tempTBLCAD) 
		  ,[Model_Image_Name]= (SELECT Model_Image_Name from  #tempTBLCAD) 
		  --,[Model_Comments] = (SELECT Model_Comments from  #tempTBLCAD )
		  ,[PreferMetric]= (SELECT PreferMetric from  #tempTBLCAD) 
		  ,[UserDefined1]= (SELECT UserDefined1 from  #tempTBLCAD) 
		  ,[UserDefined2]= (SELECT UserDefined2 from  #tempTBLCAD) 
		  ,[UserDefined3]= (SELECT UserDefined3 from  #tempTBLCAD) 
		  ,[UserDefined4]= (SELECT UserDefined4 from  #tempTBLCAD) 
		  ,[UserDefined5]= (SELECT UserDefined5 from  #tempTBLCAD) 
		  ,[Total_Area]= (SELECT Total_Area from  #tempTBLCAD) 
		  ,[LastCADRefresh]= (SELECT LastCADRefresh from  #tempTBLCAD) 
		  ,[PlotFileLocation]= (SELECT PlotFileLocation from  #tempTBLCAD) 
		  ,[NotchFile]= (SELECT NotchFile from  #tempTBLCAD) 
		  ,[AnnotationFile]= (SELECT AnnotationFile from  #tempTBLCAD) 
		  ,[StorageType]= (SELECT StorageType from  #tempTBLCAD) 
			

			
	Where pBodyPatternSheetModel.Model_Code = (select Model_Code from #tempTblBody where rownum = @RowCnt)
		   AND pBodyPatternSheetModel.StyleID = @StyleID AND StyleSet = @StyleSet and IsLinked = 1

END
   
   Select @RowCnt = @RowCnt + 1
Set @ModelID = (SELECT ID From pBodyPatternSheetModel Where pBodyPatternSheetModel.Model_Code = (select Model_Code from #tempTblBody where rownum = @RowCnt)
       AND pBodyPatternSheetModel.StyleID = @StyleID AND StyleSet = @StyleSet and IsLinked = 1)
       
     
EXEC [spx_BodyPatternSheetPiece_GET_UPDATE] @ModelID,@CADDB,@Catalog

Drop Table #tempTBLCAD
END

Drop Table #tempTblBody

select @Sortsql = 'SELECT 	[ID] ,
	[BodyID],
	[StyleID],
	[Model_Code],
	[Model_Name],
	[Last_Updated],
	[Active],
    IsLinkedBF,
	[IsLinked],
	CUser,
	CDate,
    MDate,
    MUser,
	[Marker_Code],
	[Model_Description],
	[Model_CrOpId],
	[Model_Create],
	[Model_RevOp1],
	[Model_Rev1],
	[Model_RevOp2],
	[Model_Rev2],
	[Model_GRTable],
	[Model_MTMFile],
	[Model_SAName],
	[Model_SYNTable],
	[Model_HPTable],
	[Model_SampleSize],
	[Model_nMaterials],
	[Model_nPieces],
	[Model_nSizes],
	[Model_Image_SN],
	[Model_Image_Name],
	convert (varchar(300),Model_Comments) as Model_Comments,
	[PreferMetric],
	[UserDefined1],
	[UserDefined2],
	[UserDefined3],
	[UserDefined4],
	[UserDefined5],
	[Total_Area],
	[LastCADRefresh],
	[PlotFileLocation],
	[NotchFile],
	[AnnotationFile],
	[StorageType] FROM pBodyPatternSheetModel  WHERE (StyleID = ' + CHAR(39) + Convert(varchar(36),@StyleID) + CHAR(39) + ' AND StyleSet = ' + Convert(varchar(10),@StyleSet) + ' AND Active = 1)' + ' order by ' + @strSortOrder
EXEC(@Sortsql)
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02175'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02175', GetDate())
	END
GO