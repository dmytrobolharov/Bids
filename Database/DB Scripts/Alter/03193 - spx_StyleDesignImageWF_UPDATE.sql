IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDesignImageWF_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDesignImageWF_UPDATE]
GO


CREATE PROCEDURE spx_StyleDesignImageWF_UPDATE
(
@StyleID UNIQUEIDENTIFIER ,
@ImageID UNIQUEIDENTIFIER ,
@ImageVersion INT ,
@RecID INT ,
@MUser nvarchar(200),
@MDate datetime
)
AS

IF @RecID = 1 
BEGIN
 UPDATE dbo.pStyleHeader SET DesignSketchID = @ImageID, DesignSketchVersion = @ImageVersion , MUser = @MUser , MDate = @MDate WHERE StyleID = @StyleID
END

IF @RecID = 2 
BEGIN
 UPDATE dbo.pStyleHeader SET DesignSketchBackID = @ImageID, DesignSketchBackVersion = @ImageVersion , MUser = @MUser , MDate = @MDate WHERE StyleID = @StyleID
END

  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03193', GetDate())

GO   