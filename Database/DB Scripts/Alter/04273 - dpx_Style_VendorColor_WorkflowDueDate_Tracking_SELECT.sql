IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Style_VendorColor_WorkflowDueDate_Tracking_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Style_VendorColor_WorkflowDueDate_Tracking_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[dpx_Style_VendorColor_WorkflowDueDate_Tracking_SELECT]
(
	 @DateFrom  		datetime=NULL
	,@DateTo    		datetime=NULL
	,@NumDaysToAlert	int
	,@ReminderOnly		int = 0
	,@Season			nvarchar(200) = NULL
	,@Year				nvarchar(200) = NULL --- can not be int since pStyleHeader.CustomField4 has '*n/a' 
	-- 6-6-2008 ,@StyleSubCategory		nvarchar(200) = NULL -- pStyleHeader.CustomField5 (Item Category on plmOn)
	,@StyleCategoryID		nvarchar(40) = NULL  -- 6-6-2008 pStyleCategory.StyleCategoryID (Item Category on plmOn)
	,@UserId			int  = -999   -- -999 means "all"
	,@TradePartnerID		nvarchar(40) = NULL    -- means "all" users
	,@TradePartnerVendorID		nvarchar(40) = NULL
	,@SortBy			int = NULL

)
WITH RECOMPILE
AS


-- Declare variables.
DECLARE @MinSmplWorkflowSort 	int
DECLARE @MaxSortNum	    	int


IF @DateFrom IS NULL or @DateFrom = ''
BEGIN
   SET @DateFrom = '01/01/1900'
END 


IF @DateTo IS NULL or @DateTo = ''
BEGIN 
   SET @DateTo= '12/31/2900'
END 

IF @UserId IS NULL 
BEGIN
   SET @UserId = -999   -- -999 means "all"
END

IF @Season IS NULL
BEGIN
 SET @Season = 'ALL'
END

IF @Year IS NULL
BEGIN
 SET @Year = 'ALL'
END

--6-6-2008	IF @StyleSubCategory	 IS NULL
--6-6-2008	BEGIN
--6-6-2008	 SET @StyleSubCategory	 = 'ALL'
--6-6-2008	END

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

IF @SortBy IS NULL 
BEGIN
   SET @SortBy = -999   -- -999 means "all"
END

-- Make a temporary tables
-- Grouped by Request

CREATE TABLE #TempStyleTracking
(
     StyleID				uniqueidentifier
	,TrdPartnerID 			uniqueidentifier
	,TrdPrtVendorID 		uniqueidentifier
	,StyleColorID			uniqueidentifier
    	,SmplWorkflowID    		nvarchar(5) COLLATE database_default
	,smplRequestWorkflowID  	uniqueidentifier
	,DueDate			datetime
	,Status				int
	,AssignedTo			int

)

-- To determine the actual sequence of the workflow on the report

CREATE TABLE #TempWorkflowSort
(
	SmplWorkflowSortNum INT IDENTITY(1,1),
	SmplWorkflowID		nvarchar(5) COLLATE database_default,
	SmplWorkflowSortNum_Original	int
)


-- To insert summary records of integer values group by StyleID, TrdPartner, TrdPrtVendorID and ColorID

CREATE TABLE #TempTrackingFinal
(
     	StyleID 			nvarchar(40) COLLATE database_default
	,FilePath			nvarchar(300) COLLATE database_default
	,StyleNo			nvarchar(20) COLLATE database_default	
	,Descrip			nvarchar(100) COLLATE database_default	
	,StyleSet			int 
	,SizeClass			nvarchar(50) COLLATE database_default
	,TrdPartnerID       		nvarchar(40) COLLATE database_default
	,TrdPartnerName			nvarchar(200) COLLATE database_default
	,TrdPrtVendorID			nvarchar(40) COLLATE database_default
	,VendorName			nvarchar(200) COLLATE database_default
	,StyleColorID			nvarchar(40) COLLATE database_default
	,StyleColorName			nvarchar(200) COLLATE database_default
	,XFactory			nvarchar(200) COLLATE database_default
	,TechPackID			nvarchar(40) COLLATE database_default
	--,TechPackDate	    		datetime
	,StartShipDate			datetime
	,WorkflowName	    		nvarchar(100) COLLATE database_default
	,DueDate			datetime
	,Status				int
	,alertMessage			nvarchar(50) COLLATE database_default
	,alertColor	        	nvarchar(50) COLLATE database_default
	,smplWorkflowSortNum	 	int
	,maxSortNum			int
	,StyleYear			nvarchar(200) COLLATE database_default
	,Season				nvarchar(200) COLLATE database_default
	-- 6-6-2008 ,StyleSubCategory		nvarchar(200)
	,StyleSubCategory		nvarchar(255) COLLATE database_default  -- 6-6-2008
	,UserId				int
	
)



-- Get minimum value of SampleWorkflowSort
SET @MinSmplWorkflowSort = (SELECT MIN(LTRIM(RTRIM(SampleWorkflowSort))) FROM pSampleWorkflow )



