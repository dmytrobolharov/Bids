IF OBJECT_ID(N'[dbo].[dpx_BusinessUsersGroup_ActivityTracking_Summary_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_BusinessUsersGroup_ActivityTracking_Summary_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_BusinessUsersGroup_ActivityTracking_Summary_SELECT]
	
	 @DateFrom			datetime = NULL
	,@DateTo			datetime = NULL
	,@ShowStyleDevelWorkflow	int = NULL
	,@ShowTechPackActivity		int = NULL
	,@ShowQuotationActivity		int = NULL
	,@ShowStyleWorkflowActivity	int = NULL
	,@Season			nvarchar(200) = NULL
	,@Year				nvarchar(200) = NULL   --- can not be int since pStyleHeader.CustomField4 may have '*n/a' 
	--,@StyleSubCategory		nvarchar(200) = NULL  -- pStyleHeader.CustomField5 (Item Category on plmOn)
	,@StyleCategoryID		nvarchar(40) = NULL  -- pStyleCategory.StyleCategoryID (Item Category on plmOn)
	,@GroupID			nvarchar(40) = NULL  -- uniqueidentifier in the table
	,@UserId			int = -999  -- means "all" users
	


AS

DECLARE @MinSmplWorkflowSort 	int
DECLARE @UserName 		nvarchar(200)
DECLARE @GroupName 		nvarchar(200)


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;

IF @ShowStyleDevelWorkflow IS NULL
BEGIN
    SET @ShowStyleDevelWorkflow = 1
END

IF @ShowTechPackActivity IS NULL
BEGIN
	SET @ShowTechPackActivity = 1
END


IF @ShowQuotationActivity IS NULL
BEGIN
	SET @ShowQuotationActivity = 1
END


IF @ShowStyleWorkflowActivity IS NULL
BEGIN
	SET @ShowStyleWorkflowActivity = 1
END


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


IF @UserId = -999 or @UserId IS NULL
BEGIN
 SET @UserName = 'ALL'
  SET @UserId = -999
END
ELSE
BEGIN
 SET @UserName = (SELECT LTRIM(RTRIM(FirstName)) + ' ' + LTRIM(RTRIM(LastName))  FROM Users WHERE  UserId = @UserId)
END

IF  @GroupID IS NULL
	BEGIN
	 SET @GroupID = 'ALL'
	END

IF @GroupID <> 'ALL'
	BEGIN
	 SET @GroupName = (SELECT TOP 1 GroupName FROM uGroup WHERE GroupID = @GroupID)
	END



-- For counting summary on tables and charts
CREATE TABLE #TempActivitySummary
(

UserName		nvarchar(200)
,UserId			int
,GroupID		uniqueidentifier
,GroupName		nvarchar(200)
,subReportNum	 	int
,StyleYear		nvarchar(200)
,Season			nvarchar(200)
--,StyleSubCategory	nvarchar(200)
,StyleSubCategory	nvarchar(255)
)


CREATE TABLE #TempWorkflowSort
(
	SampleWorkflowID		nvarchar(5),
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


-------------- SUB 111111111111111111111111111111111111111111111111111111111111111111111111111 -------------------
IF @ShowStyleDevelWorkflow = 1 
BEGIN
	INSERT INTO #TempActivitySummary ( UserName,UserId, subReportNum, 
					StyleYear, Season, StyleSubCategory  )
	SELECT 	u.FirstName + ' ' + u.LastName as UserName
		,w.WorkAssignedTo as UserId
		,1 as subReportNum
		,LTRIM(RTRIM(h.CustomField4)) as StyleYear
		,LTRIM(RTRIM(h.CustomField2)) as Season
		--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
		,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
	
	FROM  pStyleWorkflow w WITH (NOLOCK)
	INNER JOIN pStyleHeader h ON h.StyleID = w.StyleID 
    LEFT JOIN pSizeClass sc ON sc.CustomID = h.SizeClassId
	INNER JOIN Mapping  b ON b.Map = w.WorkflowID  
	INNER JOIN pWorkflowTemplateItem t ON  t.WorkflowID  = b.Map and t.WorkflowTemplateID = h.StyleWorkflowID 	
	INNER JOIN pWorkflowStatus s ON s.WorkflowStatusID = w.WorkStatus
	
	LEFT OUTER JOIN pStyleDevelopment d ON d.StyleDevelopmentID  = h.DevelopmentID
	LEFT OUTER JOIN pWorkflow p ON p.WorkflowID = w.WorkflowID
	LEFT OUTER JOIN Users u  ON u.UserId = w.WorkAssignedTo 
	
        LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
	LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
	LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
	WHERE	
	       --(w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- SQL2000: NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
              (   
                  ((w.WorkDue > @DateFrom) OR   (DATEDIFF(day,  w.WorkDue,  @DateFrom) = 0 ) )  
                   AND
                  ((w.WorkDue < @DateTo) OR   (DATEDIFF(day,  w.WorkDue,  @DateTo) = 0 ) )            
               )
	   AND (
		((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR ( LTRIM(RTRIM(@Season)) = 'ALL'))
	       )
	   AND (
		 (LTRIM(RTRIM(h.CustomField4)) =  LTRIM(RTRIM(@Year))) or ( LTRIM(RTRIM(@Year)) ='ALL')
	        )
	   AND ( 
	         --(LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
		 (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL')
	       )
	   AND (
		  (w.WorkAssignedTo = @UserId)
	           OR  
	          (@UserId = -999)   --- -999 means "all users"
	       )
	   AND (
	       (CAST(g.GroupID AS nvarchar(40)) = @GroupID)
                  OR  
                (@GroupID = 'ALL')  
            )
	   --AND  
		--h.StyleNo = 'ZPHO08W01'
	 GROUP BY w.WorkAssignedTo
		, u.FirstName, u.LastName 
		,h.StyleID
		,h.StyleNo
		,h.[Description]
		, COALESCE(sc.Custom, h.SizeClass)
		, w.StyleSet
		, w.WorkSort
		, t.WorkflowSort
		--, w.StyleWorkflowID
		, w.workflowID
		, p.Workflow
		, w.WorkDue
		, w.WorkStatusDate
		,DATEDIFF(d, w.WorkDue, GETDATE())
		,LTRIM(RTRIM(h.CustomField4)) 
		,LTRIM(RTRIM(h.CustomField2)) 
		--,LTRIM(RTRIM(h.CustomField5)) 
		,c.StyleCategoryID, c.StyleCategory
		,w.WorkSort
	ORDER BY 	UserName
END


---- SUB 2222222222222222222222222222222222222222222222222222222222222222222222222222 --------------------------

IF @ShowTechPackActivity = 1
BEGIN
	INSERT INTO #TempActivitySummary (	
			UserName
			,UserId
			,subReportNum
			,StyleYear
			,Season
			,StyleSubCategory
		)
	SELECT  
	        LTRIM(RTRIM(p.CUser)) as UserName 
		,(SELECT TOP 1 u.UserId FROM Users u WHERE LTRIM(RTRIM(u.FirstName)) + ' ' + LTRIM(RTRIM(u.LastName)) = p.CUser)  as UserId  
		,2 as subReportNum
		,LTRIM(RTRIM(h.CustomField4)) as StyleYear
		,LTRIM(RTRIM(h.CustomField2)) as Season
		--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
		,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
	
	FROM pSampleRequestWorkflow w WITH (NOLOCK)
		 INNER JOIN  pStyleHeader h ON h.StyleID = w.StyleID
	    	 LEFT OUTER JOIN uTradePartner ut ON ( (ut.TradePartnerID IS NULL and w.TradePartnerID IS NULL)
			        				     OR 
							( ut.TradePartnerID = w.TradePartnerID))
		 LEFT OUTER JOIN uTradePartnerVendor uv ON (((uv.TradePartnerID IS NULL and w.TradePartnerID IS NULL)
			        				OR ( uv.TradePartnerID = w.TradePartnerID))
							and (uv.TradePartnerVendorID = w.TradePartnerVendorID))
		 
		 LEFT OUTER JOIN  pTechPack    p ON ((p.TechPackID = h.TechPackID) and (h.StyleID = p.StyleID))
		 LEFT OUTER JOIN Users u  ON (LTRIM(RTRIM(u.FirstName)) + ' ' + LTRIM(RTRIM(u.LastName))) = p.CUser
	 	 LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
	 	 LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		 LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
	WHERE	
	       (w.DueDate >= @DateFrom and w.DueDate <= @DateTo )
	   AND (
		((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR ( LTRIM(RTRIM(@Season)) = 'ALL'))
	       )
	   AND (
		 --(CAST(h.CustomField4 AS int) = @Year) or (@Year IS NULL)  ---h.CustomField4 has '*n/a' 
		 (LTRIM(RTRIM(h.CustomField4)) =  LTRIM(RTRIM(@Year))) or ( LTRIM(RTRIM(@Year)) ='ALL')
	        )
	   AND ( 
	         --(LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
		 (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL')
	       )
	   AND (
		  (LTRIM(RTRIM(p.CUser)) =  LTRIM(RTRIM(@UserName))) OR  ( LTRIM(RTRIM(@UserName))  = 'ALL') 
	       )
     	   AND (
	 	 (CAST(g.GroupID AS nvarchar(40)) = @GroupID)
          	 OR  
          	(@GroupID = 'ALL')  
       	       )
			
	GROUP BY 
		--w.TradePartnerID
		--, ut.TradePartnerName
		--, w.TradePartnerVendorID
		--, uv.VendorName
		p.CUser
		, w.StyleID, h.StyleNo, 
		h.[Description],
		p.TechPackID,p.TechPackNo, p.TechPackName, h.TechPackID, h.TechPackDate, h.CustomField4,
	         h.CustomField2, 
		--h.CustomField5
		 c.StyleCategoryID, c.StyleCategory
	ORDER BY 
		p.CUser
END





-------- SUB 33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333 -----------


IF @ShowQuotationActivity = 1

BEGIN
	INSERT INTO #TempActivitySummary (
		 UserName,  UserId, subReportNum, StyleYear, Season,  StyleSubCategory 
		 )
	SELECT  
	 	LTRIM(RTRIM(q.CUser)) as UserName
		,(SELECT TOP 1 u.UserId FROM Users u WHERE LTRIM(RTRIM(u.FirstName)) + ' ' + LTRIM(RTRIM(u.LastName)) = q.CUser)  as UserId  
		,3 As subReportName
		,LTRIM(RTRIM(h.CustomField4)) as StyleYear
		,LTRIM(RTRIM(h.CustomField2)) as Season
		--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
		,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
	FROM pSampleRequestWorkflow w WITH (NOLOCK)
		 INNER JOIN  pStyleHeader h ON h.StyleID = w.StyleID
	    	 LEFT OUTER JOIN uTradePartner ut ON ( (ut.TradePartnerID IS NULL and w.TradePartnerID IS NULL) OR 
							( ut.TradePartnerID = w.TradePartnerID))
		 LEFT OUTER JOIN uTradePartnerVendor uv ON (((uv.TradePartnerID IS NULL and w.TradePartnerID IS NULL)
			        				OR ( uv.TradePartnerID = w.TradePartnerID))
							and (uv.TradePartnerVendorID = w.TradePartnerVendorID))
		
		 LEFT OUTER JOIN  pStyleQuoteItem   q ON 
				(
					(w.StyleID = q.StyleID)
				    and (w.TradePartnerID = q.TradePartnerID) 
			            and (w.TradePartnerVendorID = q.TradePartnerVendorID)
				)

		LEFT OUTER JOIN Users u  ON (LTRIM(RTRIM(u.FirstName)) + ' ' + LTRIM(RTRIM(u.LastName))) = q.CUser
	 	LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
	 	LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
	WHERE	
	       (w.DueDate >= @DateFrom and w.DueDate <= @DateTo )
	   AND (
		((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR (LTRIM(RTRIM(@Season))  = 'ALL'))
	       )
	   AND (
		 --(CAST(h.CustomField4 AS int) = @Year) or (@Year IS NULL)  ---h.CustomField4 has '*n/a' 
		 (LTRIM(RTRIM(h.CustomField4)) = LTRIM(RTRIM(@Year))) or (LTRIM(RTRIM(@Year))  = 'ALL')
	        )
	   AND ( 
	         --(LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (LTRIM(RTRIM(@StyleSubCategory))  = 'ALL') 
		(LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL')
	       )
	   AND (
		  (LTRIM(RTRIM(q.CUser)) = LTRIM(RTRIM(@UserName))) OR  (LTRIM(RTRIM(@UserName)) = 'ALL') 
	       )
           AND (
	            (CAST(g.GroupID AS nvarchar(40)) = @GroupID)
                 OR  
                (@GroupID = 'ALL')  
               )
	   
		
	GROUP BY q.CUser
		, w.TradePartnerID
		, ut.TradePartnerName
		, w.TradePartnerVendorID
		, uv.VendorName
		, w.StyleID, h.StyleNo, 
		 h.[Description], q.StyleQuoteItemNo,  q.StyleQuoteItemStatusId, q.StyleQuoteItemDueDate, h.CustomField4,
	         h.CustomField2, 
		--h.CustomField5
		c.StyleCategoryID, c.StyleCategory
	ORDER BY UserName,  
	        h.CustomField4, h.CustomField2, 
		--h.CustomField5
		c.StyleCategory

END



------------- SUB 44444444444444444444444444444444444444444444444444444444444444444444444444444444444444 ----------
IF @ShowStyleWorkflowActivity = 1
BEGIN
	INSERT INTO #TempActivitySummary (	 UserName, UserId,subReportNum, StyleYear, Season,  StyleSubCategory )
	SELECT  
		LTRIM(RTRIM(u.FirstName)) + ' ' + LTRIM(RTRIM(u.LastName)) as UserName
	 	,w.AssignedTo as UserId
		,4 as subReportNum
		,LTRIM(RTRIM(h.CustomField4)) as StyleYear
		,LTRIM(RTRIM(h.CustomField2)) as Season
		--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
		,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
	FROM pSampleRequestWorkflow w WITH (NOLOCK)
		 INNER JOIN  pStyleHeader h ON h.StyleID = w.StyleID
	    	 LEFT OUTER JOIN uTradePartner ut ON ( (ut.TradePartnerID IS NULL and w.TradePartnerID IS NULL) OR 
							( ut.TradePartnerID = w.TradePartnerID))
		 LEFT OUTER JOIN uTradePartnerVendor uv ON (((uv.TradePartnerID IS NULL and w.TradePartnerID IS NULL)
			        				OR ( uv.TradePartnerID = w.TradePartnerID))
							and (uv.TradePartnerVendorID = w.TradePartnerVendorID))
		 LEFT OUTER JOIN  pSampleWorkflow f ON f.SampleWorkflowID = w.SampleWorkflowID
	 	 LEFT OUTER JOIN #TempWorkflowSort tmp  	ON tmp.SampleWorkflowID = w.SampleWorkflowID
		 LEFT OUTER JOIN Users u ON u.UserId = w.AssignedTo

		 LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
	 	 LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		 LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
	WHERE	
	        (   
		  (w.DueDate >= @DateFrom) and (w.DueDate <= @DateTo )
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
	          --(   LTRIM(RTRIM(@StyleSubCategory)) = 'ALL'   ) 
		  (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL')
		
	        )
	
	   AND (
		  (w.AssignedTo = @UserId)
	           OR  
	          (@UserId = -999)   --- -999 means "all users"
	       )
	   AND (
	 	 (CAST(g.GroupID AS nvarchar(40)) = @GroupID)
           	OR  
          	(@GroupID = 'ALL')  
      	    )
	GROUP BY w.AssignedTo, u.FirstName, u.LastName, h.StyleNo, w.StyleID,  h.[Description], w.StyleColorID, w.TradePartnerID, ut.TradePartnerName, w.TradePartnerVendorID, uv.VendorName, 
	         f.SampleWorkflowID, f.SampleWorkflow
	         , w.DueDate, w.Status, h.CustomField4,  
	         h.CustomField2, 
		 --h.CustomField5, 
		   c.StyleCategoryID, c.StyleCategory,
		 tmp.SmplWorkflowSortNum
	ORDER BY UserName, h.StyleNo, w.StyleID, w.StyleColorID, ut.TradePartnerName, uv.VendorName, 
	         tmp.SmplWorkflowSortNum, f.SampleWorkflow
END



----------------------------------------------------------------------------------------------------------------

IF (@GroupID <> 'ALL') and (@GroupID IS NOT NULL)
	BEGIN
		UPDATE #TempActivitySummary SET  GroupID =  CAST(@GroupID AS uniqueidentifier), GroupName = @GroupName
	END
ELSE
	BEGIN
		UPDATE #TempActivitySummary SET GroupName = 'ALL'
	END


SELECT 
CASE WHEN UserName IS NULL THEN CAST(UserId AS nvarchar(200))
ELSE UserName
END As
UserName, 
UserId, 
subReportNum, StyleYear, Season, StyleSubCategory 
FROM #TempActivitySummary 
WHERE UserId IS NOT NULL and  UserID <> '' and UserName IS NOT NULL and UserName <> '' 
   --AND StyleYear IS NOT NULL and StyleYear <> '' 
   --AND Season IS NOT NULL
Order by UserId, UserName, subReportNum, StyleYear, Season, StyleSubCategory


DROP TABLE #TempActivitySummary
DROP TABLE #TempWorkflowSort
END

SET NOCOUNT OFF

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09547', GetDate())
GO
