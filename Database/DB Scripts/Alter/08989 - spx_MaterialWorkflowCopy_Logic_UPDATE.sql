IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowCopy_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowCopy_Logic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_MaterialWorkflowCopy_Logic_UPDATE] (
	@MaterialID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS

INSERT INTO pMaterialWorkflowPage(
	MaterialID, MaterialTemplateItemID, MaterialTemplatePageID,
	WorkStart, WorkDue, WorkAssignedTo, WorkStatus,
	Sort, CUser, CDate, MUser, MDate, ActualStart)
SELECT m.MaterialID, mti.MaterialTemplateItemID, mti.MaterialTemplatePageID,
	NULL, NULL, NULL, CASE WHEN mwp.WorkStatus = 1 THEN mwp.WorkStatus ELSE 6 END, 
	mti.Sort, @CUser, @CDate, @CDate, @CDate, CASE WHEN mwp.WorkStatus = 1 THEN NULL ELSE GETDATE() END
FROM pMaterial m
INNER JOIN pMaterialTemplateItem mti ON m.MaterialTemplateID = mti.MaterialTemplateID
LEFT JOIN pMaterialWorkflowPage mwp ON mti.MaterialTemplatePageID = mwp.MaterialTemplatePageID
	AND m.MaterialID = mwp.MaterialID
WHERE m.MaterialID = @MaterialID AND mwp.MaterialWorkflowPageID IS NULL

UPDATE pMaterialWorkflowPage SET WorkStatus = 6, ActualStart = GETDATE()
WHERE MaterialID = @MaterialID AND MaterialTemplatePageID = '10000000-0000-0000-0000-000000000000'

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08989', GetDate())
GO
