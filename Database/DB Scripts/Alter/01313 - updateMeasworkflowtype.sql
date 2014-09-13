IF EXISTS(SELECT * FROM pWorkFlowItemType Where MapId = '40000000-0000-0000-0000-000000000050' and ItemTypeLabel='Measurement Worksheet')
   BEGIN
        PRINT 'AML WorkFlowItemType 40000000-0000-0000-0000-000000000050 already exists'
   END
ELSE
   BEGIN
        INSERT INTO pWorkFlowItemType ( WorkflowItemTypeid
                                       ,Mapid
                                       ,SchemaFileName
                                       ,ItemTypeLabel
                                      ,SchemaFileEditName )
         SELECT          newid() as WorkflowItemTypeid
                         , '40000000-0000-0000-0000-000000000050' as Mapid
                         ,'Style_Meas_Default.xml' AS SchemaFileName
                         ,'Measurement Worksheet' AS ItemTypeLabel
                         ,'Style_MeasRead_Default.xml' AS SchemaFileEditName
   END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01313', GetDate())
GO