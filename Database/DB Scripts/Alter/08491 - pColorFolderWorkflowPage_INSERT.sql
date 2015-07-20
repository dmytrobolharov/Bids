INSERT INTO pColorFolderWorkflowPage(
	ColorFolderID, ColorFolderWorkflowID, WorkStatus,
	CUser, CDate, MUser, MDate, Sort)
SELECT cf.ColorFolderID, '10000000-0000-0000-0000-000000000000', 1,
	'SYSTEM', GETDATE(), 'SYSTEM', GETDATE(), '0001'
FROM pColorFolder cf
LEFT JOIN pColorFolderWorkflowPage cfwp ON cf.ColorFolderID = cfwp.ColorFolderID 
	AND ColorFolderWorkflowID = '10000000-0000-0000-0000-000000000000'
WHERE cfwp.ColorFolderWorkflowPageID IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08491', GetDate())
GO
