IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_BOMDetails_SKU_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_BOMDetails_SKU_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_SourcingQuote_BOMDetails_SKU_UPDATE]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN

	-- Change Log
	DECLARE @ChangeManagement nVARCHAR(5) = (SELECT UPPER(RTRIM(LTRIM(AppSettingValue))) FROM sAppSetting WHERE AppSettingKey = 'ChangeManagementEnabled')	
	DECLARE @ChangeLog TABLE(
		ChangeTableID UNIQUEIDENTIFIER,
		ChangeTablePKID UNIQUEIDENTIFIER,
		ChangeFieldName NVARCHAR(200),
		ChangeFieldAlias NVARCHAR(200),
		ChangeBeforeValue NVARCHAR(200),
		ChangeAfterValue NVARCHAR(200),
		ChangeBeforeText NVARCHAR(4000),
		ChangeAfterText NVARCHAR(4000),
		ChangeSubject NVARCHAR(400),
		ChangeType INT
	)
	
	UPDATE sqbd SET sqbd.Quantity = skui.TotalUnits
	OUTPUT '8038A3FD-0580-422F-A3A6-895CA0223A81', @StyleQuoteItemID, 'Quantity',
		SUBSTRING(ISNULL('/' + deleted.ItemDim1Name, '') + ISNULL('/' + deleted.ItemDim2Name, '') + ISNULL('/' + deleted.ItemDim3Name, ''), 2, 2000) + ': Quantity', 
		deleted.Quantity, inserted.Quantity, deleted.Quantity, inserted.Quantity,
		'', 0
	INTO @ChangeLog(ChangeTableID, ChangeTablePKID, ChangeFieldName, ChangeFieldAlias, 
				ChangeBeforeValue, ChangeAfterValue, ChangeBeforeText, ChangeAfterText, 
				ChangeSubject, ChangeType)
	FROM pSourcingQuotationBOMDetails sqbd
	INNER JOIN pStyleQuoteItem sqi ON sqbd.StyleQuoteItemID = sqi.StyleQuoteItemID
	LEFT JOIN pStyleSKUItems skui ON sqi.StyleSKUItemID = skui.StyleSKUItemID 
		AND (sqbd.ItemDim1Id IN (skui.ItemDim1ID, skui.ItemDim2ID, skui.ItemDim3ID) OR sqbd.ItemDim1Id IS NULL)
		AND (sqbd.ItemDim2Id IN (skui.ItemDim1ID, skui.ItemDim2ID, skui.ItemDim3ID) OR sqbd.ItemDim2Id IS NULL)
		AND (sqbd.ItemDim3Id IN (skui.ItemDim1ID, skui.ItemDim2ID, skui.ItemDim3ID) OR sqbd.ItemDim3Id IS NULL)
	WHERE sqbd.StyleQuoteItemID = @StyleQuoteItemID AND sqbd.Quantity <> skui.TotalUnits
	
	SELECT * FROM @ChangeLog WHERE @ChangeManagement = 'TRUE'
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08205', GetDate())
GO
