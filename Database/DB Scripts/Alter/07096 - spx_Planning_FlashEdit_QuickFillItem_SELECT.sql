IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_FlashEdit_QuickFillItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFillItem_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFillItem_SELECT]
	@QuickFillID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT QuickFillFieldName, QuickFillFieldValue FROM pPlanningFlashEditQuickFillItem
	WHERE QuickFillID = @QuickFillID
	UNION
	SELECT QuickFillFieldName, QuickFillFieldValue FROM pFlashEditQuickFillItem
	WHERE QuickFillID = @QuickFillID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07096', GetDate())
GO
