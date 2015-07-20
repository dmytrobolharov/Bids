IF OBJECT_ID(N'[dbo].[dpx_Style_Quotation_Tracking_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_Style_Quotation_Tracking_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Style_Quotation_Tracking_SELECT]
(
	 @DateFrom  		datetime=NULL
	,@DateTo    		datetime=NULL
	,@NumDaysToAlert	int = 7
	,@ReminderOnly		int = 1
	,@Season			nvarchar(200) = NULL
	,@Year				nvarchar(200) = NULL --- can not be int since pStyleHeader.CustomField4 has '*n/a' 
	,@StyleCategoryID	nvarchar(40) = NULL  -- 6-6-2008 pStyleCategory.StyleCategoryID (Item Category on plmOn)
	,@TradePartnerID	nvarchar(40) = NULL    -- means "all" users
	,@TradePartnerVendorID		nvarchar(40) = NULL
	,@SortBy			int = 1
	,@Status			int = -999

)
WITH RECOMPILE
AS


SET NOCOUNT ON


-- Declare variables.
DECLARE @ReportImageFolder	nvarchar(200)


IF @DateFrom IS NULL or @DateFrom = ''
BEGIN
   SET @DateFrom = '01/01/1900'
END 


IF @DateTo IS NULL or @DateTo = ''
BEGIN 
   SET @DateTo= '12/31/2900'
END 


IF @Season IS NULL
BEGIN
 SET @Season = 'ALL'
END

IF @Year IS NULL
BEGIN
 SET @Year = 'ALL'
END


IF @StyleCategoryID	 IS NULL or @StyleCategoryID	= ''  -- 6-6-2008
BEGIN							      -- 6-6-2008
 SET @StyleCategoryID	 = 'ALL'			      -- 6-6-2008
END


IF  @TradePartnerID IS NULL or @TradePartnerID=''
	BEGIN
	 SET @TradePartnerID = 'ALL'
	END

IF  @TradePartnerVendorID IS NULL or @TradePartnerVendorID = ''
	BEGIN
	 SET @TradePartnerVendorID = 'ALL'
	END

IF @SortBy IS NULL or @SortBy = ''
BEGIN
   SET @SortBy = 1   -- -999 means "all"
END

IF @Status IS NULL 
BEGIN
   SET @Status = -999   -- -999 means "all"
END

IF @NumDaysToAlert IS NULL or @NumDaysToAlert = '' or @NumDaysToAlert = 0 
	BEGIN
		SET @NumDaysToAlert = 7 -- -999 means "all"
	END 



-- To insert summary records of integer values group by StyleID, TrdPartner, TrdPrtVendorID and ColorID

CREATE TABLE #TempStyleQuoteFinal
(
   -- Style part
	rowNum				bigint IDENTITY
    ,StyleID 			nvarchar(40)
	,FilePath			nvarchar(300)
	,StyleNo			nvarchar(20)	
	,Descrip			nvarchar(100)	
	,StyleSet			int 
	,SizeClass			nvarchar(400)
	,TrdPartnerID       nvarchar(40)
	,TrdPartnerName		nvarchar(200)
	,TrdPrtVendorID		nvarchar(40)
	,VendorName			nvarchar(200)
	,StyleYear			nvarchar(200)
	,Season				nvarchar(200)
	,StyleSubCategory	nvarchar(255)  
   ---- Quotation part
	,QuoteNo			int
	,StyleQuoteItemStatusId  int
	,StyleQuoteItemStatus nvarchar(200)
	,Units				decimal(18,0)
	,Weight				decimal(18,3)
	,TargetRetailCost		money
	,TargetMargin		decimal(18,3)
	,Royalty			decimal(18,3)
	,MiscCost			decimal(18,3)
	,StyleCostingType	nvarchar(50)
	,TargetFirstCost	decimal(18,3)
	,QuotedFirstCost	money
	,FOBCountry			nvarchar(200)
	,COO				nvarchar(200)
	,DutyPercent		decimal(18,3)
	,QuotaCategory		nvarchar(255)
	,CommissionPercent	decimal(18,3)
	,TLC				decimal(18,3)
	,ActualMargin		decimal(18,3)
	,StyleQuoteItemDueDate datetime
	,DaysLate			int
	,alertColor			nvarchar(30)
	,imageShowFlag		int
)


CREATE TABLE #TempRowNum
(
	TradePartnerName		nvarchar(200)
	,TradePartnerID			uniqueidentifier 
	,StyleNo				nvarchar(20) 
	--,StyleID				nvarchar(40) 
	,minRowNum				bigint
)


SET @ReportImageFolder = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageReportPath')


INSERT INTO #TempStyleQuoteFinal (StyleID, FilePath, StyleNo, Descrip, StyleSet, SizeClass, 
		TrdPartnerID, TrdPartnerName, TrdPrtVendorID, VendorName,StyleYear,Season,StyleSubCategory,	
	
		QuoteNo, StyleQuoteItemStatusId, StyleQuoteItemStatus, Units, Weight, TargetRetailCost, 
		TargetMargin, Royalty, MiscCost, StyleCostingType, TargetFirstCost, QuotedFirstCost, 
		FOBCountry, COO, DutyPercent,QuotaCategory, CommissionPercent, TLC, ActualMargin, StyleQuoteItemDueDate,
		DaysLate, alertColor,imageShowFlag
		) 
 
