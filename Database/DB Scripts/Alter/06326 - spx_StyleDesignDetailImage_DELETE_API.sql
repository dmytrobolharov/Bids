/****** Object:  StoredProcedure [dbo].[spx_StyleDesignDetailImage_DELETE_API]    Script Date: 09/20/2013 15:04:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDesignDetailImage_DELETE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDesignDetailImage_DELETE_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleDesignDetailImage_DELETE_API]    Script Date: 09/20/2013 15:04:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_StyleDesignDetailImage_DELETE_API](
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@ImageID UNIQUEIDENTIFIER
)
AS
Declare @workflowid nvarchar(50)

Set @workflowid = '40000000-0000-0000-0000-000000000006'
BEGIN
	DELETE FROM pStyleImageItem 
	WHERE StyleID = @StyleID 
	AND StyleSet =  @StyleSet 
	AND ImageID = @ImageID 
	AND WorkflowID = @workflowid

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06326', GetDate())
GO