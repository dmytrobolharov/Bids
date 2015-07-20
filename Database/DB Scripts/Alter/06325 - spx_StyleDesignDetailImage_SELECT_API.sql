/****** Object:  StoredProcedure [dbo].[spx_StyleDesignDetailImage_SELECT_API]    Script Date: 09/20/2013 15:03:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDesignDetailImage_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDesignDetailImage_SELECT_API]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleDesignDetailImage_SELECT_API]    Script Date: 09/20/2013 15:03:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[spx_StyleDesignDetailImage_SELECT_API](
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT
)
AS
Declare @workflowid varchar(50)

Set @workflowid = '40000000-0000-0000-0000-000000000006'
BEGIN
	SELECT pStyleImageItem.StyleImageItemID,pStyleImageItem.ImageID,pStyleImageItem.ImageVersion, pimage.ImageFile FROM pStyleImageItem  WITH(NOLOCK) INNER JOIN 
	pImage ON pImage.ImageID = pStyleImageItem.ImageID
	WHERE StyleID = @StyleID 
	AND StyleSet =  @StyleSet and
	pStyleImageItem.WorkflowID = @workflowid 
	and pImage.ImageFileType = 'AI'
	ORDER BY pImage.CDate
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06325', GetDate())
GO