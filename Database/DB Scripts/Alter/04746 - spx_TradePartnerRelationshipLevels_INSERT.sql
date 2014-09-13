/****** Object:  StoredProcedure [dbo].[spx_TradePartnerRelationshipLevels_INSERT]    Script Date: 01/11/2013 14:02:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerRelationshipLevels_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerRelationshipLevels_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TradePartnerRelationshipLevels_INSERT]    Script Date: 01/11/2013 14:02:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_TradePartnerRelationshipLevels_INSERT]
	@TradePartnerIDChain VARCHAR(MAX), -- comma separated list of trade partners id (upper levels first, e.g. AgentID,VendorID,FactoryID)
	@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL OUTPUT
AS
BEGIN
	
	SELECT * INTO #tmpTradePartner
	FROM dbo.fnx_Split(@TradePartnerIDChain, ',')
	
	declare @Row INT = 1,
			@Total INT = (SELECT COUNT(*) FROM #tmpTradePartner),
			@TradePartnerMasterID UNIQUEIDENTIFIER = NULL,
			@RelationshipParentLevelID UNIQUEIDENTIFIER = NULL,
			@EmptyGuid VARCHAR(40) = '00000000-0000-0000-0000-000000000000';
	
	while @Row <= @Total
	begin
		declare @TradePartnerID UNIQUEIDENTIFIER = NULL,				
				@RelationshipLevelID UNIQUEIDENTIFIER = NULL;
				
		SELECT @TradePartnerID = value FROM #tmpTradePartner WHERE position = @Row
		
		SELECT @RelationshipLevelID = TradePartnerRelationshipLevelID FROM uTradePartnerRelationshipLevel 
		WHERE TradePartnerID = @TradePartnerID 
			AND ISNULL(TradePartnerMasterID, @EmptyGuid) = ISNULL(@TradePartnerMasterID, @EmptyGuid)
			AND ISNULL(TradePartnerRelationshipParentLevelID, @EmptyGuid) = ISNULL(@RelationshipParentLevelID, @EmptyGuid)
			
		if @RelationshipLevelID IS NULL -- partner is not in tree yet
		begin				
			set @RelationshipLevelID = NEWID();
			INSERT INTO uTradePartnerRelationshipLevel(
				TradePartnerRelationshipLevelID, TradePartnerID, TradePartnerMasterID, TradePartnerRelationshipParentLevelID)
			VALUES(@RelationshipLevelID, @TradePartnerID, @TradePartnerMasterID, @RelationshipParentLevelID)			
		end
		
		-- will be used in very next iteration of this while loop
		set @RelationshipParentLevelID = @RelationshipLevelID
		set @TradePartnerMasterID = @TradePartnerID
		
		set @Row = @Row + 1
		
		if @Row >= @Total -- on last iteration fill output parameter
			set @TradePartnerRelationshipLevelID = @RelationshipLevelID
	end
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04746', GetDate())
GO
