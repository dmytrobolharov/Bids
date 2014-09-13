/****** Object:  StoredProcedure [dbo].[spx_LineFolderQuickEditDetails_SELECT]    Script Date: 08/21/2013 11:29:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderQuickEditDetails_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderQuickEditDetails_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderQuickEditDetails_SELECT]    Script Date: 08/21/2013 11:29:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_LineFolderQuickEditDetails_SELECT]
(
    @QuickFillID uniqueidentifier
)

AS

SELECT * FROM pFlashEditQuickFill where QuickFillID=@QuickFillID
SELECT QuickFillFieldName, QuickFillFieldValue FROM pFlashEditQuickFillItem where QuickFillID=@QuickFillID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06193', GetDate())
GO