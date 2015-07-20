--
-- Setup pWorkFlow
--


--
-- Construction Details
-- 
IF EXISTS(SELECT * FROM pWorkflow WHERE WorkflowID = '80000000-0000-0000-0000-000000000008')
   BEGIN
        PRINT 'Construction Details WorkFlowId 80000000-0000-0000-0000-000000000008 already exists'
   END
ELSE
   BEGIN

        INSERT INTO pWorkFlow(WorkflowID
                             ,WorkFlow
                             ,WorkDays
                             ,WorkAlert
                             ,WorkflowSort
                             ,Active
                             ,Body
                             ,WorkFlowTypeId  )
         SELECT '80000000-0000-0000-0000-000000000008' AS WorkflowID
               ,'Construction Details' AS WorkFlow
               ,5   AS WorkDays
               ,10  AS WorkAlert
               ,8   AS WorkflowSort
               ,1   AS Active
               ,0   AS Body
               ,'D' AS WorkFlowTypeId
     END
GO 


--
-- AML
--
IF EXISTS(SELECT * FROM pWorkflow WHERE WorkflowID = '40000000-0000-0000-0000-000000000050')
   BEGIN
        PRINT 'AML WorkFlowId 40000000-0000-0000-0000-000000000050 already exists'
   END
ELSE
   BEGIN

        INSERT INTO pWorkFlow(WorkflowID
                             ,WorkFlow
                             ,WorkDays
                             ,WorkAlert
                             ,WorkflowSort
                             ,Active
                             ,Body
                             ,WorkFlowTypeId  )
         SELECT '40000000-0000-0000-0000-000000000050' AS WorkflowID
               ,'Measurement Finished' AS WorkFlow
               ,5   AS WorkDays
               ,10  AS WorkAlert
               ,6   AS WorkflowSort
               ,1   AS Active
               ,0   AS Body
               ,'D' AS WorkFlowTypeId
     END
GO 




IF EXISTS(SELECT * FROM pWorkflow WHERE WorkflowID = '40000000-0000-0000-0000-000000000018')
   BEGIN
        PRINT 'Design Detail 2 WorkFlowId 40000000-0000-0000-0000-000000000018 already exists'
   END
ELSE
   BEGIN

        INSERT INTO pWorkFlow(WorkflowID
                             ,WorkFlow
                             ,WorkDays
                             ,WorkAlert
                             ,WorkflowSort
                             ,Active
                             ,Body
                             ,WorkFlowTypeId  )
         SELECT '80000000-0000-0000-0000-000000000008' AS WorkflowID
               ,'Design Detail 2' AS WorkFlow
               ,5   AS WorkDays
               ,10  AS WorkAlert
               ,6   AS WorkflowSort
               ,1   AS Active
               ,0   AS Body
               ,'D' AS WorkFlowTypeId
     END
GO 

IF EXISTS( SELECT * FROM pWorkflow WHERE WorkflowID = '11111111-0000-0000-0000-000000000003')
BEGIN
        PRINT 'Body - Pattern Sheet WorkFlowId 11111111-0000-0000-0000-000000000003 already exists'
END

ELSE

BEGIN

INSERT INTO [dbo].[pWorkflow]
           ([WorkflowID]
           ,[Workflow]
           ,[WorkDays]
           ,[WorkAlert]
           ,[CDate]
           ,[MDate]
           ,[Active]
           ,[Body]
           ,[WorkflowTypeID])
     VALUES
           ('11111111-0000-0000-0000-000000000003'
           ,'Body - Pattern Sheet'
           ,2
           ,10
           ,Getdate()
           ,Getdate()
           ,1
           ,1
           ,'D')
END
GO

IF EXISTS( SELECT * FROM pWorkflow WHERE WorkflowID = '11111111-0000-0000-0000-000000000004')
BEGIN
         PRINT 'Body-Marker WorkFlowId 11111111-0000-0000-0000-000000000004 already exists'
END

ELSE
BEGIN
INSERT INTO [dbo].[pWorkflow]
           ([WorkflowID]
           ,[Workflow]
           ,[WorkDays]
           ,[WorkAlert]
           ,[CDate]
           ,[MDate]
           ,[Active]
           ,[Body]
           ,[WorkflowTypeID])
     VALUES
           ('11111111-0000-0000-0000-000000000004'
           ,'Body-Marker'
           ,2
           ,10
           ,Getdate()
           ,Getdate()
           ,1
           ,1
           ,'D')
END
GO

--
-- Setup Mapping
--


-- Mapping Construction Details

IF EXISTS(SELECT * FROM Mapping WHERE Map = '80000000-0000-0000-0000-000000000008')
   BEGIN
        PRINT 'Mapping Construction Details 80000000-0000-0000-0000-000000000008 already exists'
   END
