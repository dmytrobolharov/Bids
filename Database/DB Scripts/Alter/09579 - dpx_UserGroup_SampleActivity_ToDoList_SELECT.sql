IF OBJECT_ID(N'[dbo].[dpx_UserGroup_SampleActivity_ToDoList_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_UserGroup_SampleActivity_ToDoList_SELECT]
GO


/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Left the old code, though, because it's being used for some other purposes
in this procedure.
*/


--==============================
--  SAMPLE WORKFLOW  TO DO LIST (LATE ONES)

-- Author: Paul Kim, Yunique Solutions
-- ALTER  DATE   date: 5/29/2008

-- =============================================
CREATE PROCEDURE [dbo].[dpx_UserGroup_SampleActivity_ToDoList_SELECT]
	
	 @DateFrom			datetime = NULL
	,@DateTo			datetime = NULL
	--,@ShowStyleWorkflowActivity	int 
	,@SampleWorkflowStatusID	int = -999
	,@Season			nvarchar(200) = NULL
	,@Year				nvarchar(200) = NULL   --- can not be int since pStyleHeader.CustomField4 has '*n/a' 
	--,@StyleSubCategory		nvarchar(200) = NULL  -- pStyleHeader.CustomField5 (Item Category on plmOn)
	,@StyleCategoryID	nvarchar(40) = NULL  -- pStyleCategory.StyleCategoryID (Item Category on plmOn)
	,@GroupID			nvarchar(40) = NULL  -- uniqueidentifier in the table
	,@UserId			int = -999  -- means "all" users
	,@NumDaysToAlert		int = NULL
	,@SortBy			int = NULL

AS
BEGIN
	SET NOCOUNT ON;

DECLARE @UserName 	nvarchar(200)
DECLARE @GroupName	nvarchar(200)
DECLARE @MinSmplWorkflowSort 	int

IF @DateFrom IS NULL  or @DateFrom = ''
BEGIN
   SET @DateFrom = '01/01/1900'
END 

SET @UserName = NULL
SET @UserName = (SELECT LTRIM(RTRIM(FirstName)) + ' ' + LTRIM(RTRIM(LastName))  FROM Users WHERE  UserId = @UserId)


IF @DateTo IS NULL  or @DateTo = ''
BEGIN 
   SET @DateTo= '12/31/2900'
END 


IF  @GroupID IS NULL
	BEGIN
	 SET @GroupID = 'ALL'
	END

IF @GroupID <> 'ALL'
	BEGIN
	 SET @GroupName = (SELECT TOP 1 GroupName FROM uGroup WHERE GroupID = @GroupID)
	END

IF  @UserId IS NULL
BEGIN
 SET @UserId = -999
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

IF @NumDaysToAlert IS  NULL
BEGIN
	SET @NumDaysToAlert = 36500
END

IF @SortBy IS  NULL  or @SortBy = -999
BEGIN
	SET @SortBy =1
END

IF @SampleWorkflowStatusID IS  NULL
BEGIN
	SET @SampleWorkflowStatusID = -999
END






CREATE TABLE #TempSampleActivity
(
	rowNum				bigint IDENTITY
	,AssignedTo			int           -- UserID
	,UserName			nvarchar(200) COLLATE database_default
	,FilePath			nvarchar(300) COLLATE database_default
	,imageShowFlag			int
	,StyleID			uniqueidentifier
	,StyleNo			nvarchar(20) COLLATE database_default
     	,Descrip			nvarchar(100) COLLATE database_default
	,SizeClass			nvarchar(400) COLLATE database_default
	,StyleSet			int
	,StyleStatus			nvarchar(50) COLLATE database_default
	,TradePartnerID			uniqueidentifier
	,TradePartnerName		nvarchar(200) COLLATE database_default
	,TradePartnerVendorID		uniqueidentifier
	,VendorName			nvarchar(200) COLLATE database_default
	,SampleWorkflow			nvarchar(100) COLLATE database_default
	,DueDate			datetime
	,DaysLate			int
	,Status				nvarchar(100) COLLATE database_default
	,StatusID			int
	,alertMessage			nvarchar(50) COLLATE database_default
	,alertColor	        	nvarchar(50) COLLATE database_default
	,StyleYear			nvarchar(200) COLLATE database_default
	,Season				nvarchar(200) COLLATE database_default
	,StyleSubCategory		nvarchar(255) COLLATE database_default
	,smplWorkflowSortNum	 	int
	--,subReportNum			int
)


CREATE TABLE #TempRowNumber
(
	UserName			nvarchar(200) COLLATE database_default
	,StyleNo			nvarchar(20) COLLATE database_default
	,DueDate			datetime
	,DaysLate			int
	,StyleSubCategory		nvarchar(255)  COLLATE database_default
	,minRowNumForStyle		bigint
)

CREATE TABLE #TempWorkflowSort
(
	SampleWorkflowID		nvarchar(5) COLLATE database_default,
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






-- To hide duplicated style images for the all rows with the same sytle number on the report
IF @SortBy = 1  -- by user name / default
    BEGIN 

		INSERT INTO #TempSampleActivity (AssignedTo, UserName, 
						FilePath, imageShowFlag, StyleID, StyleNo, Descrip, 
						SizeClass, StyleSet,StyleStatus,
						TradePartnerID, TradePartnerName, TradePartnerVendorID, VendorName,
						SampleWorkflow, DueDate, DaysLate,
						Status, StatusID,  alertMessage,alertColor,
						StyleYear, Season, StyleSubCategory, SmplWorkflowSortNum
						--subReportNum
						)
		
		SELECT
			w.AssignedTo
			, u.FirstName + ' ' + u.LastName as UserName
			,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
							FROM	pStyleHeader LEFT OUTER JOIN hImage ON
								pStyleHeader.DesignSketchID = hImage.ImageID AND
								pStyleHeader.DesignSketchVersion = hImage.Version
							WHERE pStyleHeader.StyleID = h.StyleID
			) AS FilePath
			,0 as imageShowFlag
			,h.StyleID
			,h.StyleNo
			,h.[Description] as Descrip
			,COALESCE(sc.Custom, h.SizeClass)
			,w.StyleSet
			,ps.Status as StyleStatus
			,w.TradePartnerID, ut.TradePartnerName
			,w.TradePartnerVendorID, uv.VendorName 
			,f.SampleWorkflow
			,w.DueDate
			,DATEDIFF(day, GETDATE(), w.DueDate)  as DaysLate -- temporary. Will be modified at the next step
			,(SELECT TOP 1 LEFT(c.Status, 11) FROM  pSampleRequestSubmitStatus c WHERE  c.StatusID = w.Status)  as Status
			,w.Status as StatusID
			,(CASE WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) = @NumDaysToAlert THEN 
		
					        ' ' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
			       WHEN w.status < 2 and  DATEDIFF(day, GETDATE(), w.DueDate) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.DueDate) >= 0 THEN 
		
						' <' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
			       WHEN  w.status < 2 and  DATEDIFF(day, GETDATE(), w.DueDate) < 0 THEN 
		
						' ' + RTRIM(CAST(DATEDIFF(day, w.DueDate, GETDATE()) AS NVARCHAR(10))) + 'd Late'
		               WHEN (w.status = 2) or (w.status = 3)                         THEN ' Apprvd'
			       WHEN (w.status = 4)                                            THEN ' Dropped'
			  ELSE ''
		          END
			) as alertMessage
			,(CASE WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) = @NumDaysToAlert THEN 'Yellow'
			       WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.DueDate) >= 0 THEN 'Yellow'
			       WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) < 0 THEN 'Red'
		               WHEN (w.status = 2) or (w.status = 3)                         THEN 'Green'
			       WHEN (w.status = 4)                         THEN 'Silver'
			  ELSE ''
		          END
			) as alertColor
			,LTRIM(RTRIM(sy.Year)) as StyleYear
			,LTRIM(RTRIM(sy.Season)) as Season
			--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
			,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
			,tmp.SmplWorkflowSortNum
			--,4 as subReportNum
		from pSampleRequestWorkflow w WITH (NOLOCK)
		INNER JOIN pStyleHeader h ON h.StyleID = w.StyleID 
		LEFT OUTER JOIN uTradePartner ut ON ( (ut.TradePartnerID IS NULL and w.TradePartnerID IS NULL) OR 
						( ut.TradePartnerID = w.TradePartnerID))
	 	LEFT OUTER JOIN uTradePartnerVendor uv ON (((uv.TradePartnerID IS NULL and w.TradePartnerID IS NULL)
		        				OR ( uv.TradePartnerID = w.TradePartnerID))
						and (uv.TradePartnerVendorID = w.TradePartnerVendorID))
		LEFT OUTER JOIN  pSampleWorkflow f ON f.SampleWorkflowID = w.SampleWorkflowID
 		LEFT OUTER JOIN #TempWorkflowSort tmp ON tmp.SampleWorkflowID = w.SampleWorkflowID
		LEFT OUTER JOIN Users u  ON u.UserId = w.AssignedTo
		LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
		LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		LEFT OUTER JOIN pStyleStatus ps ON h.StyleStatusID = ps.StatusID and h.StyleID = w.StyleID
		LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
		LEFT JOIN pSizeClass sc ON sc.CustomID = h.SizeClassId
		INNER JOIN pStyleSeasonYear ssy ON h.StyleID = ssy.StyleID
		INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE	
		       --(w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- SQL2000: NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
		       (   
		              ((w.DueDate > @DateFrom) OR   (DATEDIFF(day,  w.DueDate,  @DateFrom) = 0 ) )  
		               AND
		              ((w.DueDate < @DateTo) OR   (DATEDIFF(day,  w.DueDate,  @DateTo) = 0 ) )            
		        )
		  
		   AND (
			((LTRIM(RTRIM(sy.Year)) = LTRIM(RTRIM(@Year))) OR ( @Year = 'ALL')  )
		       )
		   AND (
			 (LTRIM(RTRIM(sy.Season)) =  LTRIM(RTRIM(@Season))) or ( @Season ='ALL')
		        )
		   AND ( 
		         --(LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
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
		
		    AND (
			  (w.Status = @SampleWorkflowStatusID)
		           OR  
		          (@SampleWorkflowStatusID = -999)  
		       )
		


		GROUP BY w.AssignedTo, u.FirstName, u.LastName, h.StyleNo, h.StyleID,  h.[Description], 
		    COALESCE(sc.Custom, h.SizeClass), w.StyleSet, 
			w.TradePartnerID, ut.TradePartnerName, w.TradePartnerVendorID, uv.VendorName 
        			, ps.StatusID
			, ps.Status, f.SampleWorkflowID, f.SampleWorkflow
        		,w.DueDate, w.Status, sy.Season, 
         		sy.Year, 
			--h.CustomField5, 
			c.StyleCategoryID, c.StyleCategory,
			tmp.SmplWorkflowSortNum

		ORDER BY  u.FirstName, u.LastName, h.StyleNo, h.StyleID,  ut.TradePartnerName, uv.VendorName, 
         			tmp.SmplWorkflowSortNum, f.SampleWorkflow


		-- Set min row num for the style which is grouped and sorted by
		INSERT INTO #TempRowNumber (UserName, StyleNo, DueDate, DaysLate, StyleSubCategory, minRowNumForStyle) 
			SELECT UserName, StyleNo, NULL, 0, NULL, MIN(rowNum) FROM #TempSampleActivity
			GROUP BY UserName, StyleNo ORDER BY  UserName, StyleNo --, SizeClass, StyleSet, WorkSort

		UPDATE s  set imageShowFlag = 1 FROM #TempRowNumber r, #TempSampleActivity s
		WHERE r.StyleNo = s.StyleNo and r.minRowNumForStyle = s.rowNum
				
		UPDATE #TempSampleActivity SET FilePath=NULL
		WHERE imageShowFlag <> 1 or FilePath = ''

		
		SELECT * FROM #TempSampleActivity
		ORDER BY UserName, StyleNo, SizeClass, StyleSet, SmplWorkflowSortNum

   END

IF @SortBy = 2 -- by date
    BEGIN 


		INSERT INTO #TempSampleActivity (AssignedTo, UserName,
						FilePath, imageShowFlag, StyleID, StyleNo, Descrip, 
						SizeClass, StyleSet,StyleStatus,
						TradePartnerID, TradePartnerName, TradePartnerVendorID, VendorName,
						SampleWorkflow, DueDate, DaysLate,
						Status, StatusID,  alertMessage,alertColor,
						StyleYear, Season, StyleSubCategory, SmplWorkflowSortNum
						--subReportNum
						)
		
		SELECT
			w.AssignedTo
			, u.FirstName + ' ' + u.LastName as UserName
			,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
							FROM	pStyleHeader LEFT OUTER JOIN hImage ON
								pStyleHeader.DesignSketchID = hImage.ImageID AND
								pStyleHeader.DesignSketchVersion = hImage.Version
							WHERE pStyleHeader.StyleID = h.StyleID
			) AS FilePath
			,0 as imageShowFlag
			,h.StyleID
			,h.StyleNo
			,h.[Description] as Descrip
			,COALESCE(sc.Custom, h.SizeClass)
			,w.StyleSet
			,ps.Status as StyleStatus
			,w.TradePartnerID, ut.TradePartnerName
			,w.TradePartnerVendorID, uv.VendorName 
			,f.SampleWorkflow
			,w.DueDate
			,DATEDIFF(day, GETDATE(), w.DueDate)  as DaysLate -- temporary. Will be modified at the next step
			,(SELECT TOP 1 LEFT(c.Status, 11) FROM  pSampleRequestSubmitStatus c WHERE  c.StatusID = w.Status)  as Status
			,w.Status as StatusID
			,(CASE WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) = @NumDaysToAlert THEN 
		
					        ' ' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
			       WHEN w.status < 2 and  DATEDIFF(day, GETDATE(), w.DueDate) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.DueDate) >= 0 THEN 
		
						' <' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
			       WHEN  w.status < 2 and  DATEDIFF(day, GETDATE(), w.DueDate) < 0 THEN 
		
						' ' + RTRIM(CAST(DATEDIFF(day, w.DueDate, GETDATE()) AS NVARCHAR(10))) + 'd Late'
		               WHEN (w.status = 2) or (w.status = 3)                         THEN ' Apprvd'
			       WHEN (w.status = 4)                                            THEN ' Dropped'
			  ELSE ''
		          END
			) as alertMessage
			,(CASE WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) = @NumDaysToAlert THEN 'Yellow'
			       WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.DueDate) >= 0 THEN 'Yellow'
			       WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) < 0 THEN 'Red'
		               WHEN (w.status = 2) or (w.status = 3)                         THEN 'Green'
			       WHEN (w.status = 4)                         THEN 'Silver'
			  ELSE ''
		          END
			) as alertColor
			,LTRIM(RTRIM(sy.Year)) as StyleYear
			,LTRIM(RTRIM(sy.Season)) as Season
			--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
			,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
			,tmp.SmplWorkflowSortNum
			--,4 as subReportNum
		from pSampleRequestWorkflow w WITH (NOLOCK)
		INNER JOIN pStyleHeader h ON h.StyleID = w.StyleID 
		LEFT OUTER JOIN uTradePartner ut ON ( (ut.TradePartnerID IS NULL and w.TradePartnerID IS NULL) OR 
						( ut.TradePartnerID = w.TradePartnerID))
	 	LEFT OUTER JOIN uTradePartnerVendor uv ON (((uv.TradePartnerID IS NULL and w.TradePartnerID IS NULL)
		        				OR ( uv.TradePartnerID = w.TradePartnerID))
						and (uv.TradePartnerVendorID = w.TradePartnerVendorID))
		LEFT OUTER JOIN  pSampleWorkflow f ON f.SampleWorkflowID = w.SampleWorkflowID
 		LEFT OUTER JOIN #TempWorkflowSort tmp ON tmp.SampleWorkflowID = w.SampleWorkflowID
		LEFT OUTER JOIN Users u  ON u.UserId = w.AssignedTo
		LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
		LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		LEFT OUTER JOIN pStyleStatus ps ON h.StyleStatusID = ps.StatusID and h.StyleID = w.StyleID
		LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
		LEFT JOIN pSizeClass sc ON sc.CustomID = h.SizeClassId
		INNER JOIN pStyleSeasonYear ssy ON h.StyleID = ssy.StyleID
		INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE	
		       --(w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- SQL2000: NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
		       (   
		              ((w.DueDate > @DateFrom) OR   (DATEDIFF(day,  w.DueDate,  @DateFrom) = 0 ) )  
		               AND
		              ((w.DueDate < @DateTo) OR   (DATEDIFF(day,  w.DueDate,  @DateTo) = 0 ) )            
		        )
		  
		   AND (
			((LTRIM(RTRIM(sy.Year)) = LTRIM(RTRIM(@Year))) OR ( @Year = 'ALL')  )
		       )
		   AND (
			 (LTRIM(RTRIM(sy.Season)) =  LTRIM(RTRIM(@Season))) or ( @Season ='ALL')
		        )
		   AND ( 
		         --(LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 	
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
		
		    AND (
			  (w.Status = @SampleWorkflowStatusID)
		           OR  
		          (@SampleWorkflowStatusID = -999)  
		       )
		


		GROUP BY w.DueDate, w.AssignedTo, u.FirstName, u.LastName, h.StyleNo, h.StyleID,  h.[Description], 
		    COALESCE(sc.Custom, h.SizeClass), w.StyleSet, 
			w.TradePartnerID, ut.TradePartnerName, w.TradePartnerVendorID, uv.VendorName 
        			, ps.StatusID
			, ps.Status, f.SampleWorkflowID, f.SampleWorkflow
        		,w.DueDate, w.Status, sy.Season, 
         		sy.Year, 
			--h.CustomField5,
			c.StyleCategoryID, c.StyleCategory,
			tmp.SmplWorkflowSortNum

		ORDER BY w.DueDate, u.FirstName, u.LastName, h.StyleNo, h.StyleID, ut.TradePartnerName, uv.VendorName, 
         			tmp.SmplWorkflowSortNum, f.SampleWorkflow


		-- Set min row num for the style which is grouped and sorted by
		INSERT INTO #TempRowNumber (UserName, StyleNo, DueDate, DaysLate, StyleSubCategory, minRowNumForStyle) 
			SELECT UserName, StyleNo, NULL, 0, NULL, MIN(rowNum) FROM #TempSampleActivity
			GROUP BY UserName, StyleNo ORDER BY  UserName, StyleNo --, SizeClass, StyleSet, WorkSort
		
		UPDATE s  set imageShowFlag = 1 FROM #TempRowNumber r, #TempSampleActivity s
		WHERE r.StyleNo = s.StyleNo and r.minRowNumForStyle = s.rowNum
				
		UPDATE #TempSampleActivity SET FilePath=NULL
		WHERE imageShowFlag <> 1 or FilePath = ''

		SELECT * FROM #TempSampleActivity
		ORDER BY DueDate, StyleNo, SizeClass, StyleSet, SmplWorkflowSortNum

   	END



IF @SortBy = 3 -- by dayslate

	BEGIN 
		INSERT INTO #TempSampleActivity (AssignedTo, UserName, 
						FilePath, imageShowFlag, StyleID, StyleNo, Descrip, 
						SizeClass, StyleSet,StyleStatus,
						TradePartnerID, TradePartnerName, TradePartnerVendorID, VendorName,
						SampleWorkflow, DueDate, DaysLate,
						Status, StatusID,  alertMessage,alertColor,
						StyleYear, Season, StyleSubCategory, SmplWorkflowSortNum
						--subReportNum
						)
		
		SELECT
			w.AssignedTo
			, u.FirstName + ' ' + u.LastName as UserName
			,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
							FROM	pStyleHeader LEFT OUTER JOIN hImage ON
								pStyleHeader.DesignSketchID = hImage.ImageID AND
								pStyleHeader.DesignSketchVersion = hImage.Version
							WHERE pStyleHeader.StyleID = h.StyleID
			) AS FilePath
			,0 as imageShowFlag
			,h.StyleID
			,h.StyleNo
			,h.[Description] as Descrip
			,COALESCE(sc.Custom, h.SizeClass)
			,w.StyleSet
			,ps.Status as StyleStatus
			,w.TradePartnerID, ut.TradePartnerName
			,w.TradePartnerVendorID, uv.VendorName 
			,f.SampleWorkflow
			,w.DueDate
			,DATEDIFF(day, GETDATE(), w.DueDate)  as DaysLate -- temporary. Will be modified at the next step
			,(SELECT TOP 1 LEFT(c.Status, 11) FROM  pSampleRequestSubmitStatus c WHERE  c.StatusID = w.Status)  as Status
			,w.Status as StatusID
			,(CASE WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) = @NumDaysToAlert THEN 
		
					        ' ' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
			       WHEN w.status < 2 and  DATEDIFF(day, GETDATE(), w.DueDate) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.DueDate) >= 0 THEN 
		
						' <' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
			       WHEN  w.status < 2 and  DATEDIFF(day, GETDATE(), w.DueDate) < 0 THEN 
		
						' ' + RTRIM(CAST(DATEDIFF(day, w.DueDate, GETDATE()) AS NVARCHAR(10))) + 'd Late'
		               WHEN (w.status = 2) or (w.status = 3)                         THEN ' Apprvd'
			       WHEN (w.status = 4)                                            THEN ' Dropped'
			  ELSE ''
		          END
			) as alertMessage
			,(CASE WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) = @NumDaysToAlert THEN 'Yellow'
			       WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.DueDate) >= 0 THEN 'Yellow'
			       WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) < 0 THEN 'Red'
		               WHEN (w.status = 2) or (w.status = 3)                         THEN 'Green'
			       WHEN (w.status = 4)                         THEN 'Silver'
			  ELSE ''
		          END
			) as alertColor
			,LTRIM(RTRIM(sy.Year)) as StyleYear
			,LTRIM(RTRIM(sy.Season)) as Season
			--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
			,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
			,tmp.SmplWorkflowSortNum
			--,4 as subReportNum
		from pSampleRequestWorkflow w WITH (NOLOCK)
		INNER JOIN pStyleHeader h ON h.StyleID = w.StyleID 
		LEFT OUTER JOIN uTradePartner ut ON ( (ut.TradePartnerID IS NULL and w.TradePartnerID IS NULL) OR 
						( ut.TradePartnerID = w.TradePartnerID))
	 	LEFT OUTER JOIN uTradePartnerVendor uv ON (((uv.TradePartnerID IS NULL and w.TradePartnerID IS NULL)
		        				OR ( uv.TradePartnerID = w.TradePartnerID))
						and (uv.TradePartnerVendorID = w.TradePartnerVendorID))
		LEFT OUTER JOIN  pSampleWorkflow f ON f.SampleWorkflowID = w.SampleWorkflowID
 		LEFT OUTER JOIN #TempWorkflowSort tmp ON tmp.SampleWorkflowID = w.SampleWorkflowID
		LEFT OUTER JOIN Users u  ON u.UserId = w.AssignedTo
		LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
		LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		LEFT OUTER JOIN pStyleStatus ps ON h.StyleStatusID = ps.StatusID and h.StyleID = w.StyleID
		LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
		LEFT JOIN pSizeClass sc ON sc.CustomID = h.SizeClassId
		INNER JOIN pStyleSeasonYear ssy ON h.StyleID = ssy.StyleID
		INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE	
		       --(w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- SQL2000: NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
		       (   
		              ((w.DueDate > @DateFrom) OR   (DATEDIFF(day,  w.DueDate,  @DateFrom) = 0 ) )  
		               AND
		              ((w.DueDate < @DateTo) OR   (DATEDIFF(day,  w.DueDate,  @DateTo) = 0 ) )            
		        )
		  
		   AND (
			((LTRIM(RTRIM(sy.Year)) = LTRIM(RTRIM(@Year))) OR ( @Year = 'ALL')  )
		       )
		   AND (
			 (LTRIM(RTRIM(sy.Season)) =  LTRIM(RTRIM(@Season))) or ( @Season ='ALL')
		        )
		   AND ( 
		         --(LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
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
		
		    AND (
			  (w.Status = @SampleWorkflowStatusID)
		           OR  
		          (@SampleWorkflowStatusID = -999)  
		       )
		


		GROUP BY DATEDIFF(day, GETDATE(), w.DueDate), w.AssignedTo, u.FirstName, u.LastName, h.StyleNo, h.StyleID,  h.[Description], 
		    COALESCE(sc.Custom, h.SizeClass), w.StyleSet, 
			w.TradePartnerID, ut.TradePartnerName, w.TradePartnerVendorID, uv.VendorName 
        			, ps.StatusID
			, ps.Status, f.SampleWorkflowID, f.SampleWorkflow
        		,w.DueDate, w.Status, sy.Season, 
         		sy.Year, 
			--h.CustomField5, 
			 c.StyleCategoryID, c.StyleCategory,
			tmp.SmplWorkflowSortNum

		ORDER BY DATEDIFF(day, GETDATE(), w.DueDate), u.FirstName, u.LastName, h.StyleNo, h.StyleID,  ut.TradePartnerName, uv.VendorName, 
         			tmp.SmplWorkflowSortNum, f.SampleWorkflow


		-- Set min row num for the style which is grouped and sorted by
		INSERT INTO #TempRowNumber (UserName, StyleNo, DueDate, DaysLate, StyleSubCategory, minRowNumForStyle) 
			SELECT UserName, StyleNo, NULL, 0, NULL, MIN(rowNum) FROM #TempSampleActivity
			GROUP BY DaysLate, UserName, StyleNo ORDER BY  DaysLate, UserName, StyleNo --, SizeClass, StyleSet, WorkSort
		
				UPDATE s  set imageShowFlag = 1 FROM #TempRowNumber r, #TempSampleActivity s
		WHERE r.StyleNo = s.StyleNo and r.minRowNumForStyle = s.rowNum
				
		UPDATE #TempSampleActivity SET FilePath=NULL
		WHERE imageShowFlag <> 1 or FilePath = ''

		SELECT * FROM #TempSampleActivity
		ORDER BY DaysLate, UserName, StyleNo, SizeClass, StyleSet, SmplWorkflowSortNum
	 END

IF @SortBy = 4 -- by category

	BEGIN 
		INSERT INTO #TempSampleActivity (AssignedTo, UserName, 
						FilePath, imageShowFlag, StyleID, StyleNo, Descrip, 
						SizeClass, StyleSet,StyleStatus,
						TradePartnerID, TradePartnerName, TradePartnerVendorID, VendorName,
						SampleWorkflow, DueDate, DaysLate,
						Status, StatusID,  alertMessage,alertColor,
						StyleYear, Season, StyleSubCategory, SmplWorkflowSortNum
						--subReportNum
						)
		
		SELECT
			w.AssignedTo
			, u.FirstName + ' ' + u.LastName as UserName
			,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
							FROM	pStyleHeader LEFT OUTER JOIN hImage ON
								pStyleHeader.DesignSketchID = hImage.ImageID AND
								pStyleHeader.DesignSketchVersion = hImage.Version
							WHERE pStyleHeader.StyleID = h.StyleID
			) AS FilePath
			,0 as imageShowFlag
			,h.StyleID
			,h.StyleNo
			,h.[Description] as Descrip
			,COALESCE(sc.Custom, h.SizeClass)
			,w.StyleSet
			,ps.Status as StyleStatus
			,w.TradePartnerID, ut.TradePartnerName
			,w.TradePartnerVendorID, uv.VendorName 
			,f.SampleWorkflow
			,w.DueDate
			,DATEDIFF(day, GETDATE(), w.DueDate)  as DaysLate 
			,(SELECT TOP 1 LEFT(c.Status, 11) FROM  pSampleRequestSubmitStatus c WHERE  c.StatusID = w.Status)  as Status
			,w.Status as StatusID
			,(CASE WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) = @NumDaysToAlert THEN 
		
					        ' ' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
			       WHEN w.status < 2 and  DATEDIFF(day, GETDATE(), w.DueDate) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.DueDate) >= 0 THEN 
		
						' <' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
			       WHEN  w.status < 2 and  DATEDIFF(day, GETDATE(), w.DueDate) < 0 THEN 
		
						' ' + RTRIM(CAST(DATEDIFF(day, w.DueDate, GETDATE()) AS NVARCHAR(10))) + 'd Late'
		               WHEN (w.status = 2) or (w.status = 3)                         THEN ' Apprvd'
			       WHEN (w.status = 4)                                            THEN ' Dropped'
			  ELSE ''
		          END
			) as alertMessage
			,(CASE WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) = @NumDaysToAlert THEN 'Yellow'
			       WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.DueDate) >= 0 THEN 'Yellow'
			       WHEN w.status < 2 and DATEDIFF(day, GETDATE(), w.DueDate) < 0 THEN 'Red'
		               WHEN (w.status = 2) or (w.status = 3)                         THEN 'Green'
			       WHEN (w.status = 4)                         THEN 'Silver'
			  ELSE ''
		          END
			) as alertColor
			,LTRIM(RTRIM(sy.Year)) as StyleYear
			,LTRIM(RTRIM(sy.Season)) as Season
			--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
			,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
			,tmp.SmplWorkflowSortNum
			--,4 as subReportNum
		from pSampleRequestWorkflow w WITH (NOLOCK)
		INNER JOIN pStyleHeader h ON h.StyleID = w.StyleID 
		LEFT OUTER JOIN uTradePartner ut ON ( (ut.TradePartnerID IS NULL and w.TradePartnerID IS NULL) OR 
						( ut.TradePartnerID = w.TradePartnerID))
	 	LEFT OUTER JOIN uTradePartnerVendor uv ON (((uv.TradePartnerID IS NULL and w.TradePartnerID IS NULL)
		        				OR ( uv.TradePartnerID = w.TradePartnerID))
						and (uv.TradePartnerVendorID = w.TradePartnerVendorID))
		LEFT OUTER JOIN  pSampleWorkflow f ON f.SampleWorkflowID = w.SampleWorkflowID
 		LEFT OUTER JOIN #TempWorkflowSort tmp ON tmp.SampleWorkflowID = w.SampleWorkflowID
		LEFT OUTER JOIN Users u  ON u.UserId = w.AssignedTo
		LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
		LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		LEFT OUTER JOIN pStyleStatus ps ON h.StyleStatusID = ps.StatusID and h.StyleID = w.StyleID
		LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
		LEFT JOIN pSizeClass sc ON sc.CustomID = h.SizeClassId
		INNER JOIN pStyleSeasonYear ssy ON h.StyleID = ssy.StyleID
		INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE	
		       --(w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- SQL2000: NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
		       (   
		              ((w.DueDate > @DateFrom) OR   (DATEDIFF(day,  w.DueDate,  @DateFrom) = 0 ) )  
		               AND
		              ((w.DueDate < @DateTo) OR   (DATEDIFF(day,  w.DueDate,  @DateTo) = 0 ) )            
		        )
		  
		   AND (
			((LTRIM(RTRIM(sy.Year)) = LTRIM(RTRIM(@Year))) OR ( @Year = 'ALL')  )
		       )
		   AND (
			 (LTRIM(RTRIM(sy.Season)) =  LTRIM(RTRIM(@Season))) or ( @Season ='ALL')
		        )
		   AND ( 
		         --(LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
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
		
		    AND (
			  (w.Status = @SampleWorkflowStatusID)
		           OR  
		          (@SampleWorkflowStatusID = -999)  
		       )
		


		GROUP BY 
			--LTRIM(RTRIM(h.CustomField5)), 
			c.StyleCategory,w.AssignedTo,
			u.FirstName, u.LastName,  h.StyleNo, h.StyleID,  h.[Description], 
			COALESCE(sc.Custom, h.SizeClass), w.StyleSet, 
			w.TradePartnerID, ut.TradePartnerName, w.TradePartnerVendorID, uv.VendorName
        			,ps.StatusID
			, ps.Status, f.SampleWorkflowID, f.SampleWorkflow
        		,w.DueDate, w.Status, sy.Season, 
         		sy.Year, 
			--h.CustomField5, 
			 c.StyleCategoryID, c.StyleCategory,
			tmp.SmplWorkflowSortNum

		ORDER BY 
			--LTRIM(RTRIM(h.CustomField5))
			c.StyleCategory
			,UserName, h.StyleNo, h.StyleID, ut.TradePartnerName, uv.VendorName, 
         			tmp.SmplWorkflowSortNum, f.SampleWorkflow


		-- Set min row num for the style which is grouped and sorted by
		INSERT INTO #TempRowNumber (UserName, StyleNo, DueDate, DaysLate, StyleSubCategory, minRowNumForStyle) 
			SELECT UserName, StyleNo, NULL, 0, NULL, MIN(rowNum) FROM #TempSampleActivity
			GROUP BY StyleSubCategory, UserName, StyleNo ORDER BY  StyleSubCategory, UserName, StyleNo --, SizeClass, StyleSet, WorkSort

		
		UPDATE s  set imageShowFlag = 1 FROM #TempRowNumber r, #TempSampleActivity s
		WHERE r.StyleNo = s.StyleNo and r.minRowNumForStyle = s.rowNum
				
		UPDATE #TempSampleActivity SET FilePath=NULL
		WHERE imageShowFlag <> 1 or FilePath = ''
		
		SELECT * FROM #TempSampleActivity
		ORDER BY StyleSubCategory, UserName, StyleNo, SizeClass, StyleSet, SmplWorkflowSortNum
	END

DROP TABLE #TempSampleActivity

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09579', GetDate())
GO
