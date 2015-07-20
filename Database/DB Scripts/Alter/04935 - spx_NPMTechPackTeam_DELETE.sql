/****** Object:  StoredProcedure [dbo].[spx_NPMTechPackTeam_DELETE]    Script Date: 01/30/2013 17:59:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMTechPackTeam_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMTechPackTeam_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMTechPackTeam_DELETE]    Script Date: 01/30/2013 17:59:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMTechPackTeam_DELETE]
(@TechPackId uniqueidentifier,
@TeamId uniqueidentifier,
@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL,
@TradePartnerIDChain VARCHAR(MAX) = NULL
)
AS 

BEGIN
	
	IF @TradePartnerRelationshipLevelID IS NULL
	BEGIN
		EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, 
														@TradePartnerRelationshipLevelID OUT
	END
	
	DELETE FROM pTechPackTeam WHERE TechPackID = @TechpackId AND TeamID = @TeamId
	AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04935', GetDate())
GO
