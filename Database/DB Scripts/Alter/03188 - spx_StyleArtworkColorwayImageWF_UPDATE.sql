IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleArtworkColorwayImageWF_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleArtworkColorwayImageWF_UPDATE]
GO



CREATE PROCEDURE spx_StyleArtworkColorwayImageWF_UPDATE
(    
@StyleID UNIQUEIDENTIFIER ,    
@StyleColorwayArtworkID UNIQUEIDENTIFIER ,   
@ImageID UNIQUEIDENTIFIER ,    
@ImageVersion INT ,    
@MUser nvarchar(200),    
@MDate datetime    
)    
AS    
    
   
BEGIN    
 UPDATE dbo.pStyleColorwayArtwork SET MaterialArtworkImageID = @ImageID, MaterialArtworkImageVersion = @ImageVersion , MUser = @MUser , MDate = @MDate WHERE StyleColorwayArtworkID = @StyleColorwayArtworkID    
END   


  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03188', GetDate())

GO    
     
    