--Insert the sequential index into the temp table based on the SampleWorkflowSort
-- since sampleWorkflowID does not gurantee the actucal  display sequence on the report columns
INSERT INTO #TempWorkflowSort (SmplWorkflowID, SmplWorkflowSortNum_Original)
SELECT 				aa.SampleWorkflowID 
     AS SmplWorkflowID, 
	aa.SampleWorkflowSort AS SmplWorkflowSortNum_Original
FROM pSampleWorkflow aa 
ORDER BY aa.SampleWorkflowSort ASC, aa.SampleWorkflowID ASC




INSERT INTO #TempStyleTracking (StyleID,TrdPartnerID,TrdPrtVendorID, StyleColorID, smplWorkflowID, 
		 smplRequestWorkflowID, DueDate, Status, AssignedTo)  
SELECT   	r.StyleID
		,r.TradePartnerID    AS TrdPartnerID
		,r.TradePartnerVendorID  AS TrdPrtVendorID
		,r.StyleColorID
	        ,r.SampleWorkflowID AS smplWorkflowID
		,r.SampleRequestWorkflowID AS smplRequestWorkflowID
		,(SELECT TOP 1 rs.DueDate FROM pSampleRequestSubmit rs, pSampleRequestTrade t 
		  	WHERE  r.SampleRequestWorkflowID = rs.SampleRequestWorkflowID
			 and   r.SampleWorkflowID = rs.SampleWorkflowID 
			 and   r.TradePartnerID = rs.TradePartnerID
			 and   r.TradePartnerVendorID = rs.TradePartnerVendorID
		         and   r.StyleID = rs.StyleID
	                 and   r.StyleColorID = rs.StyleColorID 

			 and   rs.SampleRequestTradeID = t.SampleRequestTradeID

     			ORDER BY rs.Submit desc, rs.DueDate desc
	          ) as DueDate
		,(SELECT TOP 1 w.status FROM pSampleRequestWorkflow w, pSampleRequestTrade t 
		  	WHERE  r.SampleRequestWorkflowID = w.SampleRequestWorkflowID
			 and   r.SampleWorkflowID = w.SampleWorkflowID 
			 and   r.TradePartnerID = w.TradePartnerID
			 and   r.TradePartnerVendorID =w.TradePartnerVendorID
		         and   r.StyleID = w.StyleID
	                 and   r.StyleColorID = w.StyleColorID 

			 and   w.SampleRequestTradeID = t.SampleRequestTradeID

     			ORDER BY t.CDate, w.Submit, w.DueDate desc
	          ) as Status
		 ,w.AssignedTo  as AssignedTo

FROM pSampleRequestSubmit r
	INNER JOIN pSampleRequestWorkflow w ON	r.SampleRequestWorkflowId = w.SampleRequestWorkflowId
											AND r.Submit = w.Submit

WHERE   r.SampleRequestWorkflowID = w.SampleRequestWorkflowID
       AND r.DueDate >= @DateFrom  and r.DueDate <= @DateTo
       AND (
	  (w.AssignedTo = @UserId) OR  (@UserId = -999) 
            )
	
	
GROUP BY r.StyleID, r.StyleSet, r.TradePartnerID, r.TradePartnerVendorID
	, r.StyleColorID, r.SampleWorkflowID, r.SampleRequestWorkflowID, w.AssignedTo



INSERT INTO #TempTrackingFinal (StyleID, FilePath, StyleNo, Descrip, StyleSet, SizeClass, 
		TrdPartnerID, TrdPartnerName, TrdPrtVendorID, VendorName,StyleColorID,
		StyleColorName,XFactory,TechPackID, StartShipDate, WorkflowName, DueDate, Status,
		alertMessage,alertColor, smplWorkflowSortNum, maxSortNum
		,StyleYear			
	,Season				
	,StyleSubCategory		
	,UserId				
		) 
 
