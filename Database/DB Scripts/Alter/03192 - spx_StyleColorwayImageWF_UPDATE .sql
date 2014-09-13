IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayImageWF_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayImageWF_UPDATE]
GO


CREATE PROCEDURE spx_StyleColorwayImageWF_UPDATE  
(  
@StyleID UNIQUEIDENTIFIER ,  
@StyleColorID UNIQUEIDENTIFIER , 
@ImageID UNIQUEIDENTIFIER ,  
@ImageVersion INT ,  
@RecID INT ,  
@MUser nvarchar(200),  
@MDate datetime  
)  
AS  
  
IF @RecID = 1   
BEGIN  
 UPDATE dbo.pStyleColorwaySeasonYear SET DesignImageFrontID = @ImageID, DesignImageFrontVersion = @ImageVersion , MUser = @MUser , MDate = @MDate WHERE StyleColorwaySeasonYearID = @StyleColorID  
END  
  
IF @RecID = 2   
BEGIN  
 UPDATE dbo.pStyleColorwaySeasonYear SET DesignImageBackID = @ImageID, DesignImageBackVersion = @ImageVersion , MUser = @MUser , MDate = @MDate WHERE StyleColorwaySeasonYearID = @StyleColorID 
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03192', GetDate())

GO 