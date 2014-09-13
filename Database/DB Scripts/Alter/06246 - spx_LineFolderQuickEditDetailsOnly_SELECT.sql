/****** Object:  StoredProcedure [dbo].[spx_LineFolderQuickEditDetailsOnly_SELECT]    Script Date: 08/28/2013 10:58:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderQuickEditDetailsOnly_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderQuickEditDetailsOnly_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderQuickEditDetailsOnly_SELECT]    Script Date: 08/28/2013 10:58:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_LineFolderQuickEditDetailsOnly_SELECT]
(
    @QuickFillID uniqueidentifier
)

AS


SELECT QuickFillFieldName, QuickFillFieldValue FROM pFlashEditQuickFillItem where QuickFillID=@QuickFillID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06246', GetDate())
GO
