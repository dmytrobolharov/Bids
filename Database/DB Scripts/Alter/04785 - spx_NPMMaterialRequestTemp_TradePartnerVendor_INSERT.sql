/****** Object:  StoredProcedure [dbo].[spx_NPMMaterialRequestTemp_TradePartnerVendor_INSERT]    Script Date: 01/17/2013 15:21:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMMaterialRequestTemp_TradePartnerVendor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMMaterialRequestTemp_TradePartnerVendor_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMMaterialRequestTemp_TradePartnerVendor_INSERT]    Script Date: 01/17/2013 15:21:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMMaterialRequestTemp_TradePartnerVendor_INSERT] (
@MaterialRequestGroupID   UNIQUEIDENTIFIER ,
@TradePartnerID  UNIQUEIDENTIFIER,
@TradePartnerIDChain VARCHAR(MAX) = NULL,
@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER = NULL,
@CUser NVARCHAR(200),
@CDate  DATETIME
)
AS

IF @TradePartnerRelationshipLevelID IS NULL
BEGIN
	EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, 
													@TradePartnerRelationshipLevelID OUT
END

IF ( SELECT COUNT(*) FROM pMaterialRequestAgentVendorTemp 
WHERE MaterialRequestGroupID = @MaterialRequestGroupID 
AND TradePartnerVendorID = @TradePartnerID 
AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID) = 0 
BEGIN
	INSERT INTO  pMaterialRequestAgentVendorTemp ( MaterialRequestGroupID, TradePartnerVendorID , TradePartnerRelationshipLevelID, CDate, CUser ) 
	VALUES (@MaterialRequestGroupID, @TradePartnerID, @TradePartnerRelationshipLevelID, @CDate, @CUser ) 
END  
ELSE
BEGIN
	UPDATE pMaterialRequestAgentVendorTemp 
	SET CDate = CDate, CUser = @CUser
	WHERE MaterialRequestGroupID = @MaterialRequestGroupID AND  TradePartnerVendorID = @TradePartnerID  AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04785', GetDate())
GO