SELECT   CAST(h.StyleID AS nvarchar(40) )  as StyleID
		,@ReportImageFolder + '/blank_item.jpg' as FilePath
		,h.StyleNo  as StyleNo
	    ,h.[Description] as Descrip 
		,h.StyleSet 
		,COALESCE(sc.Custom, h.SizeClass) 
		,CAST(q.TradePartnerID as nvarchar(40))  AS TrdPartnerID
		,ut.TradePartnerName as TrdPartnerName
		,CAST(q.TradePartnerVendorID as nvarchar(40))  AS TrdPrtVendorID
	        ,uv.VendorName 
		,LTRIM(RTRIM(h.CustomField4))  as StyleYear
		,LTRIM(RTRIM(h.CustomField2))  as Season
		,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory 
		,q.StyleQuoteItemNo	as QuoteNo
		,q.StyleQuoteItemStatusId as StyleQuoteItemStatusId
		,s.Custom as StyleQuoteItemStatus
		,q.StyleCostingCustomField18  as Units
        ,q.StyleCostingCustomField2   as Weight
		,q.StyleCostingCustomField1   as TargetRetailCost
		,q.StyleCostingCustomField3   as TargetMargin
		,q.StyleCostingCustomField8   as Royalty
		,q.StyleCostingCustomField4   as MiscCost
	    ,(SELECT ct.StyleCostingType 
		  FROM pStyleCostingType ct 
		  WHERE ct.StyleCostingTypeID = q.StyleCostingType)
									  as StyleCostingType
		,q.StyleCostingCustomField14  as TargetFirstCost
		,q.StyleQuoteItemCustomField1 as QuotedFirstCost
		,q.StyleQuoteItemCustomField4 as FOBCountry
		,q.StyleQuoteItemCustomField5 as COO
		,q.StyleCostingCustomField11  as DutyPercent
		,d.DutyCategory as QuotaCategory
		,q.StyleCostingCustomField9   as CommissionPercent
		,f.TotalLandCost as TLC
		,f.Margin  as ActualMargin
		,q.StyleQuoteItemDueDate as StyleQuoteItemDueDate
		,DATEDIFF(d, q.StyleQuoteItemDueDate, GETDATE()) as DaysLate
		,(CASE WHEN q.StyleQuoteItemStatusId < 2 
					AND DATEDIFF(day, GETDATE(), q.StyleQuoteItemDueDate) = @NumDaysToAlert THEN 'Yellow'
		       WHEN q.StyleQuoteItemStatusId < 2 
					AND DATEDIFF(day, GETDATE(), q.StyleQuoteItemDueDate) < @NumDaysToAlert 
					AND DATEDIFF(day, GETDATE(), q.StyleQuoteItemDueDate) >= 0 THEN 'Yellow'
		       WHEN q.StyleQuoteItemStatusId < 2 
					AND DATEDIFF(day, GETDATE(), q.StyleQuoteItemDueDate) < 0 THEN 'Red'
               WHEN q.StyleQuoteItemStatusId = 3            THEN 'Green'
		       WHEN q.StyleQuoteItemStatusId = 2            THEN 'Silver'
		  ELSE ''
                  END
		) as alertColor
		,0 as imageShowFlag	
	        
