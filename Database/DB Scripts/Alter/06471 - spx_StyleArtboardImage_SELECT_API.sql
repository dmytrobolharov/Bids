/****** Object:  StoredProcedure [dbo].[spx_StyleArtboardImage_SELECT_API]    Script Date: 10/22/2013 10:45:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleArtboardImage_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleArtboardImage_SELECT_API]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleArtboardImage_SELECT_API]    Script Date: 10/22/2013 10:45:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE  [dbo].[spx_StyleArtboardImage_SELECT_API](
	@StyleID UNIQUEIDENTIFIER
)
AS
Declare @workflowid nvarchar(50)
DECLARE @DesignImageFrontID UNIQUEIDENTIFIER
DECLARE @DesignImageBackID UNIQUEIDENTIFIER
DECLARE @DesignImageFrontVersion INT
DECLARE @DesignImageBackVersion INT

SELECT 
@DesignImageFrontID =  ISNULL(DesignSketchID,'00000000-0000-0000-0000-000000000000'),
@DesignImageBackID = ISNULL(DesignSketchBackID,'00000000-0000-0000-0000-000000000000'), 
@DesignImageFrontVersion= ISNULL(DesignSketchVersion,0) , 
@DesignImageBackVersion = ISNULL(DesignSketchBackVersion,0) 
FROM dbo.pStyleHeader WHERE StyleID = @StyleID

Set @workflowid = '40000000-0000-0000-0000-000000000006'
BEGIN
	SELECT pStyleImageItem.StyleImageItemID,pStyleImageItem.ImageID,pStyleImageItem.ImageVersion, pimage.ImageFile, pImage.CDate,'Design Detail' as workflowtype, StyleSet FROM pStyleImageItem  WITH(NOLOCK) INNER JOIN 
	pImage ON pImage.ImageID = pStyleImageItem.ImageID
	WHERE StyleID = @StyleID 
	and	pStyleImageItem.WorkflowID = @workflowid 
	and pImage.ImageFileType = 'AI'
	UNION
	SELECT newid() as StyleImageItemID, ImageID,@DesignImageFrontVersion as ImageVersion, ImageFile, CDate, 'Design Image - Front' as workflowtype,'1' as StyleSet FROM pImage 
	WHERE ImageFileType = 'AI' and imageid = @DesignImageFrontID
	UNION
	SELECT newid() as StyleImageItemID, ImageID,@DesignImageBackVersion as ImageVersion, ImageFile, CDate, 'Design Image - Back' as workflowtype,'1' as StyleSet FROM pImage 
	WHERE ImageFileType = 'AI' and imageid = @DesignImageBackID
	ORDER BY CDate
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06471', GetDate())
GO
