IF OBJECT_ID(N'[dbo].[dpx_BusinessUsersGroup_ActivityTracking_SUB_1_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_BusinessUsersGroup_ActivityTracking_SUB_1_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_BusinessUsersGroup_ActivityTracking_SUB_1_SELECT]
	
	 @DateFrom					datetime = NULL
	,@DateTo					datetime = NULL
	,@ShowStyleDevelWorkflow	int
	,@Season					nvarchar(200) = NULL
	,@Year						nvarchar(200) = NULL	 
	,@StyleCategoryID			nvarchar(40) = NULL		-- pStyleHeader.CustomField5 (Item Category on plmOn)
	,@GroupID					nvarchar(40) = NULL		-- uniqueidentifier in the table
	,@UserId					int = NULL				-- means "all" users

AS
BEGIN
SET NOCOUNT ON;
--------------------------------------------
IF @Season IS NULL OR @Season = ''
BEGIN
	SET @Season = 'ALL'
END
ELSE
BEGIN
	SET @Season = LTRIM(RTRIM(@Season))
END
--------------------------------------------
IF @Year IS NULL OR @Year = ''
BEGIN
	SET @Year = 'ALL'
END
ELSE
BEGIN
	SET @Year = LTRIM(RTRIM(@Year))
END
--------------------------------------------
IF @UserId IS NULL
BEGIN
	SET @UserId = -1
END
--------------------------------------------

DECLARE @GroupName	nvarchar(200)

IF @DateFrom IS NULL  or @DateFrom = ''
BEGIN
   SET @DateFrom = '01/01/1900'
END 


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



IF @StyleCategoryID	 IS NULL or @StyleCategoryID	= ''
BEGIN
 SET @StyleCategoryID	 = 'ALL'
END



CREATE TABLE #TempStyleDevel
(
	WorkAssignedTo			int           -- UserID
	,UserName			nvarchar(200)
	,GroupID			uniqueidentifier
	,GroupName			nvarchar(200)
	,StyleID			uniqueidentifier
	,StyleNo			nvarchar(20)
     	,Descrip			nvarchar(100)
	,SizeClass			nvarchar(400)
	,StyleSet			int
	--,StyleWorkflowID		uniqueidentifier
	,WorkflowID			uniqueidentifier
	,Workflow			nvarchar(100)
	,WorkDue			datetime
	,CompleteDate			datetime
	,DaysLate			int
	,StyleYear			nvarchar(200)
	,Season				nvarchar(200)
	,StyleSubCategory		nvarchar(255)
	,WorkSort			int
	,subReportNum			int
)



INSERT INTO #TempStyleDevel (	WorkAssignedTo, UserName, 
				StyleID, StyleNo, Descrip, 
				SizeClass, StyleSet,
				--StyleWorkflowID,  
				WorkflowID, Workflow, WorkDue,CompleteDate, DaysLate,
				StyleYear, Season, StyleSubCategory, WorkSort,
			subReportNum)

SELECT
	w.WorkAssignedTo
	, u.FirstName + ' ' + u.LastName as UserName
	,h.StyleID
	,h.StyleNo
	,h.[Description]
	, COALESCE(sc.Custom, h.SizeClass)
	, w.StyleSet
	--, w.StyleWorkflowID
	, w.WorkflowID
	, p.Workflow
	, w.WorkDue
	, w.WorkStatusDate as CompleteDate
	,DATEDIFF(day, GETDATE(), w.WorkDue)  as DaysLate
	,SSY.[Year] AS StyleYear --LTRIM(RTRIM(h.CustomField4)) as StyleYear
	,SSY.Season as Season --LTRIM(RTRIM(h.CustomField2)) as Season
	,LTRIM(RTRIM(c.StyleCategory)) as StyleSubCategory
	,w.WorkSort
	,1 as subReportNum
