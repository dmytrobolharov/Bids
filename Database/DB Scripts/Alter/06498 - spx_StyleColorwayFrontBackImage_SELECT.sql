IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayFrontBackImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayFrontBackImage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleColorwayFrontBackImage_SELECT]  
(  
@StyleID UNIQUEIDENTIFIER ,  
@StyleSet INT ,  
@MUser nvarchar(200),  
@MDate datetime  ,
@StyleSeasonYearID UNIQUEIDENTIFIER 
)  
AS  
  
CREATE TABLE [#temp_pStyleColorwaySeasonYear](  
 [TableRow] INT IDENTITY(1,1),  
 [StyleColorID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,   
 [StyleColorNo] [nvarchar](200) NULL,  
 [StyleColorName] [nvarchar](200) NULL,  
 [MainColor] [nvarchar](100) NULL,  
 [ColorPaletteID] [uniqueidentifier] NULL,  
 [DesignImageFrontID] [uniqueidentifier] NULL,  
 [DesignImageFrontVersion] [int] NULL,  
 [DesignImageBackID] [uniqueidentifier] NULL,  
 [DesignImageBackVersion] [int] NULL  
 )  
   
CREATE TABLE [#temp_pStyleColorwaySeasonYear_SELECT](  
    [TableRowSEL] INT IDENTITY(1,1),  
    [Rec_Id] INT ,  
    [StyleDetailFormID] UNIQUEIDENTIFIER,  
    [StyleDetailFormMasterID]  UNIQUEIDENTIFIER,  
    [WorkflowID] UNIQUEIDENTIFIER,  
    [WorkFlowItemId]  UNIQUEIDENTIFIER,  
 [StyleColorID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,   
 [StyleColorNo] [nvarchar](200) NULL,  
 [StyleColorName] [nvarchar](200) NULL,  
 [MainColor] [nvarchar](100) NULL,  
 [ColorPaletteID] [uniqueidentifier] NULL,  
 [ImageID] [uniqueidentifier] NULL,  
 [ImageVersion] [int] NULL  ,
 [StyleColorDisplay] [nvarchar](1000) NULL 
 )   
   
  
INSERT INTO [#temp_pStyleColorwaySeasonYear]  
SELECT   
 D.StyleColorwaySeasonYearID AS [StyleColorID],   
 [StyleColorNo],  
 [StyleColorName],  
 [MainColor],  
 A.[ColorPaletteID],  
 D.[DesignImageFrontID],  
 D.[DesignImageFrontVersion],  
 D.[DesignImageBackID],  
 D.[DesignImageBackVersion]  
FROM pStyleColorwaySeasonYear D   
INNER JOIN dbo.pStyleColorway A ON D.StyleColorwayID = A.StyleColorID       
INNER JOIN pColorPalette AS E ON A.ColorPaletteID = E.ColorPaletteID   
WHERE A.StyleID = @StyleID AND StyleSet = @StyleSet AND D.StyleSeasonYearID = @StyleSeasonYearID  
UNION
SELECT   
 D.StyleColorwaySeasonYearID AS [StyleColorID],   
 E.[ColorCode],  
 E.[ColorName],  
 E.[ColorName] AS [MainColor],  
 D.[ColorPaletteID],  
 D.[DesignImageFrontID],  
 D.[DesignImageFrontVersion],  
 D.[DesignImageBackID],  
 D.[DesignImageBackVersion]  
FROM pStyleColorwaySeasonYear D   
INNER JOIN pColorPalette AS E ON D.ColorPaletteID = E.ColorPaletteID   
WHERE D.StyleID = @StyleID AND D.StyleSeasonYearID = @StyleSeasonYearID  



  
DECLARE @TotalCount INT  
DECLARE @RowCounter INT  
  
DECLARE  @StyleColorID [uniqueidentifier]    
DECLARE  @StyleColorNo [nvarchar](200)   
DECLARE  @StyleColorName [nvarchar](200)   
DECLARE  @MainColor [nvarchar](100)   
DECLARE  @ColorPaletteID [uniqueidentifier]   
DECLARE  @DesignImageFrontID [uniqueidentifier]   
DECLARE  @DesignImageFrontVersion [int]   
DECLARE  @DesignImageBackID [uniqueidentifier]   
DECLARE  @DesignImageBackVersion [int]   
  
        /*Get & set counts for the number of Rows in FolderHeaders.*/  
  SELECT @TotalCount = COUNT(*)  
  FROM [#temp_pStyleColorwaySeasonYear]  
  
  SET @RowCounter = 1  
    
  /*Loop through the records to assign to each individual variable values.*/  
  WHILE(@RowCounter <= @TotalCount)  
   BEGIN  
     
    SET @StyleColorID = null    
     SET @StyleColorNo = ''   
     SET @StyleColorName = ''   
    SET @MainColor = ''   
     SET @ColorPaletteID = null   
    SET @DesignImageFrontID = '00000000-0000-0000-0000-000000000000'   
     SET @DesignImageFrontVersion = 0   
     SET @DesignImageBackID = '00000000-0000-0000-0000-000000000000'   
     SET @DesignImageBackVersion = 0   
       
     SELECT @StyleColorID  = StyleColorID , @StyleColorNo = StyleColorNo, @StyleColorName = StyleColorName ,  
     @MainColor = MainColor ,@ColorPaletteID = ColorPaletteID, @DesignImageFrontID= ISNULL(DesignImageFrontID,'00000000-0000-0000-0000-000000000000'), @DesignImageFrontVersion = ISNULL(DesignImageFrontVersion,0),   
     @DesignImageBackID = ISNULL(DesignImageBackID,'00000000-0000-0000-0000-000000000000'), @DesignImageBackVersion = ISNULL(DesignImageBackVersion,0) FROM [#temp_pStyleColorwaySeasonYear] WHERE [TableRow] = @RowCounter  
      
    INSERT INTO [#temp_pStyleColorwaySeasonYear_SELECT]  
    SELECT  1 AS [Rec_Id] ,  
    NEWID() AS StyleDetailFormID,  
    NEWID() AS  StyleDetailFormMasterID,  
    '40000000-0000-0000-0000-000000000888',  
    '80000000-0000-0000-0000-000000000888',  
                 @StyleColorID,   
     @StyleColorNo ,  
     @StyleColorName,  
     @MainColor,  
     @ColorPaletteID,  
     @DesignImageFrontID,  
     @DesignImageFrontVersion ,
      '(' +  @StyleColorNo +  ') ' + @StyleColorName AS StyleColorDisplay
      
       
    INSERT INTO [#temp_pStyleColorwaySeasonYear_SELECT]  
    SELECT  2 AS [Rec_Id] ,  
    NEWID() AS StyleDetailFormID,  
    NEWID() AS  StyleDetailFormMasterID,  
    '40000000-0000-0000-0000-000000000888',  
    '80000000-0000-0000-0000-000000000888',  
     @StyleColorID,   
     @StyleColorNo ,  
     @StyleColorName,  
     @MainColor,  
     @ColorPaletteID,  
     @DesignImageBackID,  
     @DesignImageBackVersion ,  
      '(' +  @StyleColorNo +  ') ' + @StyleColorName AS StyleColorDisplay
       
        
      SET @RowCounter = @RowCounter + 1    
    
          END  
            
SELECT  * FROM #temp_pStyleColorwaySeasonYear_SELECT    
DROP TABLE #temp_pStyleColorwaySeasonYear_SELECT   
DROP TABLE #temp_pStyleColorwaySeasonYear

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06498', GetDate())
GO
