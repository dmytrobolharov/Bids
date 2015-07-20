/****** Object:  StoredProcedure [dbo].[dpx_UserGroup_StyleActivity_ToDoList_SELECT]    Script Date: 08/03/2012 17:37:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_UserGroup_StyleActivity_ToDoList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_UserGroup_StyleActivity_ToDoList_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[dpx_UserGroup_StyleActivity_ToDoList_SELECT]    Script Date: 08/03/2012 17:37:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Left the old code, though, because it's being used for some other purposes
in this procedure.
*/



--==============================
--  STYLE DEVELOPMENT WORKFLOW  TO DO LIST (LATE ONES)

-- Author: Paul Kim, Yunique Solutions
-- ALTER   date: 5/29/2008

-- =============================================
CREATE                          PROCEDURE [dbo].[dpx_UserGroup_StyleActivity_ToDoList_SELECT]
	
	 @DateFrom			datetime = NULL
	,@DateTo			datetime = NULL
	--,@ShowStyleDevelWorkflow	int
	,@DevWorkflowStatus		int = NULL
	,@Season			nvarchar(200) = NULL
	,@Year				nvarchar(200) = NULL   --- can not be int since pStyleHeader.CustomField4 has '*n/a' 
	--,@StyleSubCategory		nvarchar(200) = NULL  -- pStyleHeader.CustomField5 (Item Category on plmOn)
	,@StyleCategoryID		nvarchar(40) = NULL  -- pStyleCategory.StyleCategoryID (Item Category on plmOn)
	,@GroupID			nvarchar(40) = NULL  -- uniqueidentifier in the table
	,@UserId			int = -999  -- means "all" users
	,@NumDaysToAlert		int = NULL
	,@SortBy			int = NULL

AS
BEGIN
	SET NOCOUNT ON;

DECLARE @UserName 	nvarchar(200)
DECLARE @GroupName	nvarchar(200)

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
	SET @NumDaysToAlert = 0
END

IF @SortBy IS  NULL
BEGIN
	SET @SortBy =1
END

IF @DevWorkflowStatus IS  NULL
BEGIN
	SET @DevWorkflowStatus = -999
END

CREATE TABLE #TempStyleDevelopment
(
	rowNum				bigint IDENTITY
	,WorkAssignedTo			int           -- UserID
	,UserName			nvarchar(200)
	,GroupID			uniqueidentifier
	,GroupName			nvarchar(200)
	,FilePath			nvarchar(300) 
	,imageShowFlag			int
	,StyleID			uniqueidentifier
	,StyleNo			nvarchar(20)
     	,Descrip			nvarchar(100)
	,SizeClass			nvarchar(50)
	,StyleSet			int
	,StyleStatus			nvarchar(50)
	--,StyleWorkflowID		uniqueidentifier
	,WorkflowID			uniqueidentifier
	,Workflow			nvarchar(100)
	,WorkDue			datetime
	,CompleteDate			datetime
	,DaysLate			int
	,WorkflowStatus			nvarchar(100)
	,WorkflowStatusID		int
	,alertMessage			nvarchar(50)
	,alertColor	        	nvarchar(50)
	,StyleYear			nvarchar(200)
	,Season				nvarchar(200)
	--,StyleSubCategory		nvarchar(200)
	,StyleSubCategory		nvarchar(255)
	,WorkSort			int
	--,subReportNum			int
)


CREATE TABLE #TempRowNumber
(
	UserName			nvarchar(200)
	,StyleNo			nvarchar(20) 
	,WorkDue			datetime
	,DaysLate			int
	--,StyleSubCategory		nvarchar(200)
	,StyleSubCategory		nvarchar(255)
	,minRowNumForStyle		bigint
)




/* Replaced by ds_information_GroupName  dataset on Dash_BusinessUsersGroup_ActivityTracking_Body_PLT.rdl
IF (@GroupID <> 'ALL') and (@GroupID IS NOT NULL)
       BEGIN
		UPDATE #TempStyleDevelopment SET  GroupID =  CAST(@GroupID AS uniqueidentifier), GroupName = @GroupName
	END
ELSE
	BEGIN
		UPDATE #TempStyleDevelopment SET GroupName = 'ALL'
	END
*/

