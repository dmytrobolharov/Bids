
/****** Object:  StoredProcedure [dbo].[spx_ControlFlashCost_Duty_CHECK_INSERT]    Script Date: 12/13/2012 15:56:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlFlashCost_Duty_CHECK_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlFlashCost_Duty_CHECK_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ControlFlashCost_Duty_CHECK_INSERT]    Script Date: 12/13/2012 15:56:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ControlFlashCost_Duty_CHECK_INSERT]
	@FlashCostDutyID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO pFlashCostDutyItem
	(StyleCategoryID, SizeClassID, FlashCostDutyID, CostDutyPercent)
	SELECT StyleCategoryID, CustomID, @FlashCostDutyID, NULL
	FROM pStyleCategory scid, pSizeClass sizecl
	WHERE NOT EXISTS(SELECT * FROM pFlashCostDutyItem 
				WHERE StyleCategoryId = scid.StyleCategoryId 
				AND SizeClassID = sizecl.CustomID
				AND FlashCostDutyID = @FlashCostDutyID)


END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04618', GetDate())
GO
