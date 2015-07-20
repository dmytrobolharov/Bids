/****** Object:  StoredProcedure [dbo].[spx_StyleDesignDetailImage_SELECT_API]    Script Date: 11/18/2013 15:20:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDesignDetailImage_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDesignDetailImage_SELECT_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleDesignDetailImage_SELECT_API]    Script Date: 11/18/2013 15:20:41 ******/
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
DECLARE @Design INT

Set @workflowid = '40000000-0000-0000-0000-000000000006'
BEGIN
	SELECT pStyleImageItem.StyleImageItemID,pStyleImageItem.ImageID,pStyleImageItem.ImageVersion, pimage.ImageFile,'Design Detail' as workflowtype FROM pStyleImageItem  WITH(NOLOCK) INNER JOIN 
	pImage ON pImage.ImageID = pStyleImageItem.ImageID
	WHERE StyleID = @StyleID 
	AND StyleSet =  @StyleSet and
	pStyleImageItem.WorkflowID = @workflowid 
	and (pImage.ImageFileType = 'AI' or pImage.ImageType='ai')
	ORDER BY pImage.CDate
	
	select @Design=COUNT(*) from pstyleheader 
	inner join pWorkflowTemplateItem on pWorkflowTemplateItem.WorkflowTemplateID = pstyleheader.StyleWorkflowID
	where pWorkflowTemplateItem.WorkflowID='40000000-0000-0000-0000-000000000006' and pstyleheader.StyleID=@StyleID
	
	select  @Design as 'Design'
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06618', GetDate())
GO