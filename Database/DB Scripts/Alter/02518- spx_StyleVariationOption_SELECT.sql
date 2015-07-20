 
 
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleVariationOption_SELECT')
   DROP PROCEDURE spx_StyleVariationOption_SELECT
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
		SELECT 'S' as Type, 'Size' as Description
		UNION 
		SELECT 'V', 'Variation'
		UNION
		SELECT 'LP', 'Line Plan'
	END		
	ELSE
	BEGIN
		SELECT 'V' as Type, 'Variation' as Description
		UNION
		SELECT 'LP', 'Line Plan'
	END 

END 



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02518'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02518', GetDate())
END
GO