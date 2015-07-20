/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFill_DELETE]    Script Date: 03/27/2013 14:55:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_FlashEdit_QuickFill_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFill_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFill_DELETE]    Script Date: 03/27/2013 14:55:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFill_DELETE]
	@QuickFillID UNIQUEIDENTIFIER
AS
BEGIN
	DELETE FROM pFlashEditQuickFill WHERE QuickFillID = @QuickFillID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05419', GetDate())
GO
