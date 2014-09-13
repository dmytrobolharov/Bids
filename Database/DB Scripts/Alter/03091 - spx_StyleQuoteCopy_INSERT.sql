IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteCopy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteCopy_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleQuoteCopy_INSERT]
(
@StyleID uniqueidentifier,
@NewStyleID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS 


DECLARE @StyleDevelopmentID 	uniqueidentifier
DECLARE @NewStyleQuoteID 	uniqueidentifier
DECLARE @NewStyleDevelopmentID 	uniqueidentifier
DECLARE @TradePartnerId 	uniqueidentifier

	SELECT @StyleDevelopmentID = DevelopmentID FROM pStyleHeader WHERE StyleId = @StyleId
	SELECT @NewStyleDevelopmentID = DevelopmentID FROM pStyleHeader WHERE StyleId = @NewStyleId

	CREATE TABLE [#tempStyleQuote] ( 
	[RecID]				int IDENTITY(1,1)  NOT NULL,
	[StyleQuoteID]			uniqueidentifier NULL,
	[StyleDevelopmentID]    	uniqueidentifier NULL,
	[StyleID]               	uniqueidentifier NULL,
	)


	CREATE TABLE [#StyleQuoteVariation] (
		[RecID]	int IDENTITY(1,1)  NOT NULL,	
		[StyleQuoteVariationID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
		[StyleQuoteID] [uniqueidentifier] NULL,
		[StyleDevelopmentID] [uniqueidentifier] NULL,
		[StyleID] [uniqueidentifier] NULL,
		[TradePartnerID] [uniqueidentifier] NULL,
		[TeamComment] [nvarchar](4000) NULL,
		[PartnerComment] [nvarchar](4000) NULL,
		[PdfFileId] [uniqueidentifier] NULL,
		[PdfUser] [nvarchar](200) NULL,
		[PdfDate] [datetime] NULL,
		[StyleQuoteTradePartnerID] [uniqueidentifier] NULL,
		[StyleQuotaDutyID] [uniqueidentifier] NULL,
		[StyleCostingID] [uniqueidentifier] NULL,
		[StyleCostingType] [int] NULL,
		[StyleCostingDate] [datetime] NULL,
		[StyleCostingStatus] [nvarchar](200) NULL,
		[StyleCostingFreightTypeID] [int] NULL,
		[StyleQuoteItemCustomField1] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField2] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField3] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField4] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField5] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField6] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField7] [decimal](18, 5) NULL,
		[StyleQuoteItemCustomField8] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField9] [decimal](18, 5) NULL,
		[StyleQuoteItemCustomField10] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField11] [decimal](18, 5) NULL,
		[StyleQuoteItemCustomField12] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField13] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField14] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField15] [decimal](18, 5) NULL,
		[StyleQuoteItemCustomField16] [int] NULL,
		[StyleQuoteItemCustomField17] [decimal](18, 5) NULL,
		[StyleQuoteItemCustomField18] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField19] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField20] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField21] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField22] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField23] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField24] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField25] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField26] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField27] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField28] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField29] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField30] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField31] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField32] [decimal](18, 5) NULL,
		[StyleQuoteItemCustomField33] [decimal](18, 3) NULL,
		[StyleQuoteItemCustomField34] [nvarchar](200) NULL,
		[StyleQuoteItemCustomField35] [nvarchar](200) NULL,
		[StyleCostingCustomField1] [decimal](18, 3) NULL,
		[StyleCostingCustomField2] [decimal](18, 3) NULL,
		[StyleCostingCustomField3] [int] NULL,
		[StyleCostingCustomField4] [int] NULL,
		[StyleCostingCustomField5] [int] NULL,
		[StyleCostingCustomField6] [decimal](18, 3) NULL,
		[StyleCostingCustomField7] [decimal](18, 5) NULL,
		[StyleCostingCustomField8] [decimal](18, 3) NULL,
		[StyleCostingCustomField9] [decimal](18, 5) NULL,
		[StyleCostingCustomField10] [decimal](18, 3) NULL,
		[StyleCostingCustomField11] [decimal](18, 5) NULL,
		[StyleCostingCustomField12] [decimal](18, 3) NULL,
		[StyleCostingCustomField13] [decimal](18, 3) NULL,
		[StyleCostingCustomField14] [decimal](18, 3) NULL,
		[StyleCostingCustomField15] [decimal](18, 3) NULL,
		[StyleCostingCustomField16] [decimal](18, 3) NULL,
		[StyleCostingCustomField17] [datetime] NULL,
		[StyleCostingCustomField18] [decimal](18, 3) NULL,
		[StyleCostingCustomField19] [decimal](18, 3) NULL,
		[StyleCostingCustomField20] [decimal](18, 3) NULL,
		[StyleCostingCustomField21] [decimal](18, 3) NULL,
		[StyleCostingCustomField22] [decimal](18, 3) NULL,
		[StyleCostingCustomField23] [decimal](18, 3) NULL,
		[StyleCostingCustomField24] [decimal](18, 3) NULL,
		[StyleCostingCustomField25] [varchar](50) NULL,
		[StyleCostingCustomField26] [varchar](50) NULL,
		[StyleCostingCustomField27] [varchar](50) NULL,
		[StyleCostingCustomField28] [varchar](50) NULL,
		[StyleCostingCustomField29] [varchar](50) NULL,
		[StyleCostingCustomField30] [varchar](50) NULL,
		[StyleCostingCustomField31] [varchar](50) NULL,
		[StyleCostingCustomField32] [varchar](50) NULL,
		[StyleCostingCustomField33] [varchar](50) NULL,
		[StyleCostingCustomField34] [varchar](50) NULL,
		[StyleCostingCustomField35] [varchar](50) NULL,
		[CUser] [nvarchar](200) NULL,
		[CDate] [datetime] NULL,
		[MUser] [nvarchar](200) NULL,
		[MDate] [datetime] NULL,
		[StyleSeasonYearID] [uniqueidentifier] NULL
	)



	BEGIN
		INSERT INTO pStyleQuote
			(StyleDevelopmentID, StyleQuoteType, StyleQuoteStartDate, StyleQuoteDueDate, TradePartnerID, StyleQuoteStatus, 
			StyleQuoteField1, StyleQuoteField2, StyleQuoteField3, StyleQuoteField4, StyleQuoteField5, StyleQuoteField6, StyleQuoteField7, StyleQuoteField8, 
			StyleQuoteField9, StyleQuoteField10, CUser, CDate, MUser, MDate)
		SELECT @NewStyleDevelopmentID AS StyleDevelopmentId, StyleQuoteType, StyleQuoteStartDate, 
			StyleQuoteDueDate, TradePartnerID, StyleQuoteStatus, StyleQuoteField1, StyleQuoteField2, StyleQuoteField3, StyleQuoteField4, StyleQuoteField5, 
			StyleQuoteField6, StyleQuoteField7, StyleQuoteField8, StyleQuoteField9, StyleQuoteField10, @CreatedBy AS CUser, @CreatedDate AS CDate, 
			@CreatedBy AS MUser, @CreatedDate AS MDate
		FROM  pStyleQuote WHERE  StyleDevelopmentID = @StyleDevelopmentID
	END

	BEGIN
		INSERT INTO #tempStyleQuote
			(StyleQuoteID, StyleDevelopmentID)
		SELECT StyleQuoteID, StyleDevelopmentID 
			FROM pStyleQuote 
		WHERE StyleDevelopmentID = @NewStyleDevelopmentID
	END

	BEGIN


		INSERT INTO #StyleQuoteVariation
			(StyleQuoteVariationID, StyleQuoteID, StyleDevelopmentID, StyleID, TradePartnerID, TeamComment, PartnerComment, PdfFileId, PdfUser, PdfDate, 
			StyleQuoteTradePartnerID, StyleQuotaDutyID, StyleCostingID, StyleCostingType, StyleCostingDate, StyleCostingStatus, StyleCostingFreightTypeID, 
			StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, 
			StyleQuoteItemCustomField6, StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, StyleQuoteItemCustomField9, 
			StyleQuoteItemCustomField10, StyleQuoteItemCustomField11, StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, 
			StyleQuoteItemCustomField14, StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, 
			StyleQuoteItemCustomField18, StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, StyleQuoteItemCustomField21, 
			StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, StyleQuoteItemCustomField25, 
			StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
			StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, 
			StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
			StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, 
			StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
			StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
			StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, CUser, 
			CDate, MUser, MDate, StyleSeasonYearID)
		SELECT  newid() AS StyleQuoteVariationID, @NewStyleQuoteID AS StyleQuoteId, @NewStyleDevelopmentID AS StyleDevelopmentId, @NewStyleID AS StyleId, TradePartnerID, 
			TeamComment, PartnerComment, PdfFileId, PdfUser, PdfDate, StyleQuoteTradePartnerID, StyleQuotaDutyID, StyleCostingID, StyleCostingType, 
			StyleCostingDate, StyleCostingStatus, StyleCostingFreightTypeID, StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, 
			StyleQuoteItemCustomField3, StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, StyleQuoteItemCustomField6, StyleQuoteItemCustomField7, 
			StyleQuoteItemCustomField8, StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, StyleQuoteItemCustomField11, 
			StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, StyleQuoteItemCustomField15, 
			StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, StyleQuoteItemCustomField19, 
			StyleQuoteItemCustomField20, StyleQuoteItemCustomField21, StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, 
			StyleQuoteItemCustomField24, StyleQuoteItemCustomField25, StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, 
			StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, 
			StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, 
			StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, 
			StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, 
			StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, 
			StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, 
			StyleCostingCustomField34, StyleCostingCustomField35, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, 
			@CreatedDate AS MDate, StyleSeasonYearID
		FROM  pStyleQuoteVariation
		WHERE StyleId = @StyleId 

	END	

	DECLARE @RowStyleLoop int
	DECLARE @RowStyleCount int
	SET @RowStyleLoop = 1
	SET @RowStyleCount = (SELECT COUNT(*) FROM #StyleQuoteVariation)
				
	WHILE @RowStyleLoop <= @RowStyleCount 

		BEGIN
		
		--SELECT @TradePartnerID = TradePartnerID, @NewStyleQuoteID = StyleQuoteID FROM #tempStyleQuote WHERE RecID = @RowStyleLoop
		
			INSERT INTO pStyleQuoteVariation
				(StyleQuoteVariationID, StyleQuoteID, StyleDevelopmentID, StyleID, TradePartnerID, TeamComment, PartnerComment, PdfFileId, PdfUser, PdfDate, 
				StyleQuoteTradePartnerID, StyleQuotaDutyID, StyleCostingID, StyleCostingType, StyleCostingDate, StyleCostingStatus, StyleCostingFreightTypeID, 
				StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, 
				StyleQuoteItemCustomField6, StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, StyleQuoteItemCustomField9, 
				StyleQuoteItemCustomField10, StyleQuoteItemCustomField11, StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, 
				StyleQuoteItemCustomField14, StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, 
				StyleQuoteItemCustomField18, StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, StyleQuoteItemCustomField21, 
				StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, StyleQuoteItemCustomField25, 
				StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, 
				StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, StyleCostingCustomField9, StyleCostingCustomField10, 
				StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, StyleCostingCustomField14, StyleCostingCustomField15, 
				StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, StyleCostingCustomField19, StyleCostingCustomField20, 
				StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, StyleCostingCustomField24, StyleCostingCustomField25, 
				StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, StyleCostingCustomField29, StyleCostingCustomField30, 
				StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, StyleCostingCustomField34, StyleCostingCustomField35, CUser, 
				CDate, MUser, MDate, StyleSeasonYearID)
			SELECT  StyleQuoteVariationID, StyleQuoteId, StyleDevelopmentId, StyleId, TradePartnerID, 
				TeamComment, PartnerComment, PdfFileId, PdfUser, PdfDate, StyleQuoteTradePartnerID, StyleQuotaDutyID, StyleCostingID, StyleCostingType, 
				StyleCostingDate, StyleCostingStatus, StyleCostingFreightTypeID, StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, 
				StyleQuoteItemCustomField3, StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, StyleQuoteItemCustomField6, StyleQuoteItemCustomField7, 
				StyleQuoteItemCustomField8, StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, StyleQuoteItemCustomField11, 
				StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, StyleQuoteItemCustomField15, 
				StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, StyleQuoteItemCustomField19, 
				StyleQuoteItemCustomField20, StyleQuoteItemCustomField21, StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, 
				StyleQuoteItemCustomField24, StyleQuoteItemCustomField25, StyleCostingCustomField1, StyleCostingCustomField2, StyleCostingCustomField3, 
				StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, 
				StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, 
				StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, 
				StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, 
				StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, 
				StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, 
				StyleCostingCustomField34, StyleCostingCustomField35, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, 
				@CreatedDate AS MDate, StyleSeasonYearID
			FROM  #StyleQuoteVariation
			WHERE RecID = @RowStyleLoop

			SET @RowStyleLoop = @RowStyleLoop + 1
			
		END
		
DROP TABLE #tempStyleQuote		
DROP TABLE #StyleQuoteVariation
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03091'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03091', GetDate())

END

GO