from pStyleWorkflow w WITH (NOLOCK)
INNER JOIN pStyleHeader h ON h.StyleID = w.StyleID 
LEFT JOIN pSizeClass sc ON sc.CustomID = h.SizeClassId
LEFT JOIN pSeasonYear SSY ON SSY.SeasonYearID = h.IntroSeasonYearID
INNER JOIN Mapping  b ON b.Map = w.WorkflowID  
INNER JOIN pWorkflowTemplateItem t ON  t.WorkflowID  = b.Map and t.WorkflowTemplateID = h.StyleWorkflowID 	
INNER JOIN pWorkflowStatus s ON s.WorkflowStatusID = w.WorkStatus
-- and h.StyleWorkflowID = w.StyleWorkflowID
LEFT OUTER JOIN pStyleDevelopment d ON d.StyleDevelopmentID  = h.DevelopmentID
LEFT OUTER JOIN pWorkflow p ON p.WorkflowID = w.WorkflowID
LEFT OUTER JOIN Users u  ON u.UserId = w.WorkAssignedTo 
LEFT OUTER JOIN uUserGroup g ON g.TeamID = u.TeamID
LEFT OUTER JOIN uGroup r ON r.GroupID = g.GroupID	
LEFT OUTER JOIN pStyleCategory c ON  c.StyleCategoryID = h.StyleCategory 
WHERE
(
	--((LTRIM(RTRIM(h.CustomField2)) = LTRIM(RTRIM(@Season))) OR ( @Season = 'ALL')  )
	@Season = 'ALL' OR LTRIM(RTRIM(SSY.Season)) = @Season
)
AND
(
	--(LTRIM(RTRIM(h.CustomField4)) =  LTRIM(RTRIM(@Year))) or ( @Year ='ALL')
	@Year = 'ALL' OR LTRIM(RTRIM(SSY.[Year])) = @Year
)
AND
(
	@UserId = -1 /*ALL*/ OR w.WorkAssignedTo = @UserId
)
AND
--(w.DueDate >= @DateFrom and w.DueDate <= @DateTo ) -- SQL2000: NOT WORKING FOR THE SAME @DateFrom, @DateTo, Checking Time too.
(   
      ((w.WorkDue > @DateFrom) OR   (DATEDIFF(day,  w.WorkDue,  @DateFrom) = 0 ) 
)  
AND
(
	(w.WorkDue < @DateTo) OR   (DATEDIFF(day,  w.WorkDue,  @DateTo) = 0 ) )            
)
AND 
( 
 --(LTRIM(RTRIM(h.CustomField5)) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL') 
    (LTRIM(RTRIM( CAST(c.StyleCategoryID AS nvarchar(40)) )) = LTRIM(RTRIM(@StyleCategoryID ))) OR (@StyleCategoryID = 'ALL')
)
   AND (
	  (CAST(g.GroupID AS nvarchar(40)) = @GroupID)
           OR  
          (@GroupID = 'ALL')  
       )

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
	,SSY.[Year] --LTRIM(RTRIM(h.CustomField4)) 
	,SSY.Season --LTRIM(RTRIM(h.CustomField2)) 
	--,LTRIM(RTRIM(h.CustomField5)) 
	,c.StyleCategoryID, c.StyleCategory
	,w.WorkSort
ORDER BY 	UserName,  h.StyleNo, COALESCE(sc.Custom, h.SizeClass), w.StyleSet,   t.WorkflowSort, w.WorkflowID

/* Replaced by ds_information_GroupName  dataset on Dash_BusinessUsersGroup_ActivityTracking_Body_PLT.rdl
IF (@GroupID <> 'ALL') and (@GroupID IS NOT NULL)
       BEGIN
		UPDATE #TempStyleDevel SET  GroupID =  CAST(@GroupID AS uniqueidentifier), GroupName = @GroupName
	END
ELSE
	BEGIN
		UPDATE #TempStyleDevel SET GroupName = 'ALL'
	END
*/

SELECT * FROM #TempStyleDevel

DROP TABLE #TempStyleDevel

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09546', GetDate())
GO