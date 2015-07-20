IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Style_AgentVendor_Change_ActivityTracking_SUB_4_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Style_AgentVendor_Change_ActivityTracking_SUB_4_SELECT]
GO

-- =============================================
-- Author:		Paul Kim, Yunique Solutions
-- ALTER  date: 5/8/2008

-- =============================================
CREATE                                              PROCEDURE [dbo].[dpx_Style_AgentVendor_Change_ActivityTracking_SUB_4_SELECT]
		 
        @DateFrom			datetime = NULL
	,@DateTo			datetime = NULL
	,@ShowStyleWorkflowActivity	int 
	,@Season			nvarchar(200) = NULL
	,@Year				nvarchar(200) = NULL   --- can not be int since pStyleHeader.CustomField4 has '*n/a' 
	--,@StyleSubCategory		nvarchar(200) = NULL   -- pStyleHeader.CustomField5 (Item Category on plmOn)
	,@StyleCategoryID		nvarchar(40) = NULL  -- pStyleCategory.StyleCategoryID (Item Category on plmOn)
	,@TradePartnerID		nvarchar(40) = NULL    -- means "all" users
	,@TradePartnerVendorID		nvarchar(40) = NULL 
	,@SortBy			int


AS

DECLARE @MinSmplWorkflowSort 	int


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;



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

--IF @StyleSubCategory	 IS NULL
--BEGIN
-- SET @StyleSubCategory	 = 'ALL'
--END

IF @StyleCategoryID	 IS NULL or @StyleCategoryID	= ''
BEGIN
 SET @StyleCategoryID	 = 'ALL'
END


IF  @TradePartnerID IS NULL
	BEGIN
	 SET @TradePartnerID = 'ALL'
	END

IF  @TradePartnerVendorID IS NULL or @TradePartnerVendorID = ''
	BEGIN
	 SET @TradePartnerVendorID = 'ALL'
	END

CREATE TABLE #TempSampleWorkflowChange
(
	TradePartnerID			uniqueidentifier
	,TradePartnerName		nvarchar(200) COLLATE DATABASE_DEFAULT
	,TradePartnerVendorID		uniqueidentifier
	,VendorName			nvarchar(200) COLLATE DATABASE_DEFAULT
	,StyleID			uniqueidentifier
	,StyleNo			nvarchar(20) COLLATE DATABASE_DEFAULT
     	,Descrip			nvarchar(100) COLLATE DATABASE_DEFAULT
	,StyleColorID			uniqueidentifier
	,StyleColorName			nvarchar(200) COLLATE DATABASE_DEFAULT
	,SampleWorkflow			nvarchar(100) COLLATE DATABASE_DEFAULT
	,DueDate			datetime
	,DaysLate			int
	,StatusID			int
	,Status				nvarchar(20) COLLATE DATABASE_DEFAULT
	,smplWorkflowSortNum	 	int
	,StyleYear			nvarchar(200) COLLATE DATABASE_DEFAULT
	,Season				nvarchar(200) COLLATE DATABASE_DEFAULT
	--,StyleSubCategory		nvarchar(200)
	,StyleSubCategory		nvarchar(255) COLLATE DATABASE_DEFAULT
	,subReportNum			int
)


CREATE TABLE #TempWorkflowSort
(
	SampleWorkflowID		nvarchar(5) COLLATE DATABASE_DEFAULT,
	SmplWorkflowSortNum		int
)




-- Get minimum value of SampleWorkflowSort
SET @MinSmplWorkflowSort = (SELECT MIN(LTRIM(RTRIM(SampleWorkflowSort))) FROM pSampleWorkflow WITH (NOLOCK) )



--Insert the sequential index into the temp table based on the SampleWorkflowSort
-- since sampleWorkflowID does not gurantee the actucal display sequence
INSERT INTO #TempWorkflowSort (SampleWorkflowID, SmplWorkflowSortNum)
SELECT 				aa.SampleWorkflowID 
     AS SampleWorkflowID, 
			       (SELECT 	count(DISTINCT pp.SampleWorkflowID)
			        FROM 	pSampleWorkflow pp WITH (NOLOCK)
			        WHERE	LTRIM(RTRIM(pp.SampleWorkflowSort)) <= LTRIM(RTRIM(aa.SampleWorkflowSort))
				   and  LTRIM(RTRIM(pp.SampleWorkflowSort)) >= @MinSmplWorkflowSort
				   -- If SampleWorkflowSort itself also has duplications, determine the sequence with SampleWorkflowID
				   and  pp.SampleWorkflowID <= aa.SampleWorkflowID   
				
   ) AS  SmplWorkflowSortNum
FROM pSampleWorkflow aa WITH (NOLOCK)
ORDER BY aa.SampleWorkflowSort, aa.SampleWorkflowID ASC






