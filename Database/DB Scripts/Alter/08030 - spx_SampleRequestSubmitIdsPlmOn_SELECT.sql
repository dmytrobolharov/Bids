/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSubmitIdsPlmOn_SELECT]    Script Date: 06/17/2014 15:59:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSubmitIdsPlmOn_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSubmitIdsPlmOn_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSubmitIdsPlmOn_SELECT]    Script Date: 06/17/2014 15:59:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_SampleRequestSubmitIdsPlmOn_SELECT] 
(@UserName NVARCHAR(200))

AS 

DECLARE @TeamID UNIQUEIDENTIFIER
SELECT @TeamID = TeamID FROM Users WHERE UserName = @UserName
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
INNER JOIN uTradePartner h WITH (NOLOCK) ON b.TradePartnerID = h.TradePartnerID
INNER JOIN pSampleWorkflow g WITH (NOLOCK) ON b.SampleWorkflowID = g.SampleWorkflowID
INNER JOIN pStyleHeader c WITH (NOLOCK) ON c.StyleID = a.StyleID
INNER JOIN pStyleSeasonYear d WITH (NOLOCK) ON c.StyleID = d.StyleID 
INNER JOIN pSeasonYear e WITH (NOLOCK) ON e.SeasonYearID = d.SeasonYearID
INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) styleAccess ON styleAccess.ProductTypeId = c.StyleType
AND (styleAccess.PermissionRoleId = 3 OR styleAccess.PermissionView = 1)
INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) sampleAccess ON sampleAccess.ProductTypeId = c.StyleType AND sampleAccess.WorkflowId = g.SampleWorkflowGUID 
AND (sampleAccess.PermissionRoleId = 3 OR sampleAccess.PermissionModify = 1)
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
INNER JOIN uTradePartner h WITH (NOLOCK) ON b.TradePartnerID = h.TradePartnerID
INNER JOIN pSampleWorkflow g WITH (NOLOCK) ON b.SampleWorkflowID = g.SampleWorkflowID
INNER JOIN pStyleHeader c WITH (NOLOCK) ON c.StyleID = a.StyleID
INNER JOIN pStyleSeasonYear d WITH (NOLOCK) ON c.StyleID = d.StyleID 
INNER JOIN pSeasonYear e WITH (NOLOCK) ON e.SeasonYearID = d.SeasonYearID
INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) styleAccess ON styleAccess.ProductTypeId = c.StyleType
AND (styleAccess.PermissionRoleId = 3 OR styleAccess.PermissionView = 1)
INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) sampleAccess ON sampleAccess.ProductTypeId = c.StyleType AND sampleAccess.WorkflowId = g.SampleWorkflowGUID 
AND (sampleAccess.PermissionRoleId = 3 OR sampleAccess.PermissionModify = 1)
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
VALUES ('DB_Version', '0.5.0000', '08030', GetDate())
GO
