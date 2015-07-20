SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_SELECT](@StyleID uniqueidentifier,
@StyleSet int,
@WorkflowID uniqueidentifier)
AS 

SELECT     a.StyleDetailFormID, a.WorkflowID, a.StyleID, a.Comments, a.StyleSet, a.ImageID, a.ImageVersion, a.Sort, a.CUser, a.CDate, a.MUser, a.MDate, b.ImageFileType
FROM         dbo.pStyleDetailForm a WITH (NOLOCK) , dbo.pImage b WITH (NOLOCK)
WHERE     a.StyleID = @StyleID  AND a.StyleSet = @StyleSet  AND a.WorkflowID = @WorkflowID
AND a.ImageID = b.ImageID
ORDER BY a.Sort, a.MDate