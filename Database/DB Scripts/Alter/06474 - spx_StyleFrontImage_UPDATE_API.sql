/****** Object:  StoredProcedure [dbo].[spx_StyleFrontImage_UPDATE_API]    Script Date: 10/22/2013 10:47:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleFrontImage_UPDATE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleFrontImage_UPDATE_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleFrontImage_UPDATE_API]    Script Date: 10/22/2013 10:47:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



Create PROCEDURE  [dbo].[spx_StyleFrontImage_UPDATE_API](
	@StyleID UNIQUEIDENTIFIER,
	@ImageVersion INT
)
AS
Declare @workflowid nvarchar(50)


BEGIN
	UPDATE pStyleHeader SET DesignSketchVersion=@ImageVersion 
	WHERE StyleID = @StyleID 


	
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06474', GetDate())
GO