IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestTradeBOM_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestTradeBOM_INSERT]
GO



CREATE PROCEDURE [dbo].[spx_SampleRequestTradeBOM_INSERT] (@SampleRequestGroupID NVARCHAR(50), @TradePartnerIDChain NVARCHAR(MAX), @StyleID NVARCHAR(50), @StyleSet NVARCHAR(50), @SampleRequestShare NVARCHAR(2), @ItemDim1Id UNIQUEIDENTIFIER, @ItemDim2Id UNIQUEIDENTIFIER, @ItemDim3Id UNIQUEIDENTIFIER, @CreatedBy NVARCHAR(200), @CreatedDate DATETIME, @StyleBOMDimensionID NVARCHAR(50) = NULL, @SampleRequestTradeID UNIQUEIDENTIFIER = NULL OUTPUT)
AS
DECLARE @I AS INT, @Row_Count INT, @SampleRequestWorkflowID NVARCHAR(50), @NewSampleRequestWorkflowID NVARCHAR(50), @StyleRequestWorkflowSetItemID UNIQUEIDENTIFIER = newid(), @TechPackID NVARCHAR(50), @WorkFlowItemID NVARCHAR(50), @StyleBOMDimensionItemID NVARCHAR(50), @StyleSeasonYearID UNIQUEIDENTIFIER, @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER, @TradePartnerID UNIQUEIDENTIFIER

SET NOCOUNT ON

BEGIN TRANSACTION

