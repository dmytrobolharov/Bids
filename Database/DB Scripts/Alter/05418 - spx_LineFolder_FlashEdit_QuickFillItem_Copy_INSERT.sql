/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFillItem_Copy_INSERT]    Script Date: 03/27/2013 14:13:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_FlashEdit_QuickFillItem_Copy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFillItem_Copy_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFillItem_Copy_INSERT]    Script Date: 03/27/2013 14:13:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFillItem_Copy_INSERT]  ( 
	@TeamID UNIQUEIDENTIFIER,
	@QuickFillID UNIQUEIDENTIFIER
) 
AS

BEGIN
	   
	INSERT INTO pFlashEditQuickFillItem (QuickFillID,QuickFillFieldName,QuickFillFieldValue,TeamID) 
	SELECT QuickFillID, 
		   QuickFillFieldName, 
		   QuickFillFieldValue, 
		   TeamID 
	FROM pFlashEditQuickFillItemTemp WHERE TeamID = @TeamID AND QuickFillID = @QuickFillID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05418', GetDate())
GO
