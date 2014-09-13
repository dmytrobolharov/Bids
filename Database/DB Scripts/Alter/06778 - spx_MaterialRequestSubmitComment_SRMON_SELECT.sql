IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitComment_SRMON_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitComment_SRMON_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitComment_SRMON_SELECT](@MaterialRequestSubmitID uniqueidentifier)
AS 

SELECT *
FROM  pMaterialRequestSubmitComment
WHERE MaterialRequestSubmitID  = @MaterialRequestSubmitID
AND MaterialRequestSubmitCommentType = 'S'
ORDER BY MDate DESC
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06778', GetDate())
GO
