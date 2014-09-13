/****** Object:  StoredProcedure [dbo].[spx_NPMStyleFolderUser_INSERT]    Script Date: 01/30/2013 15:45:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMStyleFolderUser_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMStyleFolderUser_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMStyleFolderUser_INSERT]    Script Date: 01/30/2013 15:45:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMStyleFolderUser_INSERT]
(
@StyleDevelopmentID uniqueidentifier,
@StyleID uniqueidentifier,
@TradePartnerID uniqueidentifier,
@TradePartnerIDChain VARCHAR(MAX) = NULL,
@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL
)
AS 


IF @TradePartnerRelationshipLevelID IS NULL
BEGIN
	EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, 
													@TradePartnerRelationshipLevelID OUT
END

IF (SELECT COUNT(*)  FROM pStyleTeam WITH (NOLOCK) WHERE  StyleID = @StyleID AND TeamID = @TradePartnerID AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID) = 0
BEGIN
	INSERT INTO pStyleTeam (TeamID, StyleDevelopmentID, StyleID, TradePartner, RequestStatus, TradePartnerRelationshipLevelID)
	VALUES (@TradePartnerID, @StyleDevelopmentID, @StyleID, 1, 0, @TradePartnerRelationshipLevelID)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04920', GetDate())
GO
