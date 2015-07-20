IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Compliance_Share_File_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Compliance_Share_File_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_Compliance_Share_File_Update]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Compliance_Share_File_Update]
	-- Add the parameters for the stored procedure here
@ComplianceId UNIQUEIDENTIFIER
AS
BEGIN
	
	
	BEGIN
			
		IF (SELECT COUNT(*) FROM pComplianceTradePartnerSharedFiles WHERE  ComplianceID=@ComplianceId) = 0
			BEGIN
				UPDATE pCompliance 
				SET 
					ComplianceFileShared = 0
				WHERE
					ComplianceId = @ComplianceId
			END
		ELSE
			BEGIN
				UPDATE pCompliance 
				SET 
					ComplianceFileShared = 1
				WHERE
					ComplianceId = @ComplianceId
			END
	END
	
	
		
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03303'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03303', GetDate())
END
GO