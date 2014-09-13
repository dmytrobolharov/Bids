INSERT INTO pMaterialWorkflowPage(
	MaterialID, MaterialTemplateItemID, MaterialTemplatePageID,
	WorkStart, WorkDue, WorkAssignedTo, WorkStatus,
	Sort, CUser, CDate, MUser, MDate)
SELECT m.MaterialID, mti.MaterialTemplateItemID, mti.MaterialTemplatePageID,
	NULL, NULL, NULL, 6,
	mti.Sort, 'SYSTEM', GETDATE(), 'SYSTEM', GETDATE()
FROM pMaterial m
INNER JOIN pMaterialTemplateItem mti ON m.MaterialTemplateID = mti.MaterialTemplateID
LEFT JOIN pMaterialWorkflowPage mwp ON mti.MaterialTemplateItemID = mwp.MaterialTemplateItemID
WHERE mwp.MaterialWorkflowPageID IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08415', GetDate())
GO
