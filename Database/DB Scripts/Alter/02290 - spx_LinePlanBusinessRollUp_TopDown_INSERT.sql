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


IF EXISTS (select * from sysobjects where id = object_id('spx_LinePlanBusinessRollUp_TopDown_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_LinePlanBusinessRollUp_TopDown_INSERT
GO

CREATE PROCEDURE spx_LinePlanBusinessRollUp_TopDown_INSERT
(
	@LinePlanIndex varchar(1),
	@LinePlanId varchar(40),
	@LinePlanAttributeItemId1 varchar(40),
	@LinePlanAttributeItemId2 varchar(40) = NULL,
	@LinePlanAttributeItemId3 varchar(40) = NULL,
	@CUser nvarchar(200) = NULL, 
	@CDate datetime = NULL
)
AS 
BEGIN

	-- Clear out the previous records.
	IF @LinePlanIndex = '1'
	BEGIN

		DELETE FROM pLinePlanBusinessRollUp
		WHERE LinePlanID = @LinePlanId
		AND LinePlanAttributeItemID1 = @LinePlanAttributeItemId1
		AND LinePlanAttributeItemID2 IS NULL
		AND LinePlanAttributeItemID3 IS NULL

	END

	IF @LinePlanIndex = '2'
	BEGIN

		DELETE FROM pLinePlanBusinessRollUp
		WHERE LinePlanID = @LinePlanId
		AND LinePlanAttributeItemID1 = @LinePlanAttributeItemId1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemId2
		AND LinePlanAttributeItemID3 IS NULL

	END

	IF @LinePlanIndex = '3'
	BEGIN

		DELETE FROM pLinePlanBusinessRollUp
		WHERE LinePlanID = @LinePlanId
		AND LinePlanAttributeItemID1 = @LinePlanAttributeItemId1
		AND LinePlanAttributeItemID2 = @LinePlanAttributeItemId2
		AND LinePlanAttributeItemID3 = @LinePlanAttributeItemId3

	END


	IF @CUser IS NULL
	BEGIN
		SET @CUser = 'Administrator'
	END

	IF @CDate IS NULL
	BEGIN
		SET @CDate = GETUTCDATE()
	END


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

			INSERT INTO pLinePlanBusinessRollUp([LinePlanID], [LinePlanFinancialID], [LinePlanFinancialText], [LinePlanFinancialSort], 
				[LinePlanAttributeItemID1], [LinePlanAttributeItemID2], [LinePlanAttributeItemID3], 
				[LinePlanBusLYCh1], [LinePlanBusPnCh1], [LinePlanBusCuCh1], [LinePlanBusWpCh1], [CUser], [CDate], [MUser], [MDate])
			SELECT [LinePlanID], [LinePlanFinancialID], [LinePlanFinancialText], [LinePlanFinancialSort], 
				@LinePlanAttributeItemId1, @LinePlanAttributeItemId2, @LinePlanAttributeItemId3, 
				[LinePlanBusLYCh1], [LinePlanBusPnCh1], [LinePlanBusCuCh1], [LinePlanBusWpCh1], @CUser, @CDate, @CUser, @CDate 
			FROM @LPTable1and2

		END

		IF @LinePlanIndex = '2'
		BEGIN

			INSERT INTO @LPTable1and2
			EXEC spx_LinePlanBusinessRollUp2_SELECT @LinePlanIndex, @LinePlanId, @LinePlanAttributeItemId1, @LinePlanAttributeItemId2

			INSERT INTO pLinePlanBusinessRollUp([LinePlanID], [LinePlanFinancialID], [LinePlanFinancialText], [LinePlanFinancialSort], 
				[LinePlanAttributeItemID1], [LinePlanAttributeItemID2], [LinePlanAttributeItemID3], 
				[LinePlanBusLYCh1], [LinePlanBusPnCh1], [LinePlanBusCuCh1], [LinePlanBusWpCh1], [CUser], [CDate], [MUser], [MDate])
			SELECT [LinePlanID], [LinePlanFinancialID], [LinePlanFinancialText], [LinePlanFinancialSort], 
				@LinePlanAttributeItemId1, @LinePlanAttributeItemId2, @LinePlanAttributeItemId3, 
				[LinePlanBusLYCh1], [LinePlanBusPnCh1], [LinePlanBusCuCh1], [LinePlanBusWpCh1], @CUser, @CDate, @CUser, @CDate 
			FROM @LPTable1and2

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

		INSERT INTO pLinePlanBusinessRollUp([LinePlanID], [LinePlanFinancialID], [LinePlanFinancialText], [LinePlanFinancialSort], 
			[LinePlanAttributeItemID1], [LinePlanAttributeItemID2], [LinePlanAttributeItemID3], 
			[LinePlanBusLYCh1], [LinePlanBusLYCh2], [LinePlanBusLYCh3], [LinePlanBusLYCh4], 
			[LinePlanBusPnCh1], [LinePlanBusPnCh2], [LinePlanBusPnCh3], [LinePlanBusPnCh4], 
			[LinePlanBusCuCh1], [LinePlanBusCuCh2], [LinePlanBusCuCh3], [LinePlanBusCuCh4], 
			[CUser], [CDate], [MUser], [MDate])
		SELECT [LinePlanID], [LinePlanFinancialID], [LinePlanFinancialText], [LinePlanFinancialSort], 
			@LinePlanAttributeItemId1, @LinePlanAttributeItemId2, @LinePlanAttributeItemId3, 
			[LinePlanBusLYCh1], [LinePlanBusLYCh2], [LinePlanBusLYCh3], [LinePlanBusLYCh4], 
			[LinePlanBusPnCh1], [LinePlanBusPnCh2], [LinePlanBusPnCh3], [LinePlanBusPnCh4], 
			[LinePlanBusCuCh1], [LinePlanBusCuCh2], [LinePlanBusCuCh3], [LinePlanBusCuCh4], 
			@CUser, @CDate, @CUser, @CDate
		FROM @LPTable3

	END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '02290', GetDate())
GO

SET NOCOUNT Off
GO
