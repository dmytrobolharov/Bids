IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_FlashEdit_QuickFillItemTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFillItemTemp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFillItemTemp_INSERT]  ( 
	@QuickFillID uniqueidentifier, 
	@FieldName nvarchar(500),
	@FieldValue nvarchar(500),
	@TeamID uniqueidentifier
) 
AS

BEGIN 
	BEGIN
		INSERT INTO pPlanningFlashEditQuickFillItemTemp (QuickFillID, QuickFillFieldName, QuickFillFieldValue, TeamID) 
		VALUES (@QuickFillID, @FieldName, @FieldValue, @TeamID)
	END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06375', GetDate())
GO
