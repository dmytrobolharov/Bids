IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Enable_ProductPages_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Enable_ProductPages_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Enable_ProductPages_SELECT]
	@FolderTypeId INT,
	@ProductId UNIQUEIDENTIFIER
AS
BEGIN
	IF @FolderTypeId = '2' -- Style
	BEGIN
		SELECT EnableProductPages FROM pStyleHeader WHERE StyleID = @ProductId 
	END
	ELSE IF @FolderTypeId = '5' -- Sample request
	BEGIN
		IF EXISTS(SELECT * FROM pSampleRequestBOMTrade WHERE SampleRequestTradeID = @ProductId)
			SELECT ISNULL(EnableSampleRequestPages,0) AS EnableProductPages FROM pSampleRequestBOMTrade WHERE SampleRequestTradeID = @ProductId
		ELSE
			SELECT ISNULL(EnableSampleRequestPages,0) AS EnableProductPages FROM pSampleRequestTrade WHERE SampleRequestTradeID = @ProductId
	END
	ELSE IF @FolderTypeId = '24' -- Material request
	BEGIN
		SELECT ISNULL(EnableMaterialRequestPages, 0) AS EnableProductPages FROM pMaterialTradePartner WHERE MaterialTradePartnerId = @ProductId
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08640', GetDate())
GO