SELECT   	CAST(tt.StyleID AS nvarchar(40) )  as StyleID
		,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
			FROM	pStyleHeader LEFT OUTER JOIN hImage ON
				pStyleHeader.DesignSketchID = hImage.ImageID AND
				pStyleHeader.DesignSketchVersion = hImage.Version
			WHERE pStyleHeader.StyleID = tt.StyleID
		) AS FilePath
		,h.StyleNo  as StyleNo
	        ,h.[Description] as Descrip 
		,h.StyleSet 
		,h.SizeClass 
		,CAST(tt.TrdPartnerID as nvarchar(40))  AS TrdPartnerID
		,ut.TradePartnerName as TrdPartnerName
		,CAST(tt.TrdPrtVendorID as nvarchar(40))  AS TrdPrtVendorID
	        ,uv.VendorName 
		,tt.StyleColorID
		,(SELECT c.StyleColorName FROM  dbo.pStyleColorway c WHERE tt.StyleColorID = c.StyleColorID) as StyleColorName
		,h.CustomField5   as XFactory
		,CAST(h.TechPackId as nvarchar(40)) as TechPackID
		--,h.TechPackDate  as TechPackDate
		,(CASE WHEN h.CustomField10 IS NULL THEN NULL
		              WHEN h.CustomField10 = '' THEN NULL
		              ELSE CAST(h.CustomField10 AS datetime) 
		              END  )as StartShipDate
		,wk.SampleWorkflow  as WorkflowName
		,tt.DueDate
		,tt.Status
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
		,(CASE WHEN tt.status < 2 and DATEDIFF(day, GETDATE(), tt.DueDate) = @NumDaysToAlert THEN 'Yellow'
		       WHEN tt.status < 2 and DATEDIFF(day, GETDATE(), tt.DueDate) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), tt.DueDate) >= 0 THEN 'Yellow'
		       WHEN tt.status < 2 and DATEDIFF(day, GETDATE(), tt.DueDate) < 0 THEN 'Red'
                       WHEN (tt.status = 2) or (tt.status = 3)                         THEN 'Green'
		       WHEN (tt.status = 4)                         THEN 'Silver'
		  ELSE ''
                  END
		) as alertColor
		,tmp.smplWorkflowSortNum	
		,@maxSortNum  as MaxSortNum	
		,LTRIM(RTRIM(h.CustomField4)) as StyleYear
		,LTRIM(RTRIM(h.CustomField2)) as Season
		-- 6-6-2008 ,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
		,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory  -- 6-6-2008
		,tt.AssignedTo as UserId
	        
FROM #TempStyleTracking tt
	     -- Descriptions by outer joins
	     INNER JOIN pStyleHeader    h		ON (tt.StyleID = h.StyleID)
             LEFT OUTER JOIN uTradePartner ut 		ON ( (tt.TrdPartnerID IS NULL and ut.TradePartnerID IS NULL)
		        				     OR 
							     ( tt.TrdPartnerID = ut.TradePartnerID))
	     LEFT OUTER JOIN uTradePartnerVendor uv 	ON (((tt.TrdPartnerID IS NULL and uv.TradePartnerID IS NULL)
		        					OR ( tt.TrdPartnerID = uv.TradePartnerID))
							   and (tt.TrdPrtVendorID 	= uv.TradePartnerVendorID))
	     LEFT OUTER JOIN pSampleWorkflow wk 	ON (tt.SmplWorkflowID 	= wk.SampleWorkflowID)
	     LEFT OUTER JOIN #TempWorkflowSort tmp  	ON tt.SmplWorkflowID	= tmp.SmplWorkflowID
	     LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory -- 6-6-2008
WHERE

      (
	((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR (LTRIM(RTRIM(@Season))  = 'ALL'))
       )
   AND (
	 --(CAST(h.CustomField4 AS int) = @Year) or (@Year IS NULL)  ---h.CustomField4 has '*n/a' 
	 (LTRIM(RTRIM(h.CustomField4)) = LTRIM(RTRIM(@Year))) or (LTRIM(RTRIM(@Year))  = 'ALL')
        )
   AND ( 
         -- 6-6-2008 (LTRIM(RTRIM( h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (LTRIM(RTRIM(@StyleSubCategory))  = 'ALL') 
      	             (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL')
       )
   AND (
	  (tt.AssignedTo = @UserId ) OR  (@UserId = -999)  -- -999 means "all"
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



ORDER BY tt.StyleID, StyleNo,  CAST(tt.TrdPartnerID AS nvarchar(40)), ut.TradePartnerName, tt.TrdPrtVendorID,  uv.VendorName,  
         tt.StyleColorID,  tmp.smplWorkflowSortNum	



-- change sort order from ID to Name

IF @ReminderOnly = 1
BEGIN
	IF @SortBy = 1 -- Category
	BEGIN
	    SELECT * FROM  #TempTrackingFinal WHERE alertMessage like '%away'
	    ORDER BY  StyleSubCategory, StyleNo, StyleID, TrdPartnerName,TrdPartnerID, VendorName, TrdPrtVendorID, StyleColorName, smplWorkflowSortNum 
	END
	IF @SortBy = 2 -- Style
	BEGIN
	    SELECT * FROM  #TempTrackingFinal WHERE alertMessage like '%away'
	    ORDER BY  StyleNo, StyleID, TrdPartnerName,TrdPartnerID, VendorName, TrdPrtVendorID, StyleColorName, smplWorkflowSortNum 
	END
	

END
ELSE
BEGIN
        IF @SortBy = 1 -- Category
	BEGIN
	    SELECT * FROM  #TempTrackingFinal 
	    ORDER BY  StyleSubCategory, StyleNo, StyleID, TrdPartnerName,TrdPartnerID, VendorName, TrdPrtVendorID, StyleColorName, smplWorkflowSortNum 
	END
	IF @SortBy = 2 -- Style
	BEGIN
	    SELECT * FROM  #TempTrackingFinal
	    ORDER BY  StyleNo, StyleID, TrdPartnerName,TrdPartnerID, VendorName, TrdPrtVendorID, StyleColorName, smplWorkflowSortNum 
	END
	
END



Drop Table #TempStyleTracking
Drop Table #TempWorkflowSort
Drop Table #TempTrackingFinal

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04273', GetDate())
GO