-- Gathering Agent, Vendor data for the subreport 1, Style Workflow - TechPack Activity

INSERT INTO #TempSampleWorkflowChange (	 TradePartnerID, TradePartnerName, TradePartnerVendorID, VendorName,   StyleID, 
				StyleNo, descrip, StyleColorID, StyleColorName, SampleWorkflow,DueDate,DaysLate,StatusID,Status,
				SmplWorkflowSortNum, StyleYear, Season,  StyleSubCategory, subReportNum)
SELECT  
	w.TradePartnerID, ut.TradePartnerName
	,w.TradePartnerVendorID, uv.VendorName 
	,w.StyleID, h.StyleNo,h.[Description] as descrip, w.StyleColorID
	,(SELECT TOP 1 RTRIM(c.StyleColorName) FROM  dbo.pStyleColorway c WHERE w.StyleColorID = c.StyleColorID) as StyleColorName
	,f.SampleWorkflow, w.DueDate
	,CASE WHEN w.Status < 2 THEN DATEDIFF(day, GETDATE(), w.DueDate)
         ELSE 0
         END  as DaysLate
	,w.Status
	,(SELECT TOP 1 LEFT(c.Status, 11) FROM  pSampleRequestSubmitStatus c WHERE  c.StatusID = w.Status)  as Status
	, SmplWorkflowSortNum
	,LTRIM(RTRIM(h.CustomField4)) as StyleYear
	,LTRIM(RTRIM(h.CustomField2)) as Season
	--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
	,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
	, 4
		--w.StyleColorID, w.SampleRequestTradeID, w.SampleRequestWorkflowID,
FROM pSampleRequestWorkflow w
	 INNER JOIN  pStyleHeader h ON h.StyleID = w.StyleID
    	 LEFT OUTER JOIN uTradePartner ut ON ( (ut.TradePartnerID IS NULL and w.TradePartnerID IS NULL) OR 
						( ut.TradePartnerID = w.TradePartnerID))
	 LEFT OUTER JOIN uTradePartnerVendor uv ON (((uv.TradePartnerID IS NULL and w.TradePartnerID IS NULL)
		        				OR ( uv.TradePartnerID = w.TradePartnerID))
						and (uv.TradePartnerVendorID = w.TradePartnerVendorID))
	 LEFT OUTER JOIN  pSampleWorkflow f ON f.SampleWorkflowID = w.SampleWorkflowID
 	 LEFT OUTER JOIN #TempWorkflowSort tmp  	ON tmp.SampleWorkflowID = w.SampleWorkflowID
	 LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory  
WHERE	
        --(w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
       (   
              ((w.DueDate > @DateFrom) OR   (DATEDIFF(day,  w.DueDate,  @DateFrom) = 0 ) )  
               AND
              ((w.DueDate < @DateTo) OR   (DATEDIFF(day,  w.DueDate,  @DateTo) = 0 ) )            
        )

   AND (
	 (    LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))   ) 
          OR 
         (    LTRIM(RTRIM(@Season)) = 'ALL'    )
       )

   AND (
	 --(CAST(h.CustomField4 AS int) = @Year) or (@Year IS NULL)  --- can not user CAST-int since h.CustomField4 has '*n/a' 
	  (   LTRIM(RTRIM(h.CustomField4)) = @Year   ) 
          OR
          (   @Year = 'ALL'   )
       )

   AND ( 
         -- (   LTRIM(RTRIM(h.CustomField5))   = LTRIM(RTRIM(@StyleSubCategory ))   ) 
	 -- OR 
         -- (   LTRIM(RTRIM(@StyleSubCategory)) = 'ALL'   ) 
	 (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL') 
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

GROUP BY w.TradePartnerID, ut.TradePartnerName, w.TradePartnerVendorID, uv.VendorName, h.StyleNo, w.StyleID,  h.[Description], w.StyleColorID, 
         f.SampleWorkflowID, f.SampleWorkflow
         , w.DueDate, w.Status, h.CustomField4, 
         h.CustomField2, 
	 --h.CustomField5, 
	 c.StyleCategoryID, c.StyleCategory,
	 tmp.SmplWorkflowSortNum
ORDER BY ut.TradePartnerName, uv.VendorName, h.StyleNo, w.StyleID, w.StyleColorID, 
         tmp.SmplWorkflowSortNum, f.SampleWorkflow


SELECT  TradePartnerID, TradePartnerName, TradePartnerVendorID, VendorName,   StyleID, 
	StyleNo, descrip, StyleColorID, StyleColorName, SampleWorkflow,DueDate,DaysLate,StatusID,Status,
	SmplWorkflowSortNum, StyleYear, Season,  StyleSubCategory, subReportNum
 FROM #TempSampleWorkflowChange



DROP TABLE #TempSampleWorkflowChange
DROP TABLE #TempWorkflowSort
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07383', GetDate())
GO
