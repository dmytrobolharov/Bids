INSERT INTO dbo.pStyleDetailGridControl
        ( WorkflowID ,
          ControlPanelID ,
          SchemaFile ,
          SPXInsert ,
          SPXTemplateInsert ,
          SPXCopyInsert ,
          SPXControlGridItemInsert ,
          ControlPanelItemSchema
        )
VALUES  ( '90000000-0000-0000-0000-000000000009' , -- WorkflowID - uniqueidentifier
          NULL , -- ControlPanelID - int
          'Style_DetailGrid_Custom_Default.xml' , -- SchemaFile - nvarchar(200)
          'spx_StyleDetailGrid_Custom1_INSERT' , -- SPXInsert - nvarchar(200)
          NULL , -- SPXTemplateInsert - nvarchar(200)
          'spx_StyleDetailGrid_Custom1_Copy_INSERT' , -- SPXCopyInsert - nvarchar(200)
          NULL , -- SPXControlGridItemInsert - nvarchar(200)
          NULL  -- ControlPanelItemSchema - nvarchar(200)
        )
        
        
 INSERT INTO dbo.Mapping
         ( Map ,
           MapDetail ,
           MapUrl ,
           MapEditUrl ,
           MapEmlUrl ,
           MapFolder ,
           Sort ,
           MapConceptUrl ,
           MapConceptEditUrl
         )
 VALUES  ( '90000000-0000-0000-0000-000000000009' , -- Map - uniqueidentifier
           'Design Detail Custom' , -- MapDetail - nvarchar(50)
           'Style_DesignDetail_Custom.aspx' , -- MapUrl - nvarchar(500)
           'Style_DesignDetail_Custom_Edit.aspx' , -- MapEditUrl - nvarchar(100)
           NULL , -- MapEmlUrl - nvarchar(50)
           'StyleFolder' , -- MapFolder - nvarchar(50)
           NULL , -- Sort - nvarchar(5)
           NULL , -- MapConceptUrl - nvarchar(500)
           NULL  -- MapConceptEditUrl - nvarchar(500)
         )   
         
         			
   INSERT INTO dbo.pWorkflow
           ( WorkflowID ,
             Workflow ,
             WorkDays ,
             WorkAlert ,
             WorkflowSort ,
             CUser ,
             CDate ,
             MUser ,
             MDate ,
             Active ,
             Body ,
             WorkflowTypeID
           )
   VALUES  ( '90000000-0000-0000-0000-000000000009' , -- WorkflowID - uniqueidentifier
             'Design Detail Custom' , -- Workflow - nvarchar(100)
             5 , -- WorkDays - int
             10 , -- WorkAlert - int
             6 , -- WorkflowSort - int
             'Daniel Pak' , -- CUser - nvarchar(100)
             '2010-10-20 18:28:36' , -- CDate - datetime
             'Daniel Pak' , -- MUser - nvarchar(100)
             '2010-10-20 18:28:36' , -- MDate - datetime
             'True' , -- Active - bit
             0 , -- Body - int
             'D'  -- WorkflowTypeID - varchar(1)
           )   
           
           
           
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '611', GetDate())
GO  
        
        
        		