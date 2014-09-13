/*
Comments:

#01 - Ryan Cabanas - October 21, 2009
	Replace the old color image string with the new color image string using function.
Deleted old code.
*/



ALTER     PROCEDURE  [dbo].[dpx_MaterialColor_Approval_Tracking_SELECT]
	@Season      			nvarchar(200) = NULL
	,@Year	     			nvarchar(200) = NULL
	--,@StyleCategoryID		nvarchar(40) = NULL  -- pStyleCategory.StyleCategoryID (Item Category on plmOn)
	,@TradePartnerID		nvarchar(40) = NULL    -- means "all" users
	,@TradePartnerVendorID		nvarchar(40) = NULL
	,@ApprovalStatus		nvarchar(40) = NULL
AS

BEGIN
SET NOCOUNT ON

--select * from  pMaterial where B IS NOT NULL and B <> ''  and D IS NOT NULL and D <> ''
--select * from  pMaterialTradePartnerColor
--select * from  pMaterialColor
--select * from  pMaterialSize
--select * from  pComponentType
--select * from  pMaterialTradePartner
--select * from  xCustom8


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


SELECT  LTRIM(RTRIM(m.B))  as Season
	,LTRIM(RTRIM(m.D)) as MaterialYear
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
	--,c.ColorCode,  c.ColorName
	,t.MaterialTradeColor2, t.MaterialTradeColor3, t.MaterialTradeColor4
	,t.MaterialTradeColor18, t.MaterialTradeColor17, t.MaterialTradeColor5, t.MaterialTradeColor6
	,t.MaterialTradeColor7, t.MaterialTradeColor8
	,t.MaterialColorImageID

	--,(CASE WHEN t.MaterialColorImageID IS NULL 
        --               THEN '<img src="/System/Control/ThumbColorJPG.aspx?S=25&CFID=' + CAST(t.ColorFolderID AS VARCHAR(50)) 
        --              + '&CPID=' + CAST(t.ColorPaletteID AS VARCHAR(50)) 
        --              + '"> ' ELSE '<img src="/System/Control/ThumbJPG.aspx?S=25&V=' + CAST(t.MaterialColorImageVersion AS VARCHAR(10)) 
        --              + '&IID=' + CAST(t.MaterialColorImageID AS VARCHAR(50)) + '"> ' 
	--END) AS ColorImagePath

	,(dbo.fnx_GetStreamingColorImagePath(t.ColorFolderID, t.ColorPaletteID)) AS ColorImagePath	--Comment #01
	
FROM pMaterialTradePartnerColor t WITH (NOLOCK)
INNER JOIN pMaterial      m ON m.MaterialID = t.MaterialID
LEFT OUTER JOIN pMaterialColor c ON c.MaterialColorID = t.MaterialColorID
LEFT OUTER JOIN pMaterialSize  s ON s.MaterialSizeID  = t.MaterialSizeID 
LEFT OUTER JOIN pComponentType p ON p.componentTypeID = m.MaterialType
LEFT OUTER JOIN pMaterialTradePartner tp ON tp.MaterialTradePartnerId = t.MaterialTradePartnerId and tp.MaterialId = t.MaterialID
LEFT OUTER JOIN uTradePartner ut ON ut.TradepartnerId = tp.TradepartnerId
LEFT OUTER JOIN uTradepartnerVendor uv On uv.TradePartnerVendorID = tp.TradepartnerVendorId
WHERE
      
(
	((LTRIM(RTRIM(m.B)) = LTRIM(RTRIM(@Season))) OR ( LTRIM(RTRIM(@Season)) = 'ALL'))
       )
   AND (
	
	 (LTRIM(RTRIM(m.D)) =  LTRIM(RTRIM(@Year))) or ( LTRIM(RTRIM(@Year)) ='ALL')
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
VALUES     ('DB_Version', '4.0.0000', '830', GetDate())
GO