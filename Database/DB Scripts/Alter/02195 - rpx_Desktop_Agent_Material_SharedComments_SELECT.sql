/*
Comments:

General - Ryan Cabanas - September 16, 2009
	Agent Material Shared Comments procedure.  Part of Agent Sample Shared
Comments report.

#01 - Ryan Cabanas - November 17, 2009
	Having a problem with the @TradePartnerID all of a sudden.  Need
to check for blanks on the parameter, also.
*/


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Desktop_Agent_Material_SharedComments_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Desktop_Agent_Material_SharedComments_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Desktop_Agent_Material_SharedComments_SELECT]
(
	@TradePartnerID nvarchar(200)
	,@BeginDateString nvarchar(100)
	,@EndDateString nvarchar(100)
)
AS


--/************/
--/*Testing.	*/
--/************/
--BEGIN
--	DECLARE @TradePartnerID nvarchar(200)
--	DECLARE @BeginDateString nvarchar(100)
--	DECLARE @EndDateString nvarchar(100)
--
--	SET @TradePartnerID = NULL
--	SET @BeginDateString = ''
--	SET @EndDateString = ''
--END


SET NOCOUNT ON


/************************/
/*Format parameters.	*/
/************************/
BEGIN
	IF(@TradePartnerID IS NULL OR @TradePartnerID = '00000000-0000-0000-0000-000000000000' OR @TradePartnerID = '')		--Comment #01
		BEGIN
			SET @TradePartnerID = '99999999-9999-9999-9999-999999999999'
		END	

	IF(@BeginDateString = '' OR @BeginDateString IS NULL)
		BEGIN
			SET @BeginDateString = '1900-01-01 00:00:00.000'
		END
	ELSE
		BEGIN
			SET @BeginDateString = @BeginDateString + ' 00:00:00.000'
		END

	IF(@EndDateString = '' OR @EndDateString IS NULL)
		BEGIN
			SET @EndDateString = '3000-12-31 23:59:59.999'
		END
	ELSE
		BEGIN
			SET @EndDateString = @EndDateString + ' 23:59:59.999'
		END
END


/********************/
/*Select statement.	*/
/********************/
SELECT
	uTradePartner.TradePartnerName AS AgentName
	,uTradePartnerVendor.VendorName
	,uTradePartnerVendor.TradePartnerID
	,uTradePartnerVendor.TradePartnerVendorID
	,pMaterial.MaterialNo
	,pMaterial.MaterialName
	,pMaterialColorSeasonYear.MaterialSeason
	,pMaterialColorSeasonYear.MaterialYear
	,pMaterialColor.ColorCode
	,pMaterialColor.ColorName
	,pMaterialSize.MaterialSize
	,pMaterialRequestWorkflow.MaterialRequestWorkflow
	,pMaterialRequestSubmit.Submit
	,pMaterialRequestSubmitComment.MaterialRequestSubmitComment AS SubmitComment
	,@TradePartnerID AS TradePartnerParamID
	,@BeginDateString AS BeginDateString
	,@EndDateString AS EndDateString
FROM pMaterialRequestSubmitWorkflow
	INNER JOIN pMaterialRequestSubmit ON	pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID
	INNER JOIN pMaterialTradePartner ON	pMaterialRequestSubmitWorkflow.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerID
	INNER JOIN uTradePartner ON	pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID
	INNER JOIN uTradePartnerVendor ON	pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
	INNER JOIN pMaterialRequestWorkflow ON	pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
	INNER JOIN pMaterial ON	pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID
	INNER JOIN pMaterialColor ON	pMaterialRequestSubmitWorkflow.MaterialColorID = pMaterialColor.MaterialColorID
	INNER JOIN pMaterialTradePartnerColor ON	pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = pMaterialTradePartnerColor.MaterialTradePartnerColorID
	LEFT OUTER JOIN pMaterialSize ON	pMaterialTradePartnerColor.MaterialSizeID = pMaterialSize.MaterialSizeID
	INNER JOIN pMaterialColorSeasonYear ON	pMaterialRequestSubmitWorkflow.MaterialColorID = pMaterialColorSeasonYear.MaterialColorID
											AND pMaterialRequestSubmitWorkflow.MaterialID = pMaterialColorSeasonYear.MaterialID
											AND pMaterialTradePartner.SeasonYearID = pMaterialColorSeasonYear.SeasonYearID
	INNER JOIN pMaterialRequestSubmitComment	ON	pMaterialRequestSubmit.MaterialRequestSubmitID = pMaterialRequestSubmitComment.MaterialRequestSubmitID
WHERE (uTradePartner.TradePartnerID = @TradePartnerID
		OR @TradePartnerID = '99999999-9999-9999-9999-999999999999')
	AND pMaterialRequestSubmitComment.MDate >= CAST(@BeginDateString AS datetime)
	AND pMaterialRequestSubmitComment.MDate <= CAST(@EndDateString AS datetime)
	AND pMaterialRequestSubmitComment.MaterialRequestSubmitCommentType = 'S'	--Shared comment.
ORDER BY
	uTradePartner.TradePartnerName
	,uTradePartnerVendor.VendorName
	,pMaterial.MaterialName
	,pMaterialColorSeasonYear.MaterialYear
	,pMaterialColorSeasonYear.MaterialSeason
	,pMaterialColor.ColorName
	,pMaterialRequestWorkflow.MaterialRequestWorkflowSort
	,pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
	,pMaterialRequestSubmit.Submit DESC


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '02195', GetDate())
GO