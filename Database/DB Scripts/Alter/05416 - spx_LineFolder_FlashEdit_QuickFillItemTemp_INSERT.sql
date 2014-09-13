/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFillItemTemp_INSERT]    Script Date: 03/27/2013 12:58:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_FlashEdit_QuickFillItemTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFillItemTemp_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolder_FlashEdit_QuickFillItemTemp_INSERT]    Script Date: 03/27/2013 12:58:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_FlashEdit_QuickFillItemTemp_INSERT]  ( 
	@QuickFillID uniqueidentifier, 
	@FieldName nvarchar(500),
	@FieldValue nvarchar(500),
	@TeamID uniqueidentifier
) 
AS

BEGIN 
	BEGIN
		INSERT INTO pFlashEditQuickFillItemTemp (QuickFillID, QuickFillFieldName, QuickFillFieldValue, TeamID) 
		VALUES (@QuickFillID, @FieldName, @FieldValue, @TeamID)
	END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05416', GetDate())
GO
