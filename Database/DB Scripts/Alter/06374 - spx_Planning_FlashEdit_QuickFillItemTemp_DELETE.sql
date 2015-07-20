IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_FlashEdit_QuickFillItemTemp_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFillItemTemp_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFillItemTemp_DELETE]
	@TeamID uniqueidentifier
AS

DELETE FROM pPlanningFlashEditQuickFillItemTemp 
WHERE TeamID = @TeamID 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06374', GetDate())
GO
