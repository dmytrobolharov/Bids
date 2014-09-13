

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFill_SELECT]    Script Date: 03/27/2013 15:07:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_FlashEdit_QuickFill_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFill_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFill_SELECT]    Script Date: 03/27/2013 15:07:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFill_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
	,@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT qf.* FROM pFlashEditQuickFill qf
	INNER JOIN pLineFolderStyleCategory lfsc ON lfsc.StyleCategoryID = qf.StyleCategoryID AND lfsc.LineFolderID = @LineFolderID
	INNER JOIN pLineFolderStyleType lfst ON lfst.StyleTypeID = qf.StyleTypeID AND lfst.LineFolderID = @LineFolderID
	and qf.TeamID = @TeamID
	ORDER BY qf.MDate DESC
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05426', GetDate())
GO