ELSE
   BEGIN

        INSERT INTO Mapping( Map
                            ,MapDetail
                            ,MapUrl
                            ,MapEditUrl
                            ,MapFolder
                            ,MapPageUrl )
         SELECT '80000000-0000-0000-0000-000000000008' AS WorkflowID
               ,'Construction Details'                 AS WorkFlow
               ,'Style_WorkFlowItems.aspx'             AS MapUrl
               ,'Style_ConstructionDetail_Edit.aspx'   AS MapEditUrl
               ,'StyleFolder'                          AS MapFolder
               ,'Style_ConstructionDetail.aspx'        AS MapPageUrl
     END
GO 

--
-- Mapping for AML
--

IF EXISTS(SELECT * FROM Mapping WHERE Map = '40000000-0000-0000-0000-000000000050')
   BEGIN
        PRINT 'Mapping AML 40000000-0000-0000-0000-000000000050 already exists'
   END
ELSE
   BEGIN
        INSERT INTO Mapping( Map
                            ,MapDetail
                            ,MapUrl
                            ,MapEditUrl
                            ,MapEmlUrl
                            ,MapFolder
                            ,MapPageUrl )
         SELECT '40000000-0000-0000-0000-000000000050' AS Map
               ,'Measurement Finished'                 AS MapDetail
               ,'Style_WorkFlowItems.aspx'             AS MapUrl
               ,'Style_DevelopmentMeas_Edit.aspx'      AS MapEditUrl
               ,'Style_DevelopmentMeas_Eml.aspx'       AS MapEmlUrl
               ,'StyleFolder'                          AS MapFolder
               ,'Style_DevelopmentMeas.aspx'           AS MapPageUrl
     END
GO 



IF EXISTS(SELECT * FROM Mapping WHERE Map = '40000000-0000-0000-0000-000000000018')
   BEGIN
        PRINT 'Design Detail 2 40000000-0000-0000-0000-000000000018 already exists'
   END
ELSE
   BEGIN
        INSERT INTO Mapping( Map
                            ,MapDetail
                            ,MapUrl
                            ,MapEditUrl
                            ,MapEmlUrl
                            ,MapFolder
                            ,MapPageUrl
                            ,Sort )
         SELECT '40000000-0000-0000-0000-000000000018' AS Map
               ,'Design Detail 2'                      AS MapDetail
               ,'Style_WorkFlowItems.aspx'             AS MapUrl
               ,'Style_DesignDetailForm_Edit.aspx'     AS MapEditUrl
               ,'Style_DesignDetailForm_Eml.aspx'      AS MapEmlUrl
               ,'StyleFolder'                          AS MapFolder
               ,'Style_DesignDetailForm.aspx'          AS MapPageUrl
               ,'A05'                                  AS Sort
     END
GO



IF EXISTS(SELECT * FROM Mapping WHERE Map = '11111111-0000-0000-0000-000000000003')
   BEGIN
        PRINT 'Body - Pattern Sheet 11111111-0000-0000-0000-000000000003  already exists'
   END
ELSE
   BEGIN
        INSERT INTO Mapping( Map
                            ,MapDetail
                            ,MapUrl
                            ,MapEditUrl
                            ,MapEmlUrl
                            ,MapFolder
                            ,MapPageUrl
                            ,Sort )
         SELECT '11111111-0000-0000-0000-000000000003' AS Map
               ,'Body - Pattern Sheet'                 AS MapDetail
               ,'../Body/Body_PatternSheet.aspx'       AS MapUrl
               ,'../Body/Body_PatternSheet_Edit.aspx'  AS MapEditUrl
               ,Null                                   AS MapEmlUrl
               ,'Body Folder'                          AS MapFolder
               ,Null                                   AS MapPageUrl
               ,Null                                   AS Sort
     END
GO

IF EXISTS(SELECT * FROM Mapping WHERE Map = '11111111-0000-0000-0000-000000000004')
   BEGIN
        PRINT 'Body - Marker 11111111-0000-0000-0000-000000000004  already exists'
   END
ELSE
   BEGIN
        INSERT INTO Mapping( Map
                            ,MapDetail
                            ,MapUrl
                            ,MapEditUrl
                            ,MapEmlUrl
                            ,MapFolder
                            ,MapPageUrl
                            ,Sort )
         SELECT '11111111-0000-0000-0000-000000000004' AS Map
               ,'Body - Marker'                        AS MapDetail
               ,'../Body/Body_Marker.aspx'             AS MapUrl
               ,'../Body/Body_Marker_Edit.aspx'        AS MapEditUrl
               ,Null                                   AS MapEmlUrl
               ,'Body Folder'                          AS MapFolder
               ,Null                                   AS MapPageUrl
               ,Null                                   AS Sort
     END
