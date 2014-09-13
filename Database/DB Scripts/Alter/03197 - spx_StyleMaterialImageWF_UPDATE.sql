IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialImageWF_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialImageWF_UPDATE]
GO


CREATE PROCEDURE spx_StyleMaterialImageWF_UPDATE
(    
@StyleID UNIQUEIDENTIFIER ,    
@StyleMaterialID UNIQUEIDENTIFIER ,   
@ImageID UNIQUEIDENTIFIER ,    
@ImageVersion INT ,    
@MUser nvarchar(200),    
@MDate datetime    
)    
AS    
    
   
BEGIN    
 UPDATE dbo.pStyleMaterials SET MaterialImageID = @ImageID, MaterialImageVersion = @ImageVersion , MUser = @MUser , MDate = @MDate WHERE StyleMaterialID = @StyleMaterialID    
END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03197', GetDate())

GO      
    
