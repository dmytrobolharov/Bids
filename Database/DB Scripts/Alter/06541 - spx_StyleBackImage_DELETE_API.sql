/****** Object:  StoredProcedure [dbo].[spx_StyleBackImage_DELETE_API]    Script Date: 11/07/2013 13:07:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBackImage_DELETE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBackImage_DELETE_API]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBackImage_DELETE_API]    Script Date: 11/07/2013 13:07:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_StyleBackImage_DELETE_API](
	@StyleID UNIQUEIDENTIFIER
)
AS
Declare @workflowid nvarchar(50)


BEGIN
	UPDATE pStyleHeader SET DesignSketchBackVersion=0, DesignSketchBackID='00000000-0000-0000-0000-000000000000'
	WHERE StyleID = @StyleID 
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06541', GetDate())
GO