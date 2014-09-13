IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlFlashCost_Duty_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ControlFlashCost_Duty_SELECT]
GO

-- Selects the pivoted data for Flash Cost Duty table in Control Panel

CREATE PROCEDURE [dbo].[spx_ControlFlashCost_Duty_SELECT]
	@FlashCostDutyID UNIQUEIDENTIFIER = NULL,
	@SizeClassList NVARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
	DECLARE @strSQL NVARCHAR(MAX)
	
	SELECT @SizeClassList = COALESCE(@SizeClassList + ',', '') + 
	CAST(CustomID AS VARCHAR(50))FROM pSizeClass
	WHERE Active = 1

	SET @SizeClassList = '[' + REPLACE(@SizeClassList, ',', '],[') + ']'
	
	-- Selecting data for given Duty Category
	IF @FlashCostDutyID IS NOT NULL
	BEGIN
		SET @strSQL = 
			'SELECT StyleCategoryID, StyleCategory, ' + @SizeClassList + ' 
			FROM
			(
			SELECT duty.StyleCategoryID, cat.StyleCategory, duty.SizeClassID, duty.CostDutyPercent
			FROM pFlashCostDutyItem duty LEFT JOIN pStyleCategory cat ON duty.StyleCategoryID = cat.StyleCategoryID
			WHERE duty.FlashCostDutyID = ''' + CAST(@FlashCostDutyID AS VARCHAR(40)) + ''' AND cat.Active = 1
			) tbl
			PIVOT
			(
			MAX(CostDutyPercent)
			FOR SizeClassID
			IN (' + @SizeClassList + ')
			) pvt
			ORDER BY StyleCategory'
	END
	ELSE
	BEGIN
		-- Selecting the empty list of costings for all Style Categories and Size Ranges
		SET @strSQL = 
			'SELECT StyleCategoryID, StyleCategory, ' + @SizeClassList + ' 
			FROM
			(
			SELECT cat.StyleCategoryID, cat.StyleCategory, ran.CustomID, 1 AS CostDutyPercent
			FROM pStyleCategory cat, pSizeRange ran WHERE cat.Active = 1
			) tbl
			PIVOT
			(
			MAX(CostDutyPercent)
			FOR CustomID
			IN (' + @SizeClassList + ')
			) pvt
			ORDER BY StyleCategory'
	END

	EXECUTE sp_executesql @strSql

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05398', GetDate())
GO