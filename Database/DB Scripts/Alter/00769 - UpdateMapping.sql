UPDATE    Mapping
SET              MapUrl = 'Style_WorkFlowItems.aspx', MapPageUrl = 'Style_ConstructionDetail.aspx'
WHERE     (Map = '80000000-0000-0000-0000-000000000008')
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '769', GetDate())

GO