BEGIN
	EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, @TradePartnerRelationshipLevelID OUT

	SELECT @TradePartnerID = TradePartnerID
	FROM vwx_TradePartnerRelationshipLevels_SEL
	WHERE TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
	
	SELECT @WorkFlowItemID = WorkFlowItemID FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID
	IF @WorkFlowItemID IS NULL SET @WorkFlowItemID = '00000000-0000-0000-0000-000000000000'

	SELECT TOP 1 @StyleBOMDimensionItemID = COALESCE(StyleBOMDimensionItemID, '00000000-0000-0000-0000-000000000000')
	FROM pStyleBOMDimensionItems
	WHERE (ItemDim1Id = @ItemDim1Id OR ItemDim1Id IS NULL OR @ItemDim1Id = '00000000-0000-0000-0000-000000000000') 
		AND (ItemDim2Id = @ItemDim2Id OR ItemDim2Id IS NULL OR @ItemDim2Id = '00000000-0000-0000-0000-000000000000') 
		AND (ItemDim3Id = @ItemDim3Id OR ItemDim3Id IS NULL OR @ItemDim3Id = '00000000-0000-0000-0000-000000000000') 
	AND StyleBOMDimensionID = @StyleBOMDimensionID AND StyleID = @StyleID

	SET @SampleRequestTradeID = newid()

	BEGIN
		SELECT @TechPackID = TechPackID
		FROM pstyleHeader
		WHERE StyleId = @StyleId

		IF @TechPackID IS NULL
		BEGIN
			SET @TechPackID = '00000000-0000-0000-0000-000000000000'
		END

		SELECT TOP 1 @StyleSeasonYearID = b.StyleSeasonYearID
		FROM pSampleRequestGroupTemp a
		LEFT OUTER JOIN pStyleSeasonYear b ON a.StyleID = b.StyleID AND a.SeasonYearID = b.SeasonYearID
		WHERE @SampleRequestGroupID = SampleRequestGroupID

		INSERT INTO pSampleRequestBOMTrade (SampleRequestTradeID, TradePartnerVendorID, TradePartnerID, StyleID, ItemDim1Id, ItemDim2Id, ItemDim3Id, TechPackID, CUser, CDate, MUser, MDate, MessageSent, SampleRequestShare, StyleSourcingID, StyleSeasonYearID, WorkFlowItemID, StyleBOMDimensionID, StyleBOMDimensionItemID, TradePartnerRelationshipLevelID)
		VALUES (@SampleRequestTradeID, NULL, @TradePartnerID, @StyleID, @ItemDim1Id, @ItemDim2Id, @ItemDim3Id, @TechPackID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 0, @SampleRequestShare, NULL, @StyleSeasonYearID, @WorkFlowItemID, @StyleBOMDimensionID, @StyleBOMDimensionItemID, @TradePartnerRelationshipLevelID)

		-- share sample request for high level of trade partner hierarchy
		IF @SampleRequestShare = '1'
		BEGIN
			INSERT INTO pSampleRequestShare (SampleRequestTradeID, TradePartnerID, MUser, MDate)
			VALUES (
				@SampleRequestTradeID, (
					SELECT COALESCE(AgentID, VendorID, FactoryID)
					FROM vwx_TradePartnerRelationshipLevels_SEL tpm
					INNER JOIN pSampleRequestBOMTrade srt ON tpm.TradePartnerRelationshipLevelID = srt.TradePartnerRelationshipLevelID
					WHERE srt.SampleRequestTradeID = @SampleRequestTradeID
					), @CreatedBy, @CreatedDate
				)
		END

		INSERT INTO pSampleRequestBOMActivity (SampleRequestTradeId, TradePartnerId, TradePartnerVendorId, StyleId, ItemDim1Id, ItemDim2Id, ItemDim3Id, TechPackId, CUser, CDate, SampleActivity, ActivityType)
		VALUES (@SampleRequestTradeId, @TradePartnerId, NULL, @StyleId, @ItemDim1Id, @ItemDim2Id, @ItemDim3Id, @TechPackId, @CreatedBy, @CreatedDate, N'New Sample Request', 'N')

		IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION

			RETURN
		END
	END

	BEGIN
		--For multi Dimension BOM
		BEGIN
			SELECT IDENTITY(INT, 1, 1) AS ID_Num, SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, SampleRequestGroupID, SampleWorkflowTempItemID, SampleWorkflowID, StyleID, @ItemDim1Id AS 'ItemDim1Id', @ItemDim2Id AS 'ItemDim2Id', @ItemDim3Id AS 'ItemDim3Id', StyleSet, STATUS, Submit, SubmitDays, ResubmitDays, AssignedTo, TechPackID, StartDate, ISNULL(DueDate, getdate()) AS DueDate, EndDate, CUser, CDate, MUser, MDate
			INTO ##SampleRequestWorkflowBOMTemp
			FROM pSampleRequestWorkflowBOMTemp
			WHERE (SampleRequestGroupID = @SampleRequestGroupID) AND (StyleSet = @StyleSet)

			SET @Row_Count = (
					SELECT COUNT(*)
					FROM ##SampleRequestWorkflowBOMTemp
					WHERE (SampleRequestGroupID = @SampleRequestGroupID)
					)
			SET @I = 1

			WHILE @I <= @Row_Count
			BEGIN
				SET @NewSampleRequestWorkflowID = newid()

				SELECT @SampleRequestWorkflowID = SampleRequestWorkflowID
				FROM ##SampleRequestWorkflowBOMTemp
				WHERE ID_Num = @I

				BEGIN
					INSERT INTO pSampleRequestWorkflowBOM (TradePartnerVendorID, TradePartnerID, SampleRequestWorkflowID, StyleRequestWorkflowSetItemID, SampleRequestTradeID, SampleWorkflowTempItemID, SampleWorkflowID, StyleID, ItemDim1Id, ItemDim2Id, ItemDim3Id, StyleSet, STATUS, Submit, SubmitDays, ResubmitDays, AssignedTo, TechPackID, StartDate, DueDate, FinalDate, EndDate, CUser, CDate, MUser, MDate, SampleWorkflowFinalDate, SampleWorkflowPartnerTypeID)
					SELECT NULL, @TradePartnerID, @NewSampleRequestWorkflowID AS SampleRequestWorkflowID, @StyleRequestWorkflowSetItemID, @SampleRequestTradeID AS SampleRequestTradeID, SampleWorkflowTempItemID, SampleWorkflowID, StyleID, @ItemDim1Id AS 'ItemDim1Id', @ItemDim2Id AS 'ItemDim2Id', @ItemDim3Id AS 'ItemDim3Id', StyleSet, 0 AS STATUS, 1 AS Submit, SubmitDays, ResubmitDays, AssignedTo, TechPackID, StartDate, ISNULL(DueDate, getdate()) AS DueDate, FinalDate, '1/1/1900', CUser, CDate, MUser, MDate, SampleWorkflowFinalDate, SampleWorkflowPartnerTypeID
					FROM dbo.pSampleRequestWorkflowBOMTemp
					WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleSet = @StyleSet)

					IF @@ERROR <> 0
					BEGIN
						PRINT 'Error 1 '

						ROLLBACK TRANSACTION

						RETURN
					END
				END

				BEGIN
					INSERT INTO dbo.pSampleRequestSubmitBOM (TradePartnerVendorID, TradePartnerID, SampleRequestTradeID, SampleRequestWorkflowID, SampleWorkflowID, StyleID, ItemDim1Id, ItemDim2Id, ItemDim3Id, StyleSet, WorkflowID, Submit, STATUS, AssignedTo, StartDate, RecDate, RecBy, RecCarrier, RecTrackNo, RecWeight, VendorWeight, VendorDate, VendorName, SubmitDays, ResubmitDays, DueDate, EndDate, EndBy, CUser, CDate, MUser, MDate, Comment, InternalComment)
					SELECT NULL, @TradePartnerID, @SampleRequestTradeID AS SampleRequestTradeID, @NewSampleRequestWorkflowID AS SampleRequestWorkflowID, SampleWorkflowID, StyleID, @ItemDim1Id AS 'ItemDim1Id', @ItemDim2Id AS 'ItemDim2Id', @ItemDim3Id AS 'ItemDim3Id', StyleSet, NULL AS WorkflowID, 1 AS Submit, 0 AS STATUS, AssignedTo, StartDate, NULL AS RecDate, NULL AS RecBy, NULL AS RecCarrier, NULL AS RecTrackNo, NULL AS RecWeight, NULL AS VendorWeight, NULL AS VendorDate, NULL AS VendorName, SubmitDays, ResubmitDays, ISNULL(DueDate, getdate()) AS DueDate, EndDate, NULL AS EndBy, CUser, CDate, MUser, MDate, NULL AS Comment, NULL AS InternalComment
					FROM dbo.pSampleRequestWorkflowBOMTemp
					WHERE (SampleRequestWorkflowID = @SampleRequestWorkflowID) AND (StyleSet = @StyleSet)

					IF @@ERROR <> 0
					BEGIN
						ROLLBACK TRANSACTION

						RETURN
					END
				END

				SET @I = @I + 1
			END

			IF @@ERROR <> 0
			BEGIN
				ROLLBACK TRANSACTION

				RETURN
			END
		END
	END

	PRINT ' No ERROR 1 '
END

SET NOCOUNT OFF

COMMIT TRANSACTION

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07406', GetDate())
GO
