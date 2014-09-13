/****** Object:  StoredProcedure [dbo].[spx_LineListCostingLogic_FromFlashEdit_UPDATE]    Script Date: 12/14/2012 16:00:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListCostingLogic_FromFlashEdit_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListCostingLogic_FromFlashEdit_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineListCostingLogic_FromFlashEdit_UPDATE]    Script Date: 12/14/2012 16:00:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_LineListCostingLogic_FromFlashEdit_UPDATE](
	@LineFolderItemId UNIQUEIDENTIFIER,
	@FixedMU INT = 0
)
AS 
BEGIN

	DECLARE @ConsRat NUMERIC(18, 4)
	DECLARE @VolumePrice NUMERIC(18, 4)
	DECLARE @LaborCost NUMERIC(18, 4)
	DECLARE @AddedCost NUMERIC(18,4)
	DECLARE @FlashCostFOB NUMERIC(18,4)
	DECLARE @FlashCostLDP NUMERIC(18,6)
	DECLARE @Variance NUMERIC(18,6)
	DECLARE @WMarkup NUMERIC(18,6)
	DECLARE @RMarkup NUMERIC(18,6)
	DECLARE @WPrice NUMERIC(18,4)
	DECLARE @RPrice NUMERIC(18,4)
	DECLARE @DutyCategoryID UNIQUEIDENTIFIER
	DECLARE @DutyPerc NUMERIC(18,6)
	DECLARE @Duty NUMERIC(18,4)
	
	select @ConsRat = ConsumptionRatios from sConsumptionLabor INNER JOIN vwx_LineListFlashCosting_SELECT ON sConsumptionLabor.StyleCategoryID=vwx_LineListFlashCosting_SELECT.StyleCategoryID AND sConsumptionLabor.SizeClass=vwx_LineListFlashCosting_SELECT.SizeClass where vwx_LineListFlashCosting_SELECT.LineFolderItemId=@LineFolderItemId
	select @VolumePrice = VolumePrice from pMaterial inner join pLineListFlashCosting on pMaterial.MaterialID=pLineListFlashCosting.MaterialID where pLineListFlashCosting.LineFolderItemId=@LineFolderItemId
	select @LaborCost = LaborCosts from sConsumptionLabor INNER JOIN vwx_LineListFlashCosting_SELECT ON sConsumptionLabor.StyleCategoryID=vwx_LineListFlashCosting_SELECT.StyleCategoryID AND sConsumptionLabor.SizeClass=vwx_LineListFlashCosting_SELECT.SizeClass where vwx_LineListFlashCosting_SELECT.LineFolderItemId=@LineFolderItemId	
	select @AddedCost = AddedCost from vwx_LineListFlashCosting_SELECT where vwx_LineListFlashCosting_SELECT.LineFolderItemId=@LineFolderItemId
	select @Variance = Variance from vwx_LineListFlashCosting_SELECT where vwx_LineListFlashCosting_SELECT.LineFolderItemId=@LineFolderItemId
	SELECT @DutyCategoryID = ISNULL(Z, '00000000-0000-0000-0000-000000000000') from pMaterial inner join pLineListFlashCosting on pMaterial.MaterialID=pLineListFlashCosting.MaterialID where pLineListFlashCosting.LineFolderItemId=@LineFolderItemId
	SELECT @DutyPerc = CostDutyPercent 
	FROM pFlashCostDutyItem 
	INNER JOIN vwx_LineListFlashCosting_SELECT ON pFlashCostDutyItem.StyleCategoryID=vwx_LineListFlashCosting_SELECT.StyleCategoryID 
	INNER JOIN pSizeClass ON pFlashCostDutyItem.SizeClassID=pSizeClass.CustomID AND vwx_LineListFlashCosting_SELECT.SizeClass = pSizeClass.Custom
	WHERE vwx_LineListFlashCosting_SELECT.LineFolderItemId=@LineFolderItemId
	AND pFlashCostDutyItem.FlashCostDutyID = @DutyCategoryID
	
	SET @FlashCostFOB = ISNULL(@ConsRat,0)*ISNULL(@VolumePrice,0)+@LaborCost+@AddedCost
	SET @Duty = @DutyPerc * @FlashCostFOB
	SET @FlashCostLDP = @FlashCostFOB + @Duty +	(@FlashCostFOB * @Variance)

	UPDATE
		pLineListFlashCosting
	SET
		MaterialCost=ISNULL(@ConsRat,0)*ISNULL(@VolumePrice,0),
		LaborCost=@LaborCost,
		FlashCostFOB=@FlashCostFOB,
		DutyCategory = @DutyCategoryID,
		DutyP = @DutyPerc,
		Duty = @Duty,
		FlashCostLDP = @FlashCostLDP
	WHERE
		LineFolderItemID = @LineFolderItemId
	
	IF @FixedMU=0
		BEGIN
			select @WMarkup = WholesaleMU from vwx_LineListFlashCosting_SELECT where vwx_LineListFlashCosting_SELECT.LineFolderItemId=@LineFolderItemId
			select @RMarkup = RetailMU from vwx_LineListFlashCosting_SELECT where vwx_LineListFlashCosting_SELECT.LineFolderItemId=@LineFolderItemId
			UPDATE
				pLineListFlashCosting
			SET
				WholesalePrice=@FlashCostLDP*(1+@WMarkup),
				RetailPrice=@FlashCostLDP*(1+@RMarkup)
			WHERE
				LineFolderItemID = @LineFolderItemId
		END
	ELSE
		BEGIN
			select @WPrice = WholesalePrice from vwx_LineListFlashCosting_SELECT where vwx_LineListFlashCosting_SELECT.LineFolderItemId=@LineFolderItemId
			select @RPrice = RetailPrice from vwx_LineListFlashCosting_SELECT where vwx_LineListFlashCosting_SELECT.LineFolderItemId=@LineFolderItemId
			IF @WPrice<>0
				UPDATE pLineListFlashCosting SET WholesaleMU=(@WPrice/@FlashCostLDP)-1 WHERE LineFolderItemID = @LineFolderItemId
			ELSE
				UPDATE pLineListFlashCosting SET WholesaleMU=0 WHERE LineFolderItemID = @LineFolderItemId
			IF @RPrice<>0
				UPDATE pLineListFlashCosting SET RetailMU=(@RPrice/@FlashCostLDP)-1 WHERE LineFolderItemID = @LineFolderItemId	
			ELSE
				UPDATE pLineListFlashCosting SET RetailMU=0 WHERE LineFolderItemID = @LineFolderItemId	
		END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04637', GetDate())
GO
