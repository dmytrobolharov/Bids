/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSubmitIdsPlmOn_SELECT]    Script Date: 09/19/2012 18:04:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSubmitIdsPlmOn_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSubmitIdsPlmOn_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSubmitIdsPlmOn_SELECT]    Script Date: 09/19/2012 18:04:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestSubmitIdsPlmOn_SELECT] 
(@UserName NVARCHAR(200))

AS 


(
SELECT c.StyleNo, h.TradePartnerName, f.VendorName, g.GroupName, a.SampleRequestTradeID, a.SampleRequestSubmitID,
CASE a.Submit 
	WHEN 1 THEN '1st Submit'
	WHEN 2 THEN '2nd Submit'
	WHEN 3 THEN '3rd Submit'
	ELSE CAST(a.Submit AS NVARCHAR(10)) + 'th Submit'
END AS Submit, b.SampleRequestWorkflowID
FROM pSampleRequestSubmitBOM a
INNER JOIN pSampleRequestWorkflowBOM b WITH (NOLOCK) ON a.SampleRequestWorkflowID = b.SampleRequestWorkflowID 
									  AND a.SampleRequestTradeID = b.SampleRequestTradeID 
									  AND a.SampleWorkflowID IN (
											SELECT s.SampleTypeId 
											FROM sAccessSampleFolder s
											INNER JOIN Users u WITH (NOLOCK) ON u.TeamID = s.TeamID
											WHERE (s.AccessRoleId = 3 OR s.AccessModify = 1)
											AND u.UserName = @UserName
											--AND TeamId = '203517C2-2BD4-4ED3-9EF7-AC37DE447321'
											)
INNER JOIN uTradePartner h WITH (NOLOCK) ON b.TradePartnerID = h.TradePartnerID
INNER JOIN pSampleWorkflow g WITH (NOLOCK) ON b.SampleWorkflowID = g.SampleWorkflowID
INNER JOIN pStyleHeader c WITH (NOLOCK) ON c.StyleID = a.StyleID
INNER JOIN pStyleSeasonYear d WITH (NOLOCK) ON c.StyleID = d.StyleID 
INNER JOIN pSeasonYear e WITH (NOLOCK) ON e.SeasonYearID = d.SeasonYearID
						AND c.StyleType IN (
								SELECT s.StyleTypeID 
								FROM sAccessStyleFolder s
								INNER JOIN Users u WITH (NOLOCK) ON u.TeamID = s.TeamID
								WHERE (s.AccessRoleId = 3 OR s.AccessView = 1)
								AND u.UserName = @UserName
								--AND TeamId = '203517C2-2BD4-4ED3-9EF7-AC37DE447321'
								)
INNER JOIN uTradePartnerVendor f WITH (NOLOCK) ON a.TradePartnerVendorID = f.TradePartnerVendorID
INNER JOIN pWorkflowTemplateItem z WITH (NOLOCK) ON c.StyleWorkflowID = z.WorkflowTemplateID
										  AND z.WorkflowID = '40000000-0000-0000-0000-000000000080'
INNER JOIN pStyleWorkflow y WITH (NOLOCK) ON y.StyleID = c.StyleID AND y.WorkflowID = '40000000-0000-0000-0000-000000000080'
)
--ORDER BY StyleNo, TradePartnerName, VendorName, GroupName, SampleRequestTradeID, SampleRequestWorkflowID, Submit 
UNION
(
SELECT c.StyleNo, h.TradePartnerName, f.VendorName, g.GroupName, a.SampleRequestTradeID, a.SampleRequestSubmitID,
CASE a.Submit 
	WHEN 1 THEN '1st Submit'
	WHEN 2 THEN '2nd Submit'
	WHEN 3 THEN '3rd Submit'
	ELSE CAST(a.Submit AS NVARCHAR(10)) + 'th Submit'
END AS Submit, b.SampleRequestWorkflowID
FROM pSampleRequestSubmit a
INNER JOIN pSampleRequestWorkflow b WITH (NOLOCK) ON a.SampleRequestWorkflowID = b.SampleRequestWorkflowID 
									  AND a.SampleRequestTradeID = b.SampleRequestTradeID 
									  AND a.SampleWorkflowID IN (
											SELECT s.SampleTypeId 
											FROM sAccessSampleFolder s
											INNER JOIN Users u WITH (NOLOCK) ON u.TeamID = s.TeamID
											WHERE (s.AccessRoleId = 3 OR s.AccessModify = 1)
											AND u.UserName = @UserName
											--AND TeamId = '203517C2-2BD4-4ED3-9EF7-AC37DE447321'
											)
INNER JOIN uTradePartner h WITH (NOLOCK) ON b.TradePartnerID = h.TradePartnerID
INNER JOIN pSampleWorkflow g WITH (NOLOCK) ON b.SampleWorkflowID = g.SampleWorkflowID
INNER JOIN pStyleHeader c WITH (NOLOCK) ON c.StyleID = a.StyleID
INNER JOIN pStyleSeasonYear d WITH (NOLOCK) ON c.StyleID = d.StyleID 
INNER JOIN pSeasonYear e WITH (NOLOCK) ON e.SeasonYearID = d.SeasonYearID
						AND c.StyleType IN (
								SELECT s.StyleTypeID 
								FROM sAccessStyleFolder s
								INNER JOIN Users u WITH (NOLOCK) ON u.TeamID = s.TeamID
								WHERE (s.AccessRoleId = 3 OR s.AccessView = 1)
								AND u.UserName = @UserName
								--AND TeamId = '203517C2-2BD4-4ED3-9EF7-AC37DE447321'
								)
INNER JOIN uTradePartnerVendor f WITH (NOLOCK) ON a.TradePartnerVendorID = f.TradePartnerVendorID
WHERE c.StyleWorkflowID NOT IN (
				   SELECT WorkflowTemplateID 
				   FROM pWorkflowTemplateItem 
				   WHERE WorkflowID = '40000000-0000-0000-0000-000000000080'
				   )
OR c.StyleID NOT IN (
		   SELECT StyleID 
		   FROM pStyleWorkflow
		   WHERE WorkflowID = '40000000-0000-0000-0000-000000000080'
		   )
)
ORDER BY StyleNo, TradePartnerName, VendorName, GroupName, SampleRequestTradeID, SampleRequestWorkflowID, Submit 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03924', GetDate())
GO