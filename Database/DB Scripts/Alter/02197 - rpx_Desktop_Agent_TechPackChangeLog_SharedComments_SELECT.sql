/*
Comments:

General - Ryan Cabanas - November 17, 2009
	Agent Tech Pack Change Log procedure.  Part of Agent Sample Shared
Comments report.
	This will show the "Change Log" information of a Tech Pack that falls
within the parameter dates for Tech Packs that have been shared with the
Agent selected in the parameter.

#01 - Ryan Cabanas - November 17, 2009
	Having a problem with the @TradePartnerID all of a sudden.  Need
to check for blanks on the parameter, also.
*/


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Desktop_Agent_TechPackChangeLog_SharedComments_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Desktop_Agent_TechPackChangeLog_SharedComments_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Desktop_Agent_TechPackChangeLog_SharedComments_SELECT]
(
	@TradePartnerID nvarchar(200)
	,@BeginDateString nvarchar(100)
	,@EndDateString nvarchar(100)
)
AS


--/**************/
--/*Testing.	*/
--/**************/
--BEGIN
--	DECLARE @TradePartnerID nvarchar(200)
--	DECLARE @BeginDateString nvarchar(100)
--	DECLARE @EndDateString nvarchar(100)

--	SET @TradePartnerID = 'f47807d7-96fe-40ba-acc9-3b28c60fbef4'
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
	,uTradePartner.TradePartnerID
	,pStyleHeader.StyleNo
	,pStyleHeader.[Description] AS StyleDescription
	,pTechPack.TechPackNo
	,pTechPack.TechPackName
	,pStyleChange.StyleChangeNo AS TechPackChangeLogNo
	,pStyleChange.StyleChangeDate AS TechPackChangeDate
	,pStyleChange.StyleChangeBy AS TechPackChangeUser
	,pStyleChange.StyleChangeDescription AS TechPackChangeDescription
	,@TradePartnerID AS TradePartnerParamID
	,@BeginDateString AS BeginDateString
	,@EndDateString AS EndDateString
FROM pStyleChange
	INNER JOIN pTechPack	ON	pStyleChange.TechPackID = pTechPack.TechPackID
	INNER JOIN pStyleHeader	ON	pTechPack.StyleID = pStyleHeader.StyleID
	INNER JOIN pTechPackTeam	ON	pTechPack.TechPackID = pTechPackTeam.TechPackID
									AND (pTechPackTeam.TeamID = @TradePartnerID
											OR @TradePartnerID = '99999999-9999-9999-9999-999999999999')
	INNER JOIN uTradePartner	ON	pTechPackTeam.TeamID = uTradePartner.TradePartnerID
WHERE pTechPack.TechPackID	IN	(
									SELECT TechPackId
									FROM pTechPackTeam
									WHERE (TeamID = @TradePartnerID
											OR @TradePartnerID = '99999999-9999-9999-9999-999999999999')
								)
	AND pStyleChange.StyleChangeDate >= CAST(@BeginDateString AS datetime)
	AND pStyleChange.StyleChangeDate <= CAST(@EndDateString AS datetime)
ORDER BY
	uTradePartner.TradePartnerName
	,pStyleHeader.StyleNo
	,pTechPack.TechPackNo DESC
	,pStyleChange.StyleChangeDate DESC


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '02197', GetDate())
GO