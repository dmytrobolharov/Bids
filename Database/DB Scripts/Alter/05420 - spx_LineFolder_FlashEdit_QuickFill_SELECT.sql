/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFill_SELECT]    Script Date: 03/27/2013 16:06:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_FlashEdit_QuickFill_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFill_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFill_SELECT]    Script Date: 03/27/2013 16:06:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFill_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT qf.* FROM pFlashEditQuickFill qf
	INNER JOIN pLineFolderStyleCategory lfsc ON lfsc.StyleCategoryID = qf.StyleCategoryID AND lfsc.LineFolderID = @LineFolderID
	INNER JOIN pLineFolderStyleType lfst ON lfst.StyleTypeID = qf.StyleTypeID AND lfst.LineFolderID = @LineFolderID
	ORDER BY qf.MDate DESC
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05420', GetDate())
GO
