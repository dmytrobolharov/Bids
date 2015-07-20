IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_FlashEdit_QuickFillItem_Copy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFillItem_Copy_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFillItem_Copy_INSERT]  ( 
	@TeamID UNIQUEIDENTIFIER,
	@QuickFillID UNIQUEIDENTIFIER
) 
AS

BEGIN
	   
	INSERT INTO pPlanningFlashEditQuickFillItem (QuickFillID,QuickFillFieldName,QuickFillFieldValue,TeamID) 
	SELECT QuickFillID, 
		   QuickFillFieldName, 
		   QuickFillFieldValue, 
		   TeamID 
	FROM pPlanningFlashEditQuickFillItemTemp WHERE TeamID = @TeamID AND QuickFillID = @QuickFillID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06372', GetDate())
GO
