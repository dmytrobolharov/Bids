IF OBJECT_ID(N'[dbo].[spx_StyleVariationSize_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleVariationSize_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleVariationSize_SELECT]
(@StyledevelopmentId uniqueidentifier, @StyleId uniqueidentifier , @WorkflowID uniqueidentifier )
AS 

DECLARE @StyleVariation INT
SET @StyleVariation = (SELECT Variation FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID)


/*
SELECT   StyleId, StyleNo, DevelopmentNo, SizeClass, SizeRange, DevelopmentID, TechPackId, TechPackDate, DueDate
FROM         pStyleHeader WITH (NOLOCK)
WHERE   StyleId IN (SELECT StyleId FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE DevelopmentID = @StyleDevelopmentId AND Variation = @StyleVariation)
ORDER BY CDate
*/

SELECT sh.StyleId, sh.StyleNo, sh.DevelopmentNo, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
       COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sh.DevelopmentID, sh.TechPackId, 
	   sh.TechPackDate, sh.DueDate
FROM pStyleHeader sh WITH (NOLOCK)
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE sh.StyleId IN ( 

	(	
		SELECT distinct a.StyleID 
		FROM pStyleHeader  a WITH (NOLOCK) ,  pWorkflowTemplateItem  b WITH (NOLOCK)
		where 	a.StyleID  IN  (	SELECT a.StyleId  FROM pStyleDevelopmentItem a WITH (NOLOCK)
		WHERE a.StyleDevelopmentID = @StyledevelopmentId  AND a.Variation = @StyleVariation   )
		AND  StyleWorkflowId IS NOT NULL 
		AND  a.StyleWorkflowId  = b.WorkflowTemplateID 
		AND  b.WorkflowID  = @WorkflowID
	)
	
	UNION 
	(
		SELECT distinct a.StyleID 
		FROM pStyleWorkflow a WITH (NOLOCK) ,  pWorkflowStatus b WITH (NOLOCK)
		where StyleID  in (
			SELECT StyleID 
			FROM pStyleHeader WITH (NOLOCK) 
			where 	StyleID  IN  (	SELECT a.StyleId  FROM pStyleDevelopmentItem a WITH (NOLOCK)
				WHERE a.StyleDevelopmentID = @StyledevelopmentId  AND a.Variation = @StyleVariation  )
			AND  StyleWorkflowId IS NULL 
		) 
		and  WorkflowID = @WorkflowID
		AND a.WorkStatus = b.WorkflowStatusID 
	)
)
ORDER BY sh.CDate

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09836', GetDate())
GO
