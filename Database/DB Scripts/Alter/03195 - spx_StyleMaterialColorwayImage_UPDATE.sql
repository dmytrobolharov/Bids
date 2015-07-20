IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialColorwayImage_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialColorwayImage_UPDATE]
GO

CREATE PROCEDURE spx_StyleMaterialColorwayImage_UPDATE  
(     
@StyleID nvarchar(50),      
@StyleSet nvarchar(50),      
@ImageID nvarchar(50),    
@ImageVersion INT,  
@StyleMaterialID nvarchar(50),    
@MUser nvarchar(100),      
@MDate DATETIME,
@StyleSeasonYearID UNIQUEIDENTIFIER )      
AS   
  
  
BEGIN      
  UPDATE  dbo.pStyleColorwayArtwork      
  SET MaterialArtworkImageID = @ImageID , MaterialArtworkImageVersion = @ImageVersion, MDate = @MDate , MUser = @MUser    
  WHERE (StyleID = @StyleID) AND (StyleSet = @StyleSet) AND   (StyleMaterialID = @StyleMaterialID) AND StyleSeasonYearID = @StyleSeasonYearID
END  

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03195', GetDate())

GO   
  
