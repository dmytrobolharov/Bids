UPDATE    Mapping
SET              MapUrl = 'Style_WorkFlowItems.aspx', MapPageUrl = 'Style_DesignDetailForm.aspx'
WHERE     (Map = '40000000-0000-0000-0000-000000000018')
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '922', GetDate())
GO
