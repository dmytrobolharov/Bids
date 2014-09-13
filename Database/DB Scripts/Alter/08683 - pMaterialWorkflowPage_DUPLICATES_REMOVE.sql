DELETE mwp 
FROM pMaterialWorkflowPage mwp
INNER JOIN pMaterialTemplateItem pmti ON mwp.MaterialTemplateItemID = pmti.MaterialTemplateItemID
INNER JOIN pMaterial m ON mwp.MaterialID = m.MaterialID
LEFT JOIN pMaterialTemplateItem mti ON m.MaterialTemplateID = mti.MaterialTemplateID
	AND mwp.MaterialTemplatePageID = mti.MaterialTemplatePageID
	AND pmti.MaterialTemplateItemID = mti.MaterialTemplateItemID
WHERE mti.MaterialTemplateItemID IS NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08683', GetDate())
GO
