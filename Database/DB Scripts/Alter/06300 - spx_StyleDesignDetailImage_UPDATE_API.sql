/****** Object:  StoredProcedure [dbo].[spx_StyleDesignDetailImage_UPDATE_API]    Script Date: 09/18/2013 14:10:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDesignDetailImage_UPDATE_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDesignDetailImage_UPDATE_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleDesignDetailImage_UPDATE_API]    Script Date: 09/18/2013 14:10:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_StyleDesignDetailImage_UPDATE_API](
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@ImageId UNIQUEIDENTIFIER,
	@ImageVersion INT
)
AS
Declare @workflowid varchar(50)

Set @workflowid = '40000000-0000-0000-0000-000000000006'
BEGIN
	UPDATE pStyleImageItem SET ImageVersion=@ImageVersion 
	WHERE StyleID = @StyleID 
	AND StyleSet =  @StyleSet and
	WorkflowID = @workflowid 
	and ImageID = @ImageId

	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06300', GetDate())
GO