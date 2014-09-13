IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03304'))
BEGIN

	UPDATE pCompliance
	SET
		ComplianceFileShared = 
		CASE 
			WHEN ComplianceId NOT IN (SELECT ComplianceId FROM pComplianceTradePartnerSharedFiles) 
				THEN 0 
				ELSE 1 
		END
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03304', GetDate())
END
GO	