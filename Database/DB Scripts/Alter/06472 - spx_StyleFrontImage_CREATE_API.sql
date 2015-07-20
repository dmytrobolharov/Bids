/****** Object:  StoredProcedure [dbo].[spx_StyleFrontImage_CREATE_API]    Script Date: 10/22/2013 10:45:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFrontImage_CREATE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFrontImage_CREATE_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleFrontImage_CREATE_API]    Script Date: 10/22/2013 10:45:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE  [dbo].[spx_StyleFrontImage_CREATE_API](
	@StyleID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER,
	@ImageVersion INT
)
AS
Declare @workflowid nvarchar(50)


BEGIN
	UPDATE pStyleHeader SET DesignSketchVersion=@ImageVersion, DesignSketchID=@ImageID 
	WHERE StyleID = @StyleID 
	

	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06472', GetDate())
GO