GO


IF EXISTS(SELECT * FROM Mapping WHERE Map = '40000000-0000-0000-0000-000000000023')
   BEGIN
        PRINT 'Marker 40000000-0000-0000-0000-000000000023  already exists'
   END
ELSE
   BEGIN
        INSERT INTO Mapping( Map
                            ,MapDetail
                            ,MapUrl
                            ,MapEditUrl
                            ,MapEmlUrl
                            ,MapFolder
                            ,MapPageUrl
                            ,Sort )
         SELECT '40000000-0000-0000-0000-000000000023' AS Map
               ,'Style-Marker'                         AS MapDetail
               ,'Style_Marker.aspx'                    AS MapUrl
               ,'Style_Marker_Edit.aspx'               AS MapEditUrl
               ,Null                                   AS MapEmlUrl
               ,'Style Folder'                         AS MapFolder
               ,Null                                   AS MapPageUrl
               ,Null                                   AS Sort
     END
GO

IF EXISTS(SELECT * FROM Mapping WHERE Map = '40000000-0000-0000-0000-000000000037')
   BEGIN
        PRINT 'Model 40000000-0000-0000-0000-000000000037  already exists'
   END
ELSE
   BEGIN
        INSERT INTO Mapping( Map
                            ,MapDetail
                            ,MapUrl
                            ,MapEditUrl
                            ,MapEmlUrl
                            ,MapFolder
                            ,MapPageUrl
                            ,Sort )
         SELECT '40000000-0000-0000-0000-000000000037' AS Map
               ,'Style-Model'                          AS MapDetail
               ,'Style_Model.aspx'                     AS MapUrl
               ,'Style_Model_Edit.aspx'                AS MapEditUrl
               ,Null                                   AS MapEmlUrl
               ,'Style Folder'                         AS MapFolder
               ,Null                                   AS MapPageUrl
               ,Null                                   AS Sort
     END
GO


--
-- Setup Control Panel
--        


-- Construction Details


IF EXISTS(SELECT * FROM pControlPanel WHERE ControlPanelName = 'Construction Details')
   BEGIN
        PRINT 'pControlPanel Construction Details already exists'
   END
ELSE
   BEGIN

        INSERT INTO pControlPanel ( ControlPanelID
                                   ,ControlPanelName
                                   ,ControlPanelDescription
                                   ,ControlPanelOrder
                                   ,ControlPanelTableName
                                   ,ControlPanelUrl )
         SELECT 326 AS ControlPanelID
               ,'Construction Details'                 AS ControlPanelName
               ,'Construction Details'                 AS ControlPanelDescription
               ,281                                    AS ControlPanelOrder
               ,'pConstructTree'                       AS ControlPanelTableName
               ,'Control_ConstructionDetails_List.aspx?CPID=326' AS ControlPanelUrl
     END
GO

-- Measurements (POMs)   


IF EXISTS(SELECT * FROM pControlPanel WHERE ControlPanelName = 'Measurements')
   BEGIN
        PRINT 'pControlPanel Measurements already exists'
   END
ELSE
   BEGIN

        INSERT INTO pControlPanel ( ControlPanelID
                                   ,ControlPanelName
                                   ,ControlPanelDescription
                                   ,ControlPanelOrder
                                   ,ControlPanelTableName
                                   ,ControlPanelUrl )
         SELECT 15 AS ControlPanelID
               ,'Measurements'                 AS ControlPanelName
               ,'Measurements Library'         AS ControlPanelDescription
               ,2                              AS ControlPanelOrder
               ,Null                           AS ControlPanelTableName
               ,'Control_Measurement.aspx?CPID=15' AS ControlPanelUrl
     END
GO


--
-- pWorkFlowItemType
--

IF EXISTS(SELECT * FROM pWorkFlowItemType Where MapId = '80000000-0000-0000-0000-000000000008')
   BEGIN
        PRINT 'Construction Details WorkFlowItemType 80000000-0000-0000-0000-000000000008 already exists'
   END
ELSE
   BEGIN
        INSERT INTO pWorkFlowItemType ( WorkflowItemTypeid
                                       ,Mapid
                                       ,SchemaFileName
                                       ,ItemTypeLabel
                                      ,SchemaFileEditName )
         SELECT          newid() as WorkflowItemTypeid
                         , '80000000-0000-0000-0000-000000000008' as Mapid
                         ,'Style_ConstructionDetails.xml' AS SchemaFileName
                         ,'Construction Details' AS ItemTypeLabel
                         ,'Style_ConstructionDetails_Edit.xml' AS SchemaFileEditName
   END
GO

