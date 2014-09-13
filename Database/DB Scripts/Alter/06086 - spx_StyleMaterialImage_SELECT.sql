IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialImage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleMaterialImage_SELECT]
(  
@StyleID UNIQUEIDENTIFIER ,  
@StyleSet INT ,  
@MUser nvarchar(200),  
@MDate DATETIME,
@StyleSeasonYearID UNIQUEIDENTIFIER   
)  
AS  
  
DECLARE @DesignImageID UNIQUEIDENTIFIER  
DECLARE @DesignImageVersion INT  
  
CREATE TABLE  #Temp (     
           Rec_Id int identity(1,1)  ,     
           StyleDetailFormID  UNIQUEIDENTIFIER,  
           StyleDetailFormMasterID  UNIQUEIDENTIFIER,   
           StyleMaterialID UNIQUEIDENTIFIER,  
           MaterialNo NVARCHAR(50),
           MaterialName NVARCHAR(200), 
           MaterialID UNIQUEIDENTIFIER,         
           WorkflowID UNIQUEIDENTIFIER,  
           StyleID  UNIQUEIDENTIFIER, 
           StyleSet  INT,  
           ImageID  UNIQUEIDENTIFIER,  
           ImageVersion  INT,  
           Sort  nvarchar(5),  
           CUser  nvarchar(200),  
           CDate  DATETIME,  
           MUser  nvarchar(200),  
           MDate  DATETIME, 
           WorkFlowItemId  uniqueidentifier  
           )    
  
INSERT  INTO #Temp ( StyleDetailFormID ,  
          StyleDetailFormMasterID , 
          StyleMaterialID,
          MaterialNo ,
          MaterialName ,
          MaterialID ,
          WorkflowID ,  
          StyleID , 
          StyleSet ,  
          ImageID ,  
          ImageVersion ,           
          CUser ,  
          CDate ,  
          MUser ,  
          MDate , 
          WorkFlowItemId )   
SELECT NEWID() AS StyleDetailFormID ,  
        NEWID() as  StyleDetailFormMasterID ,  
          StyleMaterialID,
          MaterialNo ,
          MaterialName ,
          MaterialID,
          '60000000-0000-0000-0000-000000000666' ,  
          @StyleID ,  
          @StyleSet ,  
          MaterialImageID ,  
          MaterialImageVersion ,            
          @MUser ,  
          @MDate ,  
          @MUser ,  
          @MDate ,  
          '70000000-0000-0000-0000-000000000444'  FROM dbo.pStyleMaterials WHERE StyleID = @StyleID AND StyleSet = @StyleSet AND Artwork = 1
       
CREATE TABLE [#temp_pStyleColorway](
    [TableRow] INT IDENTITY(1,1),
	[StyleColorID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,	
	[StyleColorNo] [nvarchar](200) NULL,
	[StyleColorName] [nvarchar](200) NULL,
	[MainColor] [nvarchar](100) NULL,
	[ColorPaletteID] [uniqueidentifier] NULL	
	)
  
INSERT INTO [#temp_pStyleColorway]
SELECT 
    D.StyleColorwaySeasonYearID AS [StyleColorID],	
	A.[StyleColorNo],
	A.[StyleColorName],
	A.[MainColor],
	E.[ColorPaletteID]	
FROM pStyleColorwaySeasonYear D   
INNER JOIN dbo.pStyleColorway A ON D.StyleColorwayID = A.StyleColorID       
INNER JOIN pColorPalette AS E ON A.ColorPaletteID = E.ColorPaletteID   
WHERE A.StyleID = @StyleID AND StyleSet = @StyleSet AND D.StyleSeasonYearID = @StyleSeasonYearID   

CREATE TABLE [#temp_pStyleColorwayArtwork](
    [StyleColorwayArtworkID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleColorID] [uniqueidentifier] NULL,
	[StyleMaterialID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[Sort] [nvarchar](10) NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[ColorPaletteID] [uniqueidentifier] NULL,
	[MaterialID] [uniqueidentifier] NULL,	
	[MaterialArtworkImageID] [uniqueidentifier] NULL,
	[MaterialArtworkImageVersion] [int] NULL,
	[StyleSeasonYearID] [uniqueidentifier] NULL
	)

DECLARE @TotalCountColorway INT
DECLARE @TotalCountMaterial INT
DECLARE @RowCounterColorway INT
DECLARE @RowCounterMaterial INT

SELECT @TotalCountColorway = COUNT(*)
		FROM [#temp_pStyleColorway]
		
SELECT @TotalCountMaterial = COUNT(*)
		FROM [#temp]


SET @RowCounterMaterial = 1

DECLARE @StyleColorID [uniqueidentifier] 
DECLARE	@StyleMaterialID [uniqueidentifier]
DECLARE	@ColorPaletteID [uniqueidentifier] 
DECLARE	@MaterialID [uniqueidentifier] 	
DECLARE	@MaterialArtworkImageID [uniqueidentifier] 
DECLARE	@MaterialArtworkImageVersion [int] 
DECLARE @CountRecord INT
DECLARE @CountRecordTotal INT
DECLARE @MaxSort NVARCHAR(10)
  
WHILE (@RowCounterMaterial <= @TotalCountMaterial)
  BEGIN
  
                SET @StyleMaterialID = NULL 
                SET @MaterialID =  NULL
 				 				
 				SELECT @StyleMaterialID  = StyleMaterialID , @MaterialID = MaterialID
 				FROM [#temp] WHERE [Rec_Id] = @RowCounterMaterial
				
				SET @RowCounterColorway = 1
				
				WHILE (@RowCounterColorway <= @TotalCountColorway)
				   BEGIN
				 
				      SET @CountRecord = 0
				      SET @StyleColorID = NULL                     
                      SET @ColorPaletteID = NULL
                      
                      SELECT @StyleColorID  = StyleColorID , @ColorPaletteID = ColorPaletteID
 				      FROM [#temp_pStyleColorway] WHERE [TableRow] = @RowCounterColorway
                      
                                           
                      SELECT @CountRecord = COUNT(*) FROM pStyleColorwayArtwork WHERE StyleColorID  = @StyleColorID AND StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID  AND StyleSet = @StyleSet
				  
				           IF @CountRecord = 0
							  BEGIN
							  
							    INSERT INTO [#temp_pStyleColorwayArtwork]
								SELECT  NEWID() AS [StyleColorwayArtworkID] ,
								    @StyleColorID,
								    @StyleMaterialID,
								    @StyleID,
								    @StyleSet,
									@RowCounterMaterial,
									@MDate ,  
									@MUser ,
									@MDate ,  
									@MUser ,
									@ColorPaletteID,
									@MaterialID,
									'00000000-0000-0000-0000-000000000000',
									1,
									@StyleSeasonYearID
																		
							   END
							   
							  SET @RowCounterColorway = @RowCounterColorway + 1
				  
				     END	
						
 				 SET @RowCounterMaterial = @RowCounterMaterial + 1  
  
  END
  
INSERT INTO pStyleColorwayArtwork
SELECT * FROM #temp_pStyleColorwayArtwork
  
   
SELECT  * FROM #Temp ORDER BY StyleMaterialID
DROP TABLE #Temp  
DROP TABLE #temp_pStyleColorwayArtwork
DROP TABLE #temp_pStyleColorway


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06086', GetDate())
GO
