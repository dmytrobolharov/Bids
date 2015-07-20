/****** Object:  StoredProcedure [dbo].[spx_ControlFlashCost_Duty_UPDATE]    Script Date: 12/13/2012 17:04:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlFlashCost_Duty_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlFlashCost_Duty_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_ControlFlashCost_Duty_UPDATE]    Script Date: 12/13/2012 17:04:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ControlFlashCost_Duty_UPDATE]
	@FlashCostDutyID UNIQUEIDENTIFIER,
	@StyleCategoryID UNIQUEIDENTIFIER,
	@SizeClassID UNIQUEIDENTIFIER,
	@NewCostDutyPercent NUMERIC(18, 6),
	@MUser NVARCHAR(200),
	@MDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF EXISTS(SELECT FlashCostDutyItemID FROM pFlashCostDutyItem WHERE FlashCostDutyID = @FlashCostDutyID
				AND StyleCategoryID = @StyleCategoryID
				AND SizeClassID = @SizeClassID)
	BEGIN
		UPDATE pFlashCostDutyItem
		SET CostDutyPercent = @NewCostDutyPercent,
		MUser = @MUser,
		MDate = @MDate
		WHERE FlashCostDutyID = @FlashCostDutyID
		AND StyleCategoryID = @StyleCategoryID
		AND SizeClassID = @SizeClassID
	END
	ELSE
	BEGIN
		INSERT INTO pFlashCostDutyItem (CostDutyPercent, FlashCostDutyID, StyleCategoryID, SizeClassID, MDate, MUser)
		VALUES (@NewCostDutyPercent, @FlashCostDutyID, @StyleCategoryID, @SizeClassID, @MDate, @MUser)
	END
    
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04620', GetDate())
GO
