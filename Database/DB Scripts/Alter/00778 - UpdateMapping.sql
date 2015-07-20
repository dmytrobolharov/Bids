UPDATE    Mapping
SET              MapUrl = 'Style_WorkFlowItems.aspx', MapPageUrl = 'Style_DevelopmentMeas.aspx'
WHERE     (Map = '40000000-0000-0000-0000-000000000050')
GO
Delete from Mapping where (Map = '40000000-0000-0000-0000-000000000051')
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '778', GetDate())
GO
