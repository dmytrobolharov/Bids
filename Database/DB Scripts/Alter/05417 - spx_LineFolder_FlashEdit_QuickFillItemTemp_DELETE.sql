/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFillItemTemp_DELETE]    Script Date: 03/27/2013 14:09:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_FlashEdit_QuickFillItemTemp_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFillItemTemp_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFillItemTemp_DELETE]    Script Date: 03/27/2013 14:09:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFillItemTemp_DELETE]
	@TeamID uniqueidentifier
AS

DELETE FROM pFlashEditQuickFillItemTemp 
WHERE TeamID = @TeamID 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05417', GetDate())
GO
