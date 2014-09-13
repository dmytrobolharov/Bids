/****** Object:  StoredProcedure [dbo].[spx_NPMCompliance_Attached_File_DELETE]    Script Date: 02/07/2013 14:45:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMCompliance_Attached_File_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMCompliance_Attached_File_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMCompliance_Attached_File_DELETE]    Script Date: 02/07/2013 14:45:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMCompliance_Attached_File_DELETE]
	-- Add the parameters for the stored procedure here
@ComplianceId UNIQUEIDENTIFIER,
@TradePartnerID UNIQUEIDENTIFIER,
@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL,
@TradePartnerIDChain VARCHAR(MAX)
AS
BEGIN

	IF @TradePartnerRelationshipLevelID IS NULL
	BEGIN
		EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain,
		@TradePartnerRelationshipLevelID OUTPUT
	END
	
	DELETE FROM 
           pComplianceTradePartnerSharedFiles
    WHERE
		ComplianceID = @ComplianceID
		AND TradePartnerID = @TradePartnerID
		AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID     		
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04994', GetDate())
GO
