IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayImage_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayImage_UPDATE]
GO


CREATE PROCEDURE spx_StyleColorwayImage_UPDATE
(   
@StyleID nvarchar(50),    
@StyleSet nvarchar(50),    
@ImageID nvarchar(50),  
@ImageVersion INT,
@Rec_ID INT,  
@MUser nvarchar(100),    
@MDate DATETIME,
@StyleSeasonYearID UNIQUEIDENTIFIER 
)    
AS 

IF @Rec_ID = 1 
BEGIN    
  UPDATE  dbo.pStyleColorwaySeasonYear    
  SET DesignImageFrontID = @ImageID , DesignImageFrontVersion = @ImageVersion, MDate = @MDate , MUser = @MUser  
  WHERE (StyleID = @StyleID)  AND StyleSeasonYearID= @StyleSeasonYearID
END

IF @Rec_ID = 2
BEGIN
  UPDATE  dbo.pStyleColorwaySeasonYear    
  SET DesignImageBackID = @ImageID , DesignImageBackVersion = @ImageVersion, MDate = @MDate , MUser = @MUser  
  WHERE (StyleID = @StyleID)  AND StyleSeasonYearID = @StyleSeasonYearID
END

  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03191', GetDate())

GO    
    