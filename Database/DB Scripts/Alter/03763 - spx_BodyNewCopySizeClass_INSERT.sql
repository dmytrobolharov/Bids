IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BodyNewCopySizeClass_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BodyNewCopySizeClass_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_BodyNewCopySizeClass_INSERT](  
@BodyID UNIQUEIDENTIFIER,   
@NewBodyID UNIQUEIDENTIFIER,   
@CreatedDate DATETIME,   
@CreatedBy NVARCHAR(200),   
@SqlBodyHeaderUpdate NVARCHAR(4000)   
)  
AS  
  
  
  
BEGIN  
  
 DECLARE @SketchID UNIQUEIDENTIFIER  
 DECLARE @SketchVersion INT   
  
 SELECT @SketchID = ImageID, @SketchVersion = ImageVersion  
 FROM  pBody WHERE BodyID = @BodyID  
  
  
 EXEC dbo.spx_BodyHeaderCopy_INSERT @BodyID=@BodyID, @NewBodyID=@NewBodyID, @DesignSketchID=@SketchID,    
  @DesignSketchVersion=@SketchVersion, @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate  
   
 EXEC(@SqlBodyHeaderUpdate)  
  
 EXEC spx_BodyDevelopmentSpecVariation_INSERT @BodyID=@BodyID, @NewBodyID=@NewBodyID , @CreatedBy=@CreatedBy,  @CreatedDate=@CreatedDate  
  
  
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03763', GetDate())
GO