FROM     pStyleQuoteItem q 	WITH (NOLOCK)
		 LEFT OUTER JOIN pStyleHeader    h WITH (NOLOCK) ON (h.StyleID = 	q.StyleID)
         LEFT OUTER JOIN uTradePartner ut WITH (NOLOCK) ON ( (q.TradePartnerID IS NULL and ut.TradePartnerID IS NULL) -- Catch Null Records too
		        			OR ( q.TradePartnerID = ut.TradePartnerID))
	     LEFT OUTER JOIN uTradePartnerVendor uv WITH (NOLOCK)	ON (((q.TradePartnerID IS NULL and uv.TradePartnerID IS NULL) -- Catch Null Records too
		        			OR ( q.TradePartnerID = uv.TradePartnerID))
							AND (q.TradePartnerVendorID 	= uv.TradePartnerVendorID))
	     LEFT OUTER JOIN pStyleCategory c WITH (NOLOCK) ON  c.StyleCategoryID = h.StyleCategory 
         LEFT OUTER JOIN pStyleQuoteItemFreightCost  f WITH (NOLOCK)   ON f.StyleQuoteItemID = q.StyleQuoteItemID
		 LEFT OUTER JOIN pStyleCostingDuty d WITH (NOLOCK)  ON d.CustomID = q.StyleQuotaDutyID
		 LEFT OUTER JOIN pStyleQuoteItemStatus s  WITH (NOLOCK) ON CAST(s.CustomKey AS int) = q.StyleQuoteItemStatusId
		 LEFT JOIN pSizeClass sc WITH (NOLOCK) ON sc.CustomID = h.SizeClassId
