IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ReportMaterialRequestSubmitLogic_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ReportMaterialRequestSubmitLogic_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ReportMaterialRequestSubmitLogic_INSERT]
(
	@DataXmlID varchar(40),
	@MaterialID varchar(40),
	@MaterialTradePartnerColorID varchar(40),
	@MaterialRequestSubmitID varchar(40),
	@MaterialRequestWorkflowID varchar(5),
	@MaterialRequestHeaderXml xml,
	@MaterialRequestBodyXml xml		
)
AS 

DECLARE @MaterialTradePartnerID varchar(40)
BEGIN
	SELECT  @MaterialTradePartnerID = MaterialTradePartnerID FROM pMaterialTradePartnerColor WHERE MaterialTradePartnerColorID =  @MaterialTradePartnerColorID
END

BEGIN
	EXEC spx_ReportMaterialHeader_INSERT @DataXmlId, @MaterialID, @MaterialTradePartnerID, @MaterialRequestSubmitID, @MaterialRequestHeaderXml
	EXEC spx_ReportMaterialRequestSubmitItem_INSERT @DataXmlId, @MaterialRequestWorkflowID, @MaterialRequestSubmitID, @MaterialRequestBodyXml   
END 



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01397', GETDATE())
GO	