IF EXISTS(SELECT * FROM pWorkFlowItemType Where MapId = '40000000-0000-0000-0000-000000000050')
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
                         ,'AML Measurement Specification Worksheet' AS ItemTypeLabel
                         ,'Style_MeasRead_Default.xml' AS SchemaFileEditName
   END
GO


IF EXISTS(SELECT * FROM pWorkFlowItemType Where MapId = '40000000-0000-0000-0000-000000000018')
   BEGIN
        PRINT 'Design Detail2 WorkFlowItemType 40000000-0000-0000-0000-000000000018 already exists'
   END
ELSE
   BEGIN
        INSERT INTO pWorkFlowItemType ( WorkflowItemTypeid
                                       ,Mapid
                                       ,SchemaFileName
                                       ,ItemTypeLabel
                                      ,SchemaFileEditName )
         SELECT          newid() as WorkflowItemTypeid
                         , '40000000-0000-0000-0000-000000000018' AS Mapid
                         ,Null                                    AS SchemaFileName
                         ,'Text Form'                             AS ItemTypeLabel
                         ,Null AS SchemaFileEditName
   END
GO

--
-- Template
--


IF EXISTS(SELECT * FROM pWorkflowTemplate WHERE TemplateName = 'WebPDM Workflow')
   BEGIN
        PRINT 'webPDM WorkFlow Template already exists'
   END
ELSE
   BEGIN
         INSERT INTO pWorkflowTemplate(
                      WorkflowTemplateID ,
                      TemplateName ,
                      TemplateDescription ,
                      CUser ,
                      CDate ,
                      MUser ,
                      MDate ,
                      Active ,
                      Body ,
                      Custom1 ,
                      Custom2 )
          VALUES  ( NEWID() , -- WorkflowTemplateID - uniqueidentifier
                    'WebPDM Workflow' , -- TemplateName - nvarchar(100)
                    'WebPDM Workflow' , -- TemplateDescription - nvarchar(250)
                    'Yunify' , -- CUser - nvarchar(100)
                    GETUTCDATE() , -- CDate - datetime
                    'Yunify' , -- MUser - nvarchar(100)
                    GETUTCDATE() , -- MDate - datetime
                     1 , -- Active - nvarchar(5)
                     0 , -- Body - int
                    NULL , -- Custom1 - nvarchar(50)
                    NULL  -- Custom2 - nvarchar(50)
                    )
    END
GO


IF EXISTS(SELECT * FROM pWorkflowTemplate WHERE TemplateName = 'Body')
   BEGIN
        PRINT 'Body Template already exists'
   END
ELSE
   BEGIN
         INSERT INTO pWorkflowTemplate(
                      WorkflowTemplateID ,
                      TemplateName ,
                      TemplateDescription ,
                      CUser ,
                      CDate ,
                      MUser ,
                      MDate ,
                      Active ,
                      Body ,
                      Custom1 ,
                      Custom2 )
          VALUES  ( NEWID() , -- WorkflowTemplateID - uniqueidentifier
                    'Body' , -- TemplateName - nvarchar(100)
                    'Body' , -- TemplateDescription - nvarchar(250)
                    'Yunify' , -- CUser - nvarchar(100)
                    GETUTCDATE() , -- CDate - datetime
                    'Yunify' , -- MUser - nvarchar(100)
                    GETUTCDATE() , -- MDate - datetime
                     1 , -- Active - nvarchar(5)
                     0 , -- Body - int
                    NULL , -- Custom1 - nvarchar(50)
                    NULL  -- Custom2 - nvarchar(50)
                    )
    END
GO





IF EXISTS( SELECT * FROM pWorkflow WHERE WorkflowID = '40000000-0000-0000-0000-000000000023')
BEGIN
      PRINT 'Marker Workflow already exists'
END

ELSE
BEGIN

INSERT INTO [dbo].[pWorkflow]
           ([WorkflowID]
           ,[Workflow]
           ,[CDate]
           ,[MDate]
           ,[Active]
           ,[Body]
           ,[WorkflowTypeID])
     VALUES
           ('40000000-0000-0000-0000-000000000023'
           ,'Marker'
           ,Getdate()
           ,Getdate()
           ,1
           ,0
           ,'D')
END
GO



IF EXISTS( SELECT * FROM pWorkflow WHERE WorkflowID = '40000000-0000-0000-0000-000000000037')
BEGIN
      PRINT 'Model Workflow already exists'
END

ELSE

BEGIN

INSERT INTO [dbo].[pWorkflow]
           ([WorkflowID]
           ,[Workflow]
           ,[CDate]
           ,[MDate]
           ,[Active]
           ,[Body]
           ,[WorkflowTypeID])
     VALUES
           ('40000000-0000-0000-0000-000000000037'
           ,'Model'
           ,Getdate()
           ,Getdate()
           ,1
           ,0
           ,'D')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '00982', GetDate())
GO