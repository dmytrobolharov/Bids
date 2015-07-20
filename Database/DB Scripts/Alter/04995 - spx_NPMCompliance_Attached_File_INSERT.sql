/****** Object:  StoredProcedure [dbo].[spx_NPMCompliance_Attached_File_INSERT]    Script Date: 02/07/2013 14:03:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMCompliance_Attached_File_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMCompliance_Attached_File_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMCompliance_Attached_File_INSERT]    Script Date: 02/07/2013 14:03:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMCompliance_Attached_File_INSERT]
	-- Add the parameters for the stored procedure here
@ComplianceId UNIQUEIDENTIFIER,
@TradePartnerID UNIQUEIDENTIFIER,
@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL,
@TradePartnerIDChain VARCHAR(MAX),
@CDate AS DATETIME
AS
BEGIN

	IF @TradePartnerRelationshipLevelID IS NULL
	BEGIN
		EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain,
		@TradePartnerRelationshipLevelID OUTPUT
	END

	IF NOT EXISTS(SELECT * FROM pComplianceTradePartnerSharedFiles WHERE TradePartnerID=@TradePartnerID AND ComplianceID=@ComplianceId AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID)
	BEGIN
		INSERT INTO pComplianceTradePartnerSharedFiles 
		(
			ComplianceId,
			TradePartnerID,
			TradePartnerRelationshipLevelID,
			CDate
		)
		VALUES
		(
			@ComplianceId,
			@TradePartnerID,
			@TradePartnerRelationshipLevelID,
			@CDate
		)
	END
			
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04995', GetDate())
GO
