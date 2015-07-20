/****** Object:  StoredProcedure [dbo].[spx_ControlFlashCost_Duty_Unique_CHECK]    Script Date: 12/13/2012 18:01:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlFlashCost_Duty_Unique_CHECK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlFlashCost_Duty_Unique_CHECK]
GO

/****** Object:  StoredProcedure [dbo].[spx_ControlFlashCost_Duty_Unique_CHECK]    Script Date: 12/13/2012 18:01:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ControlFlashCost_Duty_Unique_CHECK]
	@DutyCategoryCode NVARCHAR(100),
	@DutyCategoryName NVARCHAR(200),
	@CheckedDutyCategoryID UNIQUEIDENTIFIER = NULL,
	@ErrorMessage NVARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
	IF @CheckedDutyCategoryID IS NOT NULL
	BEGIN
		IF EXISTS (SELECT FlashCostDutyID FROM pFlashCostDuty
					WHERE DutyCategoryCode = @DutyCategoryCode
					AND FlashCostDutyID <> @CheckedDutyCategoryID)
		BEGIN
			SET @ErrorMessage = 'Duty Category Code must be unique!'
		END
		ELSE IF EXISTS (SELECT FlashCostDutyID FROM pFlashCostDuty
					WHERE DutyCategoryName = @DutyCategoryName
					AND FlashCostDutyID <> @CheckedDutyCategoryID)
		BEGIN
			SET @ErrorMessage = 'Duty Category Name must be unique!'
		END
	END
	ELSE
	BEGIN
			IF EXISTS (SELECT FlashCostDutyID FROM pFlashCostDuty
					WHERE DutyCategoryCode = @DutyCategoryCode)
		BEGIN
			SET @ErrorMessage = 'Duty Category Code must be unique!'
		END
		ELSE IF EXISTS (SELECT FlashCostDutyID FROM pFlashCostDuty
					WHERE DutyCategoryName = @DutyCategoryName)
		BEGIN
			SET @ErrorMessage = 'Duty Category Name must be unique!'
		END
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04621', GetDate())
GO
