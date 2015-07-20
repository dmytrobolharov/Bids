/****** Object:  StoredProcedure [dbo].[spx_StyleBackImage_CREATE_API]    Script Date: 10/22/2013 10:46:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBackImage_CREATE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBackImage_CREATE_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBackImage_CREATE_API]    Script Date: 10/22/2013 10:46:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE  [dbo].[spx_StyleBackImage_CREATE_API](
	@StyleID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER,
	@ImageVersion INT
)
AS
Declare @workflowid nvarchar(50)


BEGIN
	UPDATE pStyleHeader SET DesignSketchBackVersion=@ImageVersion , DesignSketchBackID=@ImageID
	WHERE StyleID = @StyleID 
		
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06473', GetDate())
GO