IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_MaterialColor_Approval_Tracking_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_MaterialColor_Approval_Tracking_SELECT]
GO

CREATE PROCEDURE  [dbo].[dpx_MaterialColor_Approval_Tracking_SELECT]
	@Season      			nvarchar(200) = NULL
	,@Year	     			nvarchar(200) = NULL
	,@TradePartnerID		nvarchar(40) = NULL    -- means "all" users
	,@TradePartnerVendorID		nvarchar(40) = NULL
	,@ApprovalStatus		nvarchar(40) = NULL
AS


--/************/
--/*Testing.	*/
--/************/
--DECLARE @Season      			nvarchar(200)
--	,@Year	     				nvarchar(200)
--	,@TradePartnerID			nvarchar(40)
--	,@TradePartnerVendorID		nvarchar(40)
--	,@ApprovalStatus			nvarchar(40)
--SELECT @Season      			= NULL
--	,@Year	     				= NULL
--	,@TradePartnerID			= NULL
--	,@TradePartnerVendorID		= NULL
--	,@ApprovalStatus			= NULL



BEGIN

IF @Season IS NULL
BEGIN
 SET @Season = 'ALL'
END

IF @Year IS NULL
BEGIN
 SET @Year = 'ALL'
END

IF  @TradePartnerID IS NULL
	BEGIN
	 SET @TradePartnerID = 'ALL'
	END

IF  @TradePartnerVendorID IS NULL or @TradePartnerVendorID = ''
	BEGIN
	 SET @TradePartnerVendorID = 'ALL'
	END

IF  @ApprovalStatus IS NULL or @ApprovalStatus = ''
	BEGIN
	 SET @ApprovalStatus = 'ALL'
	END


SELECT  LTRIM(RTRIM(pSeasonYear.Season))  as Season
	,LTRIM(RTRIM(pSeasonYear.[Year])) as MaterialYear
	,p.ComponentDescription
	,m.MaterialType
	,m.MaterialNo as MaterialCode
	--, m.MaterialCode
	,m.MaterialName
	,m.G as Content
	,m.H as Construction
	,m.I as YarnSize_Count
	,(CASE WHEN m.MaterialType = 11 THEN m.J 
               ELSE '' END) AS Gauge
	,(CASE WHEN m.MaterialType = 11 THEN m.K 
               ELSE '' END) AS Weight
	,c.ColorCode,  c.ColorName
	,(CASE  WHEN t.MaterialSizeID = '00000000-0000-0000-0000-000000000000' OR t.MaterialSizeID IS NULL  THEN  '*NA'
	        ELSE  s.MaterialSize END )  AS Treatment
	,t.MaterialTradeColor16 as COO
	,t.MaterialTradePartnerID 
	,ut.TradePartnerName
	,uv.VendorName
	,ut.TradePartnerName + '/'+ uv.VendorName as AgentVendor
	,t.MaterialTradeColor1 as Status
	,m.R as SupplierMillRefNo
	,t.MaterialTradeColor2, t.MaterialTradeColor3, t.MaterialTradeColor4
	,t.MaterialTradeColor18, t.MaterialTradeColor17, t.MaterialTradeColor5, t.MaterialTradeColor6
	,t.MaterialTradeColor7, t.MaterialTradeColor8
	,t.MaterialColorImageID
	,(dbo.fnx_GetStreamingColorImagePath(t.ColorFolderID, t.ColorPaletteID, '100')) AS ColorImagePath	--Comment #01
	
FROM pMaterialTradePartnerColor t WITH (NOLOCK)
INNER JOIN pMaterial      m ON m.MaterialID = t.MaterialID
LEFT OUTER JOIN pMaterialColor c ON c.MaterialColorID = t.MaterialColorID
LEFT OUTER JOIN pMaterialSize  s ON s.MaterialSizeID  = t.MaterialSizeID 
LEFT OUTER JOIN pComponentType p ON p.componentTypeID = m.MaterialType
LEFT OUTER JOIN pMaterialTradePartner tp ON tp.MaterialTradePartnerId = t.MaterialTradePartnerId and tp.MaterialId = t.MaterialID
LEFT OUTER JOIN uTradePartner ut ON ut.TradepartnerId = tp.TradepartnerId
LEFT OUTER JOIN uTradepartnerVendor uv On uv.TradePartnerVendorID = tp.TradepartnerVendorId
INNER JOIN pSeasonYear ON	tp.SeasonYearId = pSeasonYear.SeasonYearId
WHERE
      
(
	((LTRIM(RTRIM(pSeasonYear.Season)) = LTRIM(RTRIM(@Season))) OR ( LTRIM(RTRIM(@Season)) = 'ALL'))
       )
   AND (
	
	 (LTRIM(RTRIM(pSeasonYear.[Year])) =  LTRIM(RTRIM(@Year))) or ( LTRIM(RTRIM(@Year)) ='ALL')
        )
  
   AND (
	  (CAST(uv.TradePartnerVendorID  AS nvarchar(40)) = @TradePartnerVendorID)
           OR  
          (@TradePartnerVendorID = 'ALL')  
       )
   AND (
	  (CAST(ut.TradePartnerID  AS nvarchar(40)) = @TradePartnerID)
           OR  
          (@TradePartnerID = 'ALL')  
       )
   AND (
	  (RTRIM(t.MaterialTradeColor1) = RTRIM(@ApprovalStatus))
           OR  
          (RTRIM(@ApprovalStatus) = 'ALL')  
       )
Order by p.ComponentDescription, m.MaterialNo, c.ColorCode, c.ColorName, AgentVendor

END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10087', GetUTCDate())
GO