-- To hide duplicated style images for the all rows with the same sytle number on the report
IF @SortBy = 1  -- by user name / default
    BEGIN 

		INSERT INTO #TempStyleDevelopment (WorkAssignedTo, UserName, GroupID, GroupName,
						FilePath, imageShowFlag, StyleID, StyleNo, Descrip, 
						SizeClass, StyleSet,StyleStatus,
						WorkflowID, Workflow, WorkDue,CompleteDate, DaysLate,
						WorkflowStatus,WorkflowStatusID,  alertMessage,alertColor,
						StyleYear, Season, StyleSubCategory, WorkSort)
		
		SELECT
			w.WorkAssignedTo
			, u.FirstName + ' ' + u.LastName as UserName
			,g.GroupID
			,r.GroupName
			,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
							FROM	pStyleHeader LEFT OUTER JOIN hImage ON
								pStyleHeader.DesignSketchID = hImage.ImageID AND
								pStyleHeader.DesignSketchVersion = hImage.Version
							WHERE pStyleHeader.StyleID = h.StyleID
			) AS FilePath
			,0 as imageShowFlag
			,h.StyleID
			,h.StyleNo
			,h.[Description]
			,h.SizeClass
			,w.StyleSet
			,ps.Status 
			,w.WorkflowID
			,p.Workflow
			,w.WorkDue
			,w.WorkStatusDate as CompleteDate
			,DATEDIFF(day, GETDATE(), w.WorkDue)  as DaysLate
			,s.WorkflowStatus
			,s.WorkflowStatusID
			,(CASE WHEN  ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) = @NumDaysToAlert THEN 
		
						        ' ' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and  DATEDIFF(day, GETDATE(), w.WorkDue) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.WorkDue) >= 0 THEN 
		
							' <' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
				       WHEN  ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and  DATEDIFF(day, GETDATE(), w.WorkDue) < 0 THEN 
		
							' ' + RTRIM(CAST(DATEDIFF(day, w.WorkDue, GETDATE()) AS NVARCHAR(10))) + 'd Late'
		                       WHEN (w.WorkStatus = 100)                          THEN ' Apprvd'
				       WHEN (w.WorkStatus = 101)                                            THEN ' Reject'
				  ELSE ''
		                  END
			) as alertMessage
			,(CASE WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) = @NumDaysToAlert THEN 'Yellow'
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.WorkDue) >= 0 THEN 'Yellow'
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) < 0 THEN 'Red'
		                       WHEN (w.WorkStatus = 100)                          THEN 'Green'
				       WHEN (w.WorkStatus = 101)                THEN 'Silver'
				  ELSE ''
		                  END
			) as alertColor
			,LTRIM(RTRIM(h.CustomField4)) as StyleYear
			,LTRIM(RTRIM(h.CustomField2)) as Season
			--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
			,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
			,w.WorkSort
			--,1 as subReportNum
		from pStyleWorkflow w WITH (NOLOCK)
		INNER JOIN pStyleHeader h ON h.StyleID = w.StyleID 
		INNER JOIN Mapping  b ON b.Map = w.WorkflowID  
		INNER JOIN pWorkflowTemplateItem t ON  t.WorkflowID  = b.Map and t.WorkflowTemplateID = h.StyleWorkflowID 	
		INNER JOIN pWorkflowStatus s ON s.WorkflowStatusID = w.WorkStatus
		LEFT OUTER JOIN pStyleDevelopment d ON d.StyleDevelopmentID  = h.DevelopmentID
		LEFT OUTER JOIN pWorkflow p ON p.WorkflowID = w.WorkflowID
		LEFT OUTER JOIN Users u  ON u.UserId = w.WorkAssignedTo 
		LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
		LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		LEFT OUTER JOIN pStyleStatus ps ON h.StyleStatusID = ps.StatusID and h.StyleID = w.StyleID
		LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
		WHERE	
		      -- (w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- SQL2000: NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
		      (   
		            ((w.WorkDue > @DateFrom) OR   (DATEDIFF(day,  w.WorkDue,  @DateFrom) = 0 ) )  
		             AND
		              ((w.WorkDue < @DateTo) OR   (DATEDIFF(day,  w.WorkDue,  @DateTo) = 0 ) )            
		        )
		
		 
		   AND 
		  (
			((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR ( @Season = 'ALL')  )
		       )
		   AND
			 (
			 (LTRIM(RTRIM(h.CustomField4)) =  LTRIM(RTRIM(@Year))) or ( @Year ='ALL')
		        )
		  AND ( 
		  --       (LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
			   (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL') 
		       )
		  AND (
			  (w.WorkAssignedTo = @UserId)
		           OR  
		          (@UserId = -999)   --- -999 means "all users"
		      )
		   AND 
			(
			  (    CAST(g.GroupID AS nvarchar(40)) = @GroupID )
		          OR  
		          (@GroupID = 'ALL')  
		          )
		
		   AND 
			(
			   (s.WorkflowStatusID = @DevWorkflowStatus)
		          OR  
		         (@DevWorkflowStatus = -999)  
		       )
		
			GROUP BY
			UserName
			,h.StyleNo
			, h.SizeClass
			, w.StyleSet
			 ,w.WorkSort
			, t.WorkflowSort
			, w.WorkAssignedTo
			, u.FirstName
			, u.LastName 
			, g.GroupID
			, GroupName
			, h.StyleID
			, h.StyleStatusID
			, h.[Description]
			, ps.StatusID
			, ps.Status
			, w.WorkStatus
			, w.workflowID
			, p.Workflow
			, w.WorkDue
			, s.WorkflowStatus
			, s.WorkflowStatusID
			, w.WorkStatusDate
			,DATEDIFF(d, w.WorkDue, GETDATE())
			,LTRIM(RTRIM(h.CustomField4)) 
			,LTRIM(RTRIM(h.CustomField2)) 
			--,LTRIM(RTRIM(h.CustomField5)) 
			,c.StyleCategoryID, c.StyleCategory
		
		ORDER BY UserName,  h.StyleNo, h.SizeClass, w.StyleSet,   w.WorkSort, w.WorkflowID


		-- Set min row num for the style which is grouped and sorted by
		INSERT INTO #TempRowNumber (UserName, StyleNo, WorkDue, DaysLate, StyleSubCategory, minRowNumForStyle) 
			SELECT UserName, StyleNo, NULL, 0, NULL, MIN(rowNum) FROM #TempStyleDevelopment
			GROUP BY UserName, StyleNo ORDER BY  UserName, StyleNo --, SizeClass, StyleSet, WorkSort
		
		UPDATE s  set imageShowFlag = 1 FROM #TempRowNumber r, #TempStyleDevelopment s
		WHERE r.StyleNo = s.StyleNo and r.minRowNumForStyle = s.rowNum
		
		UPDATE #TempStyleDevelopment SET FilePath=NULL
                 WHERE imageShowFlag <> 1 or FilePath = ''

		SELECT * FROM #TempStyleDevelopment
		ORDER BY UserName, StyleNo, SizeClass, StyleSet, WorkSort
   	END

IF @SortBy = 2 -- by date
	
BEGIN 

		INSERT INTO #TempStyleDevelopment (WorkAssignedTo, UserName, GroupID, GroupName,
						FilePath, imageShowFlag, StyleID, StyleNo, Descrip, 
						SizeClass, StyleSet,StyleStatus,
						WorkflowID, Workflow, WorkDue,CompleteDate, DaysLate,
						WorkflowStatus,WorkflowStatusID,  alertMessage,alertColor,
						StyleYear, Season, StyleSubCategory, WorkSort)
		
		SELECT
			w.WorkAssignedTo
			, u.FirstName + ' ' + u.LastName as UserName
			,g.GroupID
			,r.GroupName
			,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
							FROM	pStyleHeader LEFT OUTER JOIN hImage ON
								pStyleHeader.DesignSketchID = hImage.ImageID AND
								pStyleHeader.DesignSketchVersion = hImage.Version
							WHERE pStyleHeader.StyleID = h.StyleID
			) AS FilePath
			,0 as imageShowFlag
			,h.StyleID
			,h.StyleNo
			,h.[Description]
			,h.SizeClass
			,w.StyleSet
			,ps.Status 
			,w.WorkflowID
			,p.Workflow
			,w.WorkDue
			,w.WorkStatusDate as CompleteDate
			,DATEDIFF(day, GETDATE(), w.WorkDue)  as DaysLate
			,s.WorkflowStatus
			,s.WorkflowStatusID
			,(CASE WHEN  ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) = @NumDaysToAlert THEN 
		
						        ' ' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and  DATEDIFF(day, GETDATE(), w.WorkDue) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.WorkDue) >= 0 THEN 
		
							' <' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
				       WHEN  ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and  DATEDIFF(day, GETDATE(), w.WorkDue) < 0 THEN 
		
							' ' + RTRIM(CAST(DATEDIFF(day, w.WorkDue, GETDATE()) AS NVARCHAR(10))) + 'd Late'
		                       WHEN (w.WorkStatus = 100)                          THEN ' Apprvd'
				       WHEN (w.WorkStatus = 101)                                            THEN ' Reject'
				  ELSE ''
		                  END
			) as alertMessage
			,(CASE WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) = @NumDaysToAlert THEN 'Yellow'
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.WorkDue) >= 0 THEN 'Yellow'
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) < 0 THEN 'Red'
		                       WHEN (w.WorkStatus = 100)                          THEN 'Green'
				       WHEN (w.WorkStatus = 101)                THEN 'Silver'
				  ELSE ''
		                  END
			) as alertColor
			,LTRIM(RTRIM(h.CustomField4)) as StyleYear
			,LTRIM(RTRIM(h.CustomField2)) as Season
			--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
			,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
			,w.WorkSort
			
		from pStyleWorkflow w WITH (NOLOCK)
		INNER JOIN pStyleHeader h ON h.StyleID = w.StyleID 
		INNER JOIN Mapping  b ON b.Map = w.WorkflowID  
		INNER JOIN pWorkflowTemplateItem t ON  t.WorkflowID  = b.Map and t.WorkflowTemplateID = h.StyleWorkflowID 	
		INNER JOIN pWorkflowStatus s ON s.WorkflowStatusID = w.WorkStatus
		LEFT OUTER JOIN pStyleDevelopment d ON d.StyleDevelopmentID  = h.DevelopmentID
		LEFT OUTER JOIN pWorkflow p ON p.WorkflowID = w.WorkflowID
		LEFT OUTER JOIN Users u  ON u.UserId = w.WorkAssignedTo 
		LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
		LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		LEFT OUTER JOIN pStyleStatus ps ON h.StyleStatusID = ps.StatusID and h.StyleID = w.StyleID
		LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
		WHERE	
		      -- (w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- SQL2000: NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
		      (   
		            ((w.WorkDue > @DateFrom) OR   (DATEDIFF(day,  w.WorkDue,  @DateFrom) = 0 ) )  
		             AND
		              ((w.WorkDue < @DateTo) OR   (DATEDIFF(day,  w.WorkDue,  @DateTo) = 0 ) )            
		        )
		
		 
		   AND 
		  (
			((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR ( @Season = 'ALL')  )
		       )
		   AND
			 (
			 (LTRIM(RTRIM(h.CustomField4)) =  LTRIM(RTRIM(@Year))) or ( @Year ='ALL')
		        )
		  AND ( 
		  --       (LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
			   (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL') 
		       )
		  AND (
			  (w.WorkAssignedTo = @UserId)
		           OR  
		          (@UserId = -999)   --- -999 means "all users"
		      )
		   AND 
			(
			  (    CAST(g.GroupID AS nvarchar(40)) = @GroupID )
		          OR  
		          (@GroupID = 'ALL')  
		          )
		
		   AND 
			(
			   (s.WorkflowStatusID = @DevWorkflowStatus)
		          OR  
		         (@DevWorkflowStatus = -999)  
		       )
		
			GROUP BY
			w.WorkDue
			,UserName
			,h.StyleNo
			, h.SizeClass
			, w.StyleSet
			 ,w.WorkSort
			, t.WorkflowSort
			, w.WorkAssignedTo
			, u.FirstName
			, u.LastName 
			, g.GroupID
			, GroupName
			, h.StyleID
			, h.StyleStatusID
			, h.[Description]
			, ps.StatusID
			, ps.Status
			, w.WorkStatus
			, w.workflowID
			, p.Workflow
			
			, s.WorkflowStatus
			, s.WorkflowStatusID
			, w.WorkStatusDate
			,DATEDIFF(d, w.WorkDue, GETDATE())
			,LTRIM(RTRIM(h.CustomField4)) 
			,LTRIM(RTRIM(h.CustomField2)) 
			--,LTRIM(RTRIM(h.CustomField5)) 
			,c.StyleCategoryID, c.StyleCategory
		
		ORDER BY w.WorkDue, UserName,  h.StyleNo, h.SizeClass, w.StyleSet,   w.WorkSort, w.WorkflowID

		INSERT INTO #TempRowNumber (UserName, StyleNo, WorkDue, DaysLate, StyleSubCategory, minRowNumForStyle) 
			SELECT UserName, StyleNo, WorkDue, 0, NULL, MIN(rowNum) FROM #TempStyleDevelopment
			GROUP BY WorkDue, UserName, StyleNo ORDER BY  WorkDue, UserName

		UPDATE s  set imageShowFlag = 1 FROM #TempRowNumber r, #TempStyleDevelopment s
		WHERE r.StyleNo = s.StyleNo and r.minRowNumForStyle = s.rowNum

		UPDATE #TempStyleDevelopment SET FilePath=NULL
                WHERE imageShowFlag <> 1 or FilePath = ''
		
		SELECT * FROM #TempStyleDevelopment
		ORDER BY WorkDue, UserName, StyleNo, SizeClass, StyleSet, WorkSort


		
   	END



IF @SortBy = 3 -- by dayslate
	BEGIN 

		INSERT INTO #TempStyleDevelopment (WorkAssignedTo, UserName, GroupID, GroupName,
						FilePath, imageShowFlag, StyleID, StyleNo, Descrip, 
						SizeClass, StyleSet,StyleStatus,
						WorkflowID, Workflow, WorkDue,CompleteDate, DaysLate,
						WorkflowStatus,WorkflowStatusID,  alertMessage,alertColor,
						StyleYear, Season, StyleSubCategory, WorkSort)
		
		SELECT
			w.WorkAssignedTo
			, u.FirstName + ' ' + u.LastName as UserName
			,g.GroupID
			,r.GroupName
			,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
							FROM	pStyleHeader LEFT OUTER JOIN hImage ON
								pStyleHeader.DesignSketchID = hImage.ImageID AND
								pStyleHeader.DesignSketchVersion = hImage.Version
							WHERE pStyleHeader.StyleID = h.StyleID
			) AS FilePath
			,0 as imageShowFlag
			,h.StyleID
			,h.StyleNo
			,h.[Description]
			,h.SizeClass
			,w.StyleSet
			,ps.Status 
			,w.WorkflowID
			,p.Workflow
			,w.WorkDue
			,w.WorkStatusDate as CompleteDate
			,DATEDIFF(day, GETDATE(), w.WorkDue)  as DaysLate
			,s.WorkflowStatus
			,s.WorkflowStatusID
			,(CASE WHEN  ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) = @NumDaysToAlert THEN 
		
						        ' ' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and  DATEDIFF(day, GETDATE(), w.WorkDue) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.WorkDue) >= 0 THEN 
		
							' <' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
				       WHEN  ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and  DATEDIFF(day, GETDATE(), w.WorkDue) < 0 THEN 
		
							' ' + RTRIM(CAST(DATEDIFF(day, w.WorkDue, GETDATE()) AS NVARCHAR(10))) + 'd Late'
		                       WHEN (w.WorkStatus = 100)                          THEN ' Apprvd'
				       WHEN (w.WorkStatus = 101)                                            THEN ' Reject'
				  ELSE ''
		                  END
			) as alertMessage
			,(CASE WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) = @NumDaysToAlert THEN 'Yellow'
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.WorkDue) >= 0 THEN 'Yellow'
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) < 0 THEN 'Red'
		                       WHEN (w.WorkStatus = 100)                          THEN 'Green'
				       WHEN (w.WorkStatus = 101)                THEN 'Silver'
				  ELSE ''
		                  END
			) as alertColor
			,LTRIM(RTRIM(h.CustomField4)) as StyleYear
			,LTRIM(RTRIM(h.CustomField2)) as Season
			--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
			,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
			,w.WorkSort
		from pStyleWorkflow w WITH (NOLOCK)
		INNER JOIN pStyleHeader h ON h.StyleID = w.StyleID 
		INNER JOIN Mapping  b ON b.Map = w.WorkflowID  
		INNER JOIN pWorkflowTemplateItem t ON  t.WorkflowID  = b.Map and t.WorkflowTemplateID = h.StyleWorkflowID 	
		INNER JOIN pWorkflowStatus s ON s.WorkflowStatusID = w.WorkStatus
		LEFT OUTER JOIN pStyleDevelopment d ON d.StyleDevelopmentID  = h.DevelopmentID
		LEFT OUTER JOIN pWorkflow p ON p.WorkflowID = w.WorkflowID
		LEFT OUTER JOIN Users u  ON u.UserId = w.WorkAssignedTo 
		LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
		LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		LEFT OUTER JOIN pStyleStatus ps ON h.StyleStatusID = ps.StatusID and h.StyleID = w.StyleID
		LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
		WHERE	
		      -- (w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- SQL2000: NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
		      (   
		            ((w.WorkDue > @DateFrom) OR   (DATEDIFF(day,  w.WorkDue,  @DateFrom) = 0 ) )  
		             AND
		              ((w.WorkDue < @DateTo) OR   (DATEDIFF(day,  w.WorkDue,  @DateTo) = 0 ) )            
		        )
		
		 
		   AND 
		  (
			((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR ( @Season = 'ALL')  )
		       )
		   AND
			 (
			 (LTRIM(RTRIM(h.CustomField4)) =  LTRIM(RTRIM(@Year))) or ( @Year ='ALL')
		        )
		  AND ( 
		  --       (LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
			   (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL') 
		       )
		  AND (
			  (w.WorkAssignedTo = @UserId)
		           OR  
		          (@UserId = -999)   --- -999 means "all users"
		      )
		   AND 
			(
			  (    CAST(g.GroupID AS nvarchar(40)) = @GroupID )
		          OR  
		          (@GroupID = 'ALL')  
		          )
		
		   AND 
			(
			   (s.WorkflowStatusID = @DevWorkflowStatus)
		          OR  
		         (@DevWorkflowStatus = -999)  
		       )
		
			GROUP BY
			DATEDIFF(d, w.WorkDue, GETDATE()) 
			,UserName
			,h.StyleNo
			, h.SizeClass
			, w.StyleSet
			 ,w.WorkSort
			, t.WorkflowSort
			, w.WorkAssignedTo
			, u.FirstName
			, u.LastName 
			, g.GroupID
			, GroupName
			, h.StyleID
			, h.StyleStatusID
			, h.[Description]
			, ps.StatusID
			, ps.Status
			, w.WorkStatus
			, w.workflowID
			, p.Workflow
			, w.WorkDue
			, s.WorkflowStatus
			, s.WorkflowStatusID
			, w.WorkStatusDate
			--,DATEDIFF(d, w.WorkDue, GETDATE())
			,LTRIM(RTRIM(h.CustomField4)) 
			,LTRIM(RTRIM(h.CustomField2)) 
			--,LTRIM(RTRIM(h.CustomField5)) 
			,c.StyleCategoryID, c.StyleCategory
		
		ORDER BY DATEDIFF(d, w.WorkDue, GETDATE()) , UserName,  h.StyleNo, h.SizeClass, w.StyleSet,   w.WorkSort, w.WorkflowID

		INSERT INTO #TempRowNumber (UserName, StyleNo, WorkDue, DaysLate, StyleSubCategory, minRowNumForStyle) 
			SELECT UserName, StyleNo, NULL, DaysLate, NULL, MIN(rowNum) FROM #TempStyleDevelopment
			GROUP BY DaysLate, UserName, StyleNo ORDER BY  DaysLate, UserName, StyleNo --, SizeClass, StyleSet, WorkSort
		
		UPDATE s  set imageShowFlag = 1 FROM #TempRowNumber r, #TempStyleDevelopment s
		WHERE r.StyleNo = s.StyleNo and r.minRowNumForStyle = s.rowNum

		UPDATE #TempStyleDevelopment SET FilePath=NULL
                 WHERE imageShowFlag <> 1 or FilePath = ''
		
		SELECT * FROM #TempStyleDevelopment
		ORDER BY DaysLate, UserName, StyleNo, SizeClass, StyleSet, WorkSort


		
   	END



IF @SortBy = 4 -- by category
BEGIN 

		INSERT INTO #TempStyleDevelopment (WorkAssignedTo, UserName, GroupID, GroupName,
						FilePath, imageShowFlag, StyleID, StyleNo, Descrip, 
						SizeClass, StyleSet,StyleStatus,
						WorkflowID, Workflow, WorkDue,CompleteDate, DaysLate,
						WorkflowStatus,WorkflowStatusID,  alertMessage,alertColor,
						StyleYear, Season, StyleSubCategory, WorkSort)
		
		SELECT
			w.WorkAssignedTo
			, u.FirstName + ' ' + u.LastName as UserName
			,g.GroupID
			,r.GroupName
			,(SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
							FROM	pStyleHeader LEFT OUTER JOIN hImage ON
								pStyleHeader.DesignSketchID = hImage.ImageID AND
								pStyleHeader.DesignSketchVersion = hImage.Version
							WHERE pStyleHeader.StyleID = h.StyleID
			) AS FilePath
			,0 as imageShowFlag
			,h.StyleID
			,h.StyleNo
			,h.[Description]
			,h.SizeClass
			,w.StyleSet
			,ps.Status 
			,w.WorkflowID
			,p.Workflow
			,w.WorkDue
			,w.WorkStatusDate as CompleteDate
			,DATEDIFF(day, GETDATE(), w.WorkDue)  as DaysLate
			,s.WorkflowStatus
			,s.WorkflowStatusID
			,(CASE WHEN  ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) = @NumDaysToAlert THEN 
		
						        ' ' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and  DATEDIFF(day, GETDATE(), w.WorkDue) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.WorkDue) >= 0 THEN 
		
							' <' + RTRIM(CAST(@NumDaysToAlert AS NVARCHAR(10))) + 'd Away'
		
				       WHEN  ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and  DATEDIFF(day, GETDATE(), w.WorkDue) < 0 THEN 
		
							' ' + RTRIM(CAST(DATEDIFF(day, w.WorkDue, GETDATE()) AS NVARCHAR(10))) + 'd Late'
		                       WHEN (w.WorkStatus = 100)                          THEN ' Apprvd'
				       WHEN (w.WorkStatus = 101)                                            THEN ' Reject'
				  ELSE ''
		                  END
			) as alertMessage
			,(CASE WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) = @NumDaysToAlert THEN 'Yellow'
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) < @NumDaysToAlert and DATEDIFF(day, GETDATE(), w.WorkDue) >= 0 THEN 'Yellow'
				       WHEN ((w.WorkStatus < 7 and w.WorkStatus > 1) or w.WorkStatus = 102) and DATEDIFF(day, GETDATE(), w.WorkDue) < 0 THEN 'Red'
		                       WHEN (w.WorkStatus = 100)                          THEN 'Green'
				       WHEN (w.WorkStatus = 101)                THEN 'Silver'
				  ELSE ''
		                  END
			) as alertColor
			,LTRIM(RTRIM(h.CustomField4)) as StyleYear
			,LTRIM(RTRIM(h.CustomField2)) as Season
			--,LTRIM(RTRIM(h.CustomField5)) as StyleSubCategory
			,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
			,w.WorkSort
		from pStyleWorkflow w WITH (NOLOCK)
		INNER JOIN pStyleHeader h ON h.StyleID = w.StyleID 
		INNER JOIN Mapping  b ON b.Map = w.WorkflowID  
		INNER JOIN pWorkflowTemplateItem t ON  t.WorkflowID  = b.Map and t.WorkflowTemplateID = h.StyleWorkflowID 	
		INNER JOIN pWorkflowStatus s ON s.WorkflowStatusID = w.WorkStatus
		LEFT OUTER JOIN pStyleDevelopment d ON d.StyleDevelopmentID  = h.DevelopmentID
		LEFT OUTER JOIN pWorkflow p ON p.WorkflowID = w.WorkflowID
		LEFT OUTER JOIN Users u  ON u.UserId = w.WorkAssignedTo 
		LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
		LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
		LEFT OUTER JOIN pStyleStatus ps ON h.StyleStatusID = ps.StatusID and h.StyleID = w.StyleID
		LEFT OUTER JOIN  pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
		WHERE	
		      -- (w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- SQL2000: NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
		      (   
		            ((w.WorkDue > @DateFrom) OR   (DATEDIFF(day,  w.WorkDue,  @DateFrom) = 0 ) )  
		             AND
		              ((w.WorkDue < @DateTo) OR   (DATEDIFF(day,  w.WorkDue,  @DateTo) = 0 ) )            
		        )
		
		 
		   AND 
		  (
			((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR ( @Season = 'ALL')  )
		       )
		   AND
			 (
			 (LTRIM(RTRIM(h.CustomField4)) =  LTRIM(RTRIM(@Year))) or ( @Year ='ALL')
		        )
		  AND ( 
		  --       (LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleSubCategory ))) OR (@StyleSubCategory = 'ALL') 
			   (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL') 
		       )
		  AND (
			  (w.WorkAssignedTo = @UserId)
		           OR  
		          (@UserId = -999)   --- -999 means "all users"
		      )
		   AND 
			(
			  (    CAST(g.GroupID AS nvarchar(40)) = @GroupID )
		          OR  
		          (@GroupID = 'ALL')  
		          )
		
		   AND 
			(
			   (s.WorkflowStatusID = @DevWorkflowStatus)
		          OR  
		         (@DevWorkflowStatus = -999)  
		       )
		
			GROUP BY
			c.StyleCategoryID
			,c.StyleCategory
			,UserName
			,h.StyleNo
			, h.SizeClass
			, w.StyleSet
			 ,w.WorkSort
			, t.WorkflowSort
			, w.WorkAssignedTo
			, u.FirstName
			, u.LastName 
			, g.GroupID
			, GroupName
			, h.StyleID
			, h.StyleStatusID
			, h.[Description]
			, ps.StatusID
			, ps.Status
			, w.WorkStatus
			, w.workflowID
			, p.Workflow
			, w.WorkDue
			, s.WorkflowStatus
			, s.WorkflowStatusID
			, w.WorkStatusDate
			,DATEDIFF(d, w.WorkDue, GETDATE())
			,LTRIM(RTRIM(h.CustomField4)) 
			,LTRIM(RTRIM(h.CustomField2)) 
			--,LTRIM(RTRIM(h.CustomField5)) 
			,c.StyleCategoryID, c.StyleCategory
		
		ORDER BY c.StyleCategory, UserName, h.StyleNo, h.SizeClass, w.StyleSet, w.WorkSort


		INSERT INTO #TempRowNumber (UserName, StyleNo, WorkDue, DaysLate, StyleSubCategory, minRowNumForStyle) 
			SELECT UserName, StyleNo, NULL, NULL, StyleSubCategory, MIN(rowNum) FROM #TempStyleDevelopment
			GROUP BY StyleSubCategory, UserName, StyleNo ORDER BY  StyleSubCategory, UserName, StyleNo --, SizeClass, StyleSet, WorkSort
		
		UPDATE s  set imageShowFlag = 1 FROM #TempRowNumber r, #TempStyleDevelopment s
		WHERE r.StyleNo = s.StyleNo and r.minRowNumForStyle = s.rowNum


		UPDATE #TempStyleDevelopment SET FilePath=NULL
                  WHERE imageShowFlag <> 1 or FilePath = ''
		
		SELECT * FROM #TempStyleDevelopment
		ORDER BY StyleSubCategory, UserName, StyleNo, SizeClass, StyleSet, WorkSort

		
   	END

DROP TABLE #TempStyleDevelopment

END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03751', GetDate())
GO
