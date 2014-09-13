IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleDetailForm_SELECT') 
	DROP PROCEDURE spx_StyleDetailForm_SELECT
GO

Create PROCEDURE [dbo].[spx_StyleDetailForm_SELECT](@StyleID uniqueidentifier,
@StyleSet int,
@WorkflowID uniqueidentifier,
@WorkflowItemID uniqueidentifier)

AS 
BEGIN
	SELECT     a.StyleDetailFormID, a.WorkflowID, a.StyleID, a.Comments, a.StyleSet, a.ImageID, a.ImageVersion, a.Sort, a.CUser, a.CDate, a.MUser, a.MDate, b.ImageFileType
	FROM         dbo.pStyleDetailForm a WITH (NOLOCK) , dbo.pImage b WITH (NOLOCK)
	WHERE     a.StyleID = @StyleID  AND a.StyleSet = @StyleSet  AND a.WorkflowID = @WorkflowID AND a.WorkFlowItemId = @WorkflowItemID
	AND a.ImageID = b.ImageID
	ORDER BY a.Sort, a.MDate
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01150', GetDate())
GO