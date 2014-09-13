IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayArtworkImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayArtworkImage_SELECT]
GO


CREATE PROCEDURE spx_StyleColorwayArtworkImage_SELECT  
(    
@StyleID UNIQUEIDENTIFIER ,    
@StyleSet INT ,    
@MUser nvarchar(200),    
@MDate DATETIME,
@StyleSeasonYearID UNIQUEIDENTIFIER    
)    
AS    
  
  
CREATE TABLE [#pStyleColorwayArtwork](  
    [StyleDetailFormID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,  
    [StyleColorwayArtworkID] [uniqueidentifier] NOT NULL,  
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
 [ImageID] [uniqueidentifier] NULL,  
 [ImageVersion] [int] NULL,  
 [WorkFlowID] [uniqueidentifier] NULL,  
 [WorkFlowItemID] [uniqueidentifier] NULL,  
 [StyleColorNo] [nvarchar](200) NULL,  
 [StyleColorName] [nvarchar](200) NULL ,
 [StyleColorDisplay] [nvarchar](1000) NULL 
 )  
   
INSERT INTO [#pStyleColorwayArtwork]  
SELECT  NEWID() AS [StyleDetailFormID] ,  
    A.StyleColorwayArtworkID ,  
    A.StyleColorID,  
    A.StyleMaterialID,  
    A.StyleID,  
    A.StyleSet,  
 A.Sort,  
 A.CDate ,    
 A.CUser ,  
 A.MDate ,    
 A.MUser ,  
 A.ColorPaletteID,  
 A.MaterialID,  
 A.MaterialArtworkImageID,  
 A.MaterialArtworkImageVersion,  
 '60000000-0000-0000-0000-000000000666' AS [WorkFlowID],  
 '70000000-0000-0000-0000-000000000444' AS [WorkFlowItemID],  
 C.StyleColorNo ,  
 C.StyleColorName ,
  '(' +  C.StyleColorNo +  ') ' + C.StyleColorName AS StyleColorDisplay
 FROM pStyleColorwayArtwork A   
 INNER JOIN dbo.pStyleMaterials B ON A.StyleMaterialID = B.StyleMaterialID     
  INNER JOIN dbo.pStyleColorwaySeasonYear D ON A.StyleColorID = D.StyleColorwaySeasonYearID   
  INNER JOIN dbo.pStyleColorway C ON D.StyleColorwayID = C.StyleColorID     
  INNER JOIN pColorPalette AS E ON C.ColorPaletteID = E.ColorPaletteID    
 WHERE A.StyleID = @StyleID AND A.StyleSet = @StyleSet AND B.ARTWORK = 1 AND A.StyleSeasonYearID = @StyleSeasonYearID  ORDER BY  C.StyleColorNo,C.StyleColorName, A.StyleMaterialID, A.Sort  
   
 SELECT * FROM #pStyleColorwayArtwork  
 DROP TABLE #pStyleColorwayArtwork  
   
   
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03189', GetDate())

GO  
  
  
    