WHERE h.StyleNo IS NOT NULL
	AND
      (
			((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) 
			OR (LTRIM(RTRIM(@Season))  = 'ALL'))
       )
   AND (
	 --(CAST(h.CustomField4 AS int) = @Year) or (@Year IS NULL)  ---h.CustomField4 has '*n/a' 
			 (LTRIM(RTRIM(h.CustomField4)) = LTRIM(RTRIM(@Year))) 
          OR (LTRIM(RTRIM(@Year))  = 'ALL')
        )
   AND ( 
         -- 6-6-2008 (LTRIM(RTRIM( h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (LTRIM(RTRIM(@StyleSubCategory))  = 'ALL') 
      	     (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID )))
          OR (@StyleCategoryID = 'ALL')
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
   AND(
		(f.FreightCostSelected = 1) OR
        (f.FreightCostSelected IS NULL)
	   )
   AND(
		 (q.StyleQuoteItemStatusId = @Status) OR (@Status = -999)
	  )

ORDER BY h.StyleNo,  ut.TradePartnerName,uv.VendorName,   LTRIM(RTRIM(c.StyleCategory)), q.StyleQuoteItemNo
	

INSERT INTO #TempRowNum (TradePartnerName, StyleNo,  minRowNum) 
SELECT NULL, StyleNo,  MIN(rowNum) FROM #TempStyleQuoteFinal
GROUP BY StyleNo ORDER BY StyleNo

UPDATE s  set imageShowFlag = 1,
			  FilePath =	(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
							FROM	pStyleHeader  LEFT OUTER JOIN hImage ON
								pStyleHeader.DesignSketchID = hImage.ImageID AND
								pStyleHeader.DesignSketchVersion = hImage.[Version]
							WHERE pStyleHeader.StyleID = s.StyleID
							)
FROM #TempRowNum r, #TempStyleQuoteFinal s
WHERE r.StyleNo = s.StyleNo and r.minRowNum = s.rowNum



-- change sort order from ID to Name

IF @ReminderOnly = 1
	BEGIN
		
		IF @SortBy = 1 -- Style

		BEGIN
		

			SELECT StyleID, FilePath, StyleNo, Descrip, StyleSet, SizeClass, 
				TrdPartnerID, TrdPartnerName, TrdPrtVendorID, VendorName,StyleYear,Season,StyleSubCategory,	
				QuoteNo, StyleQuoteItemStatusId, StyleQuoteItemStatus, Units, Weight, TargetRetailCost, 
				TargetMargin, Royalty, MiscCost, StyleCostingType, TargetFirstCost, QuotedFirstCost, 
				FOBCountry, COO, DutyPercent,QuotaCategory, CommissionPercent, TLC, ActualMargin, StyleQuoteItemDueDate,
				DaysLate, alertColor,imageShowFlag 
			FROM  #TempStyleQuoteFinal 
			WHERE alertColor = 'Yellow'
			ORDER BY  StyleNo,  TrdPartnerName, VendorName,  StyleSubCategory, QuoteNo
		END
/*
		IF @SortBy = 2 -- Category
		BEGIN
			SELECT * FROM  #TempStyleQuoteFinal WHERE alertColor = 'Yellow'
			ORDER BY  StyleSubCategory, StyleNo, StyleID, TrdPartnerName, VendorName,  QuoteNo
		END
	    IF @SortBy = 3 -- Agent/Vendor
		BEGIN
			SELECT * FROM  #TempStyleQuoteFinal WHERE alertColor = 'Yellow'
			ORDER BY  TrdPartnerName, VendorName,  StyleSubCategory, StyleNo, QuoteNo 
		END
*/

	END
ELSE
	BEGIN
		IF @SortBy = 1 -- Style
		BEGIN
			SELECT StyleID, FilePath, StyleNo, Descrip, StyleSet, SizeClass, 
				TrdPartnerID, TrdPartnerName, TrdPrtVendorID, VendorName,StyleYear,Season,StyleSubCategory,	
				QuoteNo, StyleQuoteItemStatusId, StyleQuoteItemStatus, Units, Weight, TargetRetailCost, 
				TargetMargin, Royalty, MiscCost, StyleCostingType, TargetFirstCost, QuotedFirstCost, 
				FOBCountry, COO, DutyPercent,QuotaCategory, CommissionPercent, TLC, ActualMargin, StyleQuoteItemDueDate,
				DaysLate, alertColor,imageShowFlag 
			FROM  #TempStyleQuoteFinal
			ORDER BY  StyleNo,  TrdPartnerName, VendorName,  StyleSubCategory, QuoteNo
		END
/*
		IF @SortBy = 2 -- Category
		BEGIN
			SELECT * FROM  #TempStyleQuoteFinal 
			ORDER BY  StyleSubCategory, StyleNo,  TrdPartnerName, VendorName,  QuoteNo
		END
		IF @SortBy = 3 -- Agent/Vendor
		BEGIN
			SELECT * FROM  #TempStyleQuoteFinal 
			ORDER BY  TrdPartnerName, VendorName,  StyleSubCategory,StyleNo,  QuoteNo
		END
		
*/
	END



Drop Table #TempStyleQuoteFinal



/*
		,(CASE WHEN tt.status < 2 and DATEDIFF(day, GETDATE(), tt.DueDate) = @NumDaysToAlert THEN 

				        ' ' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'

		       WHEN tt.status < 2 and  DATEDIFF(day, GETDATE(), tt.DueDate) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), tt.DueDate) >= 0 THEN 

					' <' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'

		       WHEN  tt.status < 2 and  DATEDIFF(day, GETDATE(), tt.DueDate) < 0 THEN 

					' ' + RTRIM(CAST(DATEDIFF(day, tt.DueDate, GETDATE()) AS NVARCHAR(10))) + 'd Late'
                       WHEN (tt.status = 2) or (tt.status = 3)                         THEN ' Apprvd'
		       WHEN (tt.status = 4)                                            THEN ' Dropped'
		  ELSE ''
                  END
		) as alertMessage
		
*/

SET NOCOUNT OFF


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09569', GetDate())
GO
