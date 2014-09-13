/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFillItem_SELECT]    Script Date: 03/27/2013 16:28:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_FlashEdit_QuickFillItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFillItem_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFillItem_SELECT]    Script Date: 03/27/2013 16:28:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFillItem_SELECT]
	@QuickFillID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT QuickFillFieldName, QuickFillFieldValue FROM pFlashEditQuickFillItem
	WHERE QuickFillID = @QuickFillID
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05421', GetDate())
GO
