IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMComplianceShared_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMComplianceShared_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_NPMComplianceShared_SELECT] 
@ComplianceTypeID int,
@TradePartnerID as nvarchar(50) = null
AS 
IF @ComplianceTypeID <> 0
	BEGIN
	
		SELECT  DISTINCT   dbo.pCompliance.ComplianceID, dbo.pComplianceType.ComplianceType, dbo.pCompliance.ComplianceTypeId, dbo.pCompliance.ComplianceFileName,
				dbo.pCompliance.ComplianceDescription, dbo.pCompliance.ComplianceFileExt, dbo.pCompliance.ComplianceFileSize, 
				dbo.pCompliance.ComplianceFileShared, dbo.pCompliance.CUser, dbo.pCompliance.CDate, dbo.pCompliance.MUser, dbo.pCompliance.MDate, 
				dbo.pCompliance.MChange, dbo.pCompliance.ComplianceFolderOrder
		FROM         dbo.pCompliance WITH (NOLOCK) INNER JOIN
				dbo.pComplianceType WITH (NOLOCK) ON dbo.pCompliance.ComplianceTypeId = dbo.pComplianceType.ComplianceTypeID
				INNER JOIN pComplianceTradePartnerSharedFiles ON pCompliance.ComplianceID=pComplianceTradePartnerSharedFiles.ComplianceID
				LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON pComplianceTradePartnerSharedFiles.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
		WHERE    pCompliance.ComplianceTypeId = @ComplianceTypeID
					AND @TradePartnerID IN (AgentID, VendorID, FactoryID, pComplianceTradePartnerSharedFiles.TradePartnerID)
		
	END
	
ELSE
	
		SELECT  DISTINCT  dbo.pCompliance.ComplianceID, dbo.pComplianceType.ComplianceType, dbo.pCompliance.ComplianceTypeId, dbo.pCompliance.ComplianceFileName,
				dbo.pCompliance.ComplianceDescription, dbo.pCompliance.ComplianceFileExt, dbo.pCompliance.ComplianceFileSize, 
				dbo.pCompliance.ComplianceFileShared, dbo.pCompliance.CUser, dbo.pCompliance.CDate, dbo.pCompliance.MUser, dbo.pCompliance.MDate, 
				dbo.pCompliance.MChange, dbo.pCompliance.ComplianceFolderOrder
		FROM         dbo.pCompliance WITH (NOLOCK) INNER JOIN
				dbo.pComplianceType WITH (NOLOCK) ON dbo.pCompliance.ComplianceTypeId = dbo.pComplianceType.ComplianceTypeID
				INNER JOIN pComplianceTradePartnerSharedFiles ON pCompliance.ComplianceID=pComplianceTradePartnerSharedFiles.ComplianceID
				LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON pComplianceTradePartnerSharedFiles.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
		WHERE   @TradePartnerID IN (AgentID, VendorID, FactoryID, pComplianceTradePartnerSharedFiles.TradePartnerID)
		
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05138', GetDate())
GO
