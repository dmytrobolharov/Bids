Update pWorkflowItemType set ItemTypeLabel = 'Process Details' where MapId = '80000000-0000-0000-0000-000000000008' and ItemTypeLabel = 'Construction Details'
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01360', GetDate())
GO