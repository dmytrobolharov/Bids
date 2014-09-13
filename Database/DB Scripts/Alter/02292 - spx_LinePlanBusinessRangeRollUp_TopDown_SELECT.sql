-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 30 November 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


IF EXISTS (select * from sysobjects where id = object_id('spx_LinePlanBusinessRangeRollUp_TopDown_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_LinePlanBusinessRangeRollUp_TopDown_SELECT
GO

CREATE PROCEDURE spx_LinePlanBusinessRangeRollUp_TopDown_SELECT
(
	@LinePlanIndex varchar(1),
	@LinePlanId varchar(40),
	@LinePlanAttributeItemId1 varchar(40),
	@LinePlanAttributeItemId2 varchar(40) = NULL,
	@LinePlanAttributeItemId3 varchar(40) = NULL
)
AS 
BEGIN

	IF @LinePlanIndex = '1' OR @LinePlanIndex = '2'
	BEGIN

		-- Create the temp table.
		DECLARE @LPTable1and2 AS Table (
			[LinePlanID] uniqueidentifier NULL,
			[LinePlanFinancialID] uniqueidentifier NULL,
			[LinePlanFinancialText] nvarchar(100) NULL,
			[LinePlanFinancialSort] varchar(5) NULL,
			[LinePlanAttributeItemID1] uniqueidentifier NULL,
			[LinePlanAttributeItemID2] uniqueidentifier NULL,
			[LinePlanAttributeItemID3] uniqueidentifier NULL,
			[LinePlanAttributeItemID4] uniqueidentifier NULL,
			[LinePlanFinancialDataType] varchar(50) NULL, 
			[LinePlanFinancialDataFormat] varchar(50) NULL, 
			[LinePlanFinancialCssClass] varchar(100) NULL,
			[LinePlanBusLYCh1] decimal(18, 3) NULL DEFAULT ((0)),
			[LinePlanBusPnCh1] decimal(18, 3) NULL DEFAULT ((0)),
			[LinePlanBusCuCh1] decimal(18, 3) NULL DEFAULT ((0)),
			[LinePlanBusWpCh1] decimal(18, 3) NULL DEFAULT ((0))
		)


		-- Insert the records from the correct stored procedure.
		IF @LinePlanIndex = '1'
		BEGIN

			INSERT INTO @LPTable1and2
			EXEC spx_LinePlanBusinessRollUp1_SELECT @LinePlanIndex, @LinePlanId, @LinePlanAttributeItemId1

			SELECT 
				lpbr.LinePlanBusinessRollUpID,
				lpbr.LinePlanID, 
				lpbr.LinePlanFinancialID, 
				lpf.LinePlanFinancialText, 
				lp.LinePlanFinancialSort, 
				lpbr.LinePlanAttributeItemID1, 
				lpbr.LinePlanAttributeItemID2, 
				lpbr.LinePlanAttributeItemID3, 
				lpbr.LinePlanAttributeItemID4, 
				lpf.LinePlanFinancialDataType, 
				lpf.LinePlanFinancialDataFormat, 
				lpf.LinePlanFinancialCssClass,
				lp.LinePlanBusLYCh1,
				lp.LinePlanBusPnCh1,
				lpbr.LinePlanBusTrCh1,
				lp.LinePlanBusCuCh1,
				lp.LinePlanBusWpCh1

			FROM @LPTable1and2 lp
				INNER JOIN pLinePlanBusinessRollUp lpbr ON lpbr.LinePlanID = @LinePlanId
					AND lpbr.LinePlanFinancialID = lp.LinePlanFinancialID
					AND lpbr.LinePlanAttributeItemID1 = @LinePlanAttributeItemId1
					AND lpbr.LinePlanAttributeItemID2 IS NULL
					AND lpbr.LinePlanAttributeItemID3 IS NULL
				INNER JOIN pLinePlanFinancial lpf ON lpbr.LinePlanFinancialID = lpf.LinePlanFinancialID

			WHERE ( (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004')
				OR (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000001')
				OR (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000003')
				OR (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000002') )

			ORDER BY lpbr.LinePlanFinancialSort

		END

		IF @LinePlanIndex = '2'
		BEGIN

			INSERT INTO @LPTable1and2
			EXEC spx_LinePlanBusinessRollUp2_SELECT @LinePlanIndex, @LinePlanId, @LinePlanAttributeItemId1, @LinePlanAttributeItemId2

			SELECT 
				lpbr.LinePlanBusinessRollUpID,
				lpbr.LinePlanID, 
				lpbr.LinePlanFinancialID, 
				lpf.LinePlanFinancialText, 
				lp.LinePlanFinancialSort, 
				lpbr.LinePlanAttributeItemID1, 
				lpbr.LinePlanAttributeItemID2, 
				lpbr.LinePlanAttributeItemID3, 
				lpbr.LinePlanAttributeItemID4, 
				lpf.LinePlanFinancialDataType, 
				lpf.LinePlanFinancialDataFormat, 
				lpf.LinePlanFinancialCssClass,
				lp.LinePlanBusLYCh1,
				lp.LinePlanBusPnCh1,
				lpbr.LinePlanBusTrCh1,
				lp.LinePlanBusCuCh1,
				lp.LinePlanBusWpCh1

			FROM @LPTable1and2 lp
				INNER JOIN pLinePlanBusinessRollUp lpbr ON lpbr.LinePlanID = @LinePlanId
					AND lpbr.LinePlanFinancialID = lp.LinePlanFinancialID
					AND lpbr.LinePlanAttributeItemID1 = @LinePlanAttributeItemId1
					AND lpbr.LinePlanAttributeItemID2 = @LinePlanAttributeItemId2
					AND lpbr.LinePlanAttributeItemID3 IS NULL
				INNER JOIN pLinePlanFinancial lpf ON lpbr.LinePlanFinancialID = lpf.LinePlanFinancialID

			WHERE ( (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004')
				OR (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000001')
				OR (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000003')
				OR (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000002') )

			ORDER BY lpbr.LinePlanFinancialSort

		END

	END


	IF @LinePlanIndex = '3'
	BEGIN

		-- Create the temp table.
		DECLARE @LPTable3 AS Table (
			[LinePlanID] uniqueidentifier NULL,
			[LinePlanFinancialID] uniqueidentifier NULL,
			[LinePlanFinancialText] nvarchar(100) NULL,
			[LinePlanFinancialSort] varchar(5) NULL,
			[LinePlanAttributeItemID1] uniqueidentifier NULL,
			[LinePlanAttributeItemID2] uniqueidentifier NULL,
			[LinePlanAttributeItemID3] uniqueidentifier NULL,
			[LinePlanAttributeItemID4] uniqueidentifier NULL,
			[LinePlanFinancialDataType] varchar(50) NULL, 
			[LinePlanFinancialDataFormat] varchar(50) NULL, 
			[LinePlanFinancialCssClass] varchar(100) NULL,
			[LinePlanBusLYCh1] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusLYCh2] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusLYCh3] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusLYCh4] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusPnCh1] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusPnCh2] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusPnCh3] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusPnCh4] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusCuCh1] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusCuCh2] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusCuCh3] [decimal](18, 3) NULL DEFAULT ((0)),
			[LinePlanBusCuCh4] [decimal](18, 3) NULL DEFAULT ((0))
		)

		-- Insert the records from the correct stored procedure.
		INSERT INTO @LPTable3
		EXEC spx_LinePlanBusinessRollUp3_SELECT @LinePlanIndex, @LinePlanId, @LinePlanAttributeItemId1, @LinePlanAttributeItemId2, @LinePlanAttributeItemId3

		SELECT 
			lpbr.LinePlanBusinessRollUpID,
			lpbr.LinePlanID, 
			lpbr.LinePlanFinancialID, 
			lpf.LinePlanFinancialText, 
			lp.LinePlanFinancialSort, 
			lpbr.LinePlanAttributeItemID1, 
			lpbr.LinePlanAttributeItemID2, 
			lpbr.LinePlanAttributeItemID3, 
			lpbr.LinePlanAttributeItemID4, 
			lpf.LinePlanFinancialDataType, 
			lpf.LinePlanFinancialDataFormat, 
			lpf.LinePlanFinancialCssClass,
			lp.LinePlanBusLYCh1,
			lp.LinePlanBusLYCh2,
			lp.LinePlanBusLYCh3,
			lp.LinePlanBusLYCh4,
			lp.LinePlanBusPnCh1,
			lp.LinePlanBusPnCh2,
			lp.LinePlanBusPnCh3,
			lp.LinePlanBusPnCh4,
			lpbr.LinePlanBusTrCh1,
			lpbr.LinePlanBusTrCh2,
			lpbr.LinePlanBusTrCh3,
			lpbr.LinePlanBusTrCh4,
			lp.LinePlanBusCuCh1,
			lp.LinePlanBusCuCh2,
			lp.LinePlanBusCuCh3,
			lp.LinePlanBusCuCh4,
			lpbr.LinePlanBusWpCh1,
			lpbr.LinePlanBusWpCh2,
			lpbr.LinePlanBusWpCh3,
			lpbr.LinePlanBusWpCh4

		FROM @LPTable3 lp
			INNER JOIN pLinePlanBusinessRollUp lpbr ON lpbr.LinePlanID = @LinePlanId
				AND lpbr.LinePlanFinancialID = lp.LinePlanFinancialID
				AND lpbr.LinePlanAttributeItemID1 = @LinePlanAttributeItemId1
				AND lpbr.LinePlanAttributeItemID2 = @LinePlanAttributeItemId2
				AND lpbr.LinePlanAttributeItemID3 = @LinePlanAttributeItemId3
			INNER JOIN pLinePlanFinancial lpf ON lpbr.LinePlanFinancialID = lpf.LinePlanFinancialID

		WHERE ( (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000004')
			OR (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000001')
			OR (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000003')
			OR (lpbr.LinePlanFinancialID = '10000000-0000-0000-0000-000000000002') )

		ORDER BY lpbr.LinePlanFinancialSort

	END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '02292', GetDate())
GO

SET NOCOUNT Off
GO
