IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleVariationOption_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleVariationOption_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleVariationOption_SELECT]
(
	@StyleID as uniqueidentifier 
)
AS 
BEGIN
	
	DECLARE @NumRec int 
	
	SELECT    @NumRec = COUNT(b.Map) 
	FROM      dbo.pStyleWorkflow AS a WITH (NOLOCK) INNER JOIN
              dbo.Mapping AS b WITH (NOLOCK) ON a.WorkflowID = b.Map INNER JOIN
              dbo.pStyleHeader AS d WITH (NOLOCK) ON a.StyleID = d.StyleID INNER JOIN
              dbo.pWorkflowTemplateItem AS e WITH (NOLOCK) ON e.WorkflowID = b.Map
              and a.StyleID  = @StyleID 
			  and a.WorkflowId = '40000000-0000-0000-0000-000000000050'
			  
	IF @NumRec  = 0
	BEGIN
		IF (SELECT DeskActive FROM sDeskTop WHERE LOWER(DeskName) like 'line planning') <> 0
		BEGIN
			SELECT 'S' as Type, 'Size' as Description
			UNION 
			SELECT 'V', 'Variation'
			UNION
			SELECT 'LP', 'Line Plan'
		END
		ELSE
		BEGIN
			SELECT 'S' as Type, 'Size' as Description
			UNION 
			SELECT 'V', 'Variation'
		END
	END		
	ELSE
	BEGIN
		IF (SELECT DeskActive FROM sDeskTop WHERE LOWER(DeskName) like 'line planning') <> 0
		BEGIN
			SELECT 'SM' AS Type, 'Size' As Description
			UNION
			SELECT 'V' as Type, 'Variation' as Description
			UNION
			SELECT 'LP', 'Line Plan'
		END
		ELSE
		BEGIN
			SELECT 'SM' AS Type, 'Size' As Description
			UNION
			SELECT 'V' as Type, 'Variation' as Description
		END
	END 

END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07753', GetDate())
GO

