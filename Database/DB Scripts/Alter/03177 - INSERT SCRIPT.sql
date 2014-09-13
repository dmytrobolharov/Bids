INSERT INTO dbo.Mapping
        ( Map ,
          MapDetail ,
          MapUrl ,
          MapEditUrl ,
          MapEmlUrl ,
          MapFolder ,
          Sort ,
          MapConceptUrl ,
          MapConceptEditUrl ,
          MapPageUrl
        )
VALUES  ( '40000000-0000-0000-0000-000000000999' , -- Map - uniqueidentifier
          'Rough' , -- MapDetail - nvarchar(200)
          'Style_WorkFlowItems.aspx' , -- MapUrl - nvarchar(500)
          'Style_DesignDetailForm_Edit.aspx' , -- MapEditUrl - nvarchar(100)
          'Style_DesignDetailForm_Eml.aspx' , -- MapEmlUrl - nvarchar(50)
          'StyleFolder' , -- MapFolder - nvarchar(50)
          'A11' , -- Sort - nvarchar(5)
          NULL , -- MapConceptUrl - nvarchar(500)
          NULL , -- MapConceptEditUrl - nvarchar(500)
          'Style_DesignDetailForm.aspx'  -- MapPageUrl - nvarchar(50)
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
          MapConceptEditUrl ,
          MapPageUrl
        )
VALUES  ( '40000000-0000-0000-0000-000000000888' , -- Map - uniqueidentifier
          'Colorway Images' , -- MapDetail - nvarchar(200)
          'Style_ColorwaySeasonal_Image.aspx' , -- MapUrl - nvarchar(500)
          'Style_ColorwaySeasonal_Image_Edit.aspx' , -- MapEditUrl - nvarchar(100)
          NULL , -- MapEmlUrl - nvarchar(50)
          'StyleFolder' , -- MapFolder - nvarchar(50)
          NULL , -- Sort - nvarchar(5)
          NULL , -- MapConceptUrl - nvarchar(500)
          NULL , -- MapConceptEditUrl - nvarchar(500)
          NULL  -- MapPageUrl - nvarchar(50)
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
          MapConceptEditUrl ,
          MapPageUrl
        )
VALUES  ( '40000000-0000-0000-0000-000000000777' , -- Map - uniqueidentifier
          'Back' , -- MapDetail - nvarchar(200)
          'Style_WorkFlowItems.aspx' , -- MapUrl - nvarchar(500)
          'Style_DesignDetailForm_Edit.aspx' , -- MapEditUrl - nvarchar(100)
          'Style_DesignDetailForm_Eml.aspx' , -- MapEmlUrl - nvarchar(50)
          'StyleFolder' , -- MapFolder - nvarchar(50)
          'A11' , -- Sort - nvarchar(5)
          NULL , -- MapConceptUrl - nvarchar(500)
          NULL , -- MapConceptEditUrl - nvarchar(500)
          'Style_DesignDetailForm.aspx'  -- MapPageUrl - nvarchar(50)
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
          MapConceptEditUrl ,
          MapPageUrl
        )
VALUES  ( '70000000-0000-0000-0000-000000000999' , -- Map - uniqueidentifier
          'Design Image' , -- MapDetail - nvarchar(200)
          'Style_DesignDetail_FrontBack_Image_View.aspx' , -- MapUrl - nvarchar(500)
          'Style_DesignDetail_FrontBack_Image.aspx' , -- MapEditUrl - nvarchar(100)
          'Style_DesignDetail_FrontBack_Image_View.aspx' , -- MapEmlUrl - nvarchar(50)
          'StyleFolder' , -- MapFolder - nvarchar(50)
          'A11' , -- Sort - nvarchar(5)
          NULL , -- MapConceptUrl - nvarchar(500)
          NULL , -- MapConceptEditUrl - nvarchar(500)
          'Style_DesignDetail_FrontBack_Image_View.aspx'  -- MapPageUrl - nvarchar(50)
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
          MapConceptEditUrl ,
          MapPageUrl
        )
VALUES  ( '60000000-0000-0000-0000-000000000666' , -- Map - uniqueidentifier
          'Artwork Image' , -- MapDetail - nvarchar(200)
          'Style_MaterialArtwork_Image.aspx' , -- MapUrl - nvarchar(500)
          'Style_MaterialArtwork_Image_Edit.aspx' , -- MapEditUrl - nvarchar(100)
          'Style_MaterialArtwork_Image.aspx' , -- MapEmlUrl - nvarchar(50)
          'StyleFolder' , -- MapFolder - nvarchar(50)
          'A11' , -- Sort - nvarchar(5)
          NULL , -- MapConceptUrl - nvarchar(500)
          NULL , -- MapConceptEditUrl - nvarchar(500)
          'Style_MaterialArtwork_Image.aspx'  -- MapPageUrl - nvarchar(50)
        )    
        
                           

INSERT INTO dbo.pImageWFValidation
        ( CustomID ,
          WorkflowID ,
          CustomKey ,
          Min ,
          Max ,
          ByColorway ,
          ByArtwork ,
          plmOn ,
          srmOn ,
          Sort ,
          CUser ,
          CDate ,
          MUser ,
          MDate,
          IsFrontBackWF
        )
VALUES  ( NEWID() , -- CustomID - uniqueidentifier
          '40000000-0000-0000-0000-000000000999' , -- WorkflowID - uniqueidentifier
          'Rough' , -- CustomKey - nvarchar(200)
          '1' , -- Min - nvarchar(5)
          '3' , -- Max - nvarchar(5)
          0 , -- ByColorway - bit
          1 , -- ByArtwork - bit
          0 , -- plmOn - bit
          1 , -- srmOn - bit
          '1' , -- Sort - nvarchar(5)
          'GerberAdmin' , -- CUser - nvarchar(200)
          '2012-02-02 16:06:20' , -- CDate - datetime
          'GerberAdmin' , -- MUser - nvarchar(200)
          '2012-02-02 16:06:20',  -- MDate - datetime
          0
        )
        
        
INSERT INTO dbo.pImageWFValidation
        ( CustomID ,
          WorkflowID ,
          CustomKey ,
          Min ,
          Max ,
          ByColorway ,
          ByArtwork ,
          plmOn ,
          srmOn ,
          Sort ,
          CUser ,
          CDate ,
          MUser ,
          MDate ,
          IsFrontBackWF
        )
VALUES  ( NEWID() , -- CustomID - uniqueidentifier
          '40000000-0000-0000-0000-000000000777' , -- WorkflowID - uniqueidentifier
          'Back Image' , -- CustomKey - nvarchar(200)
          '1' , -- Min - nvarchar(5)
          '1' , -- Max - nvarchar(5)
          0 , -- ByColorway - bit
          1 , -- ByArtwork - bit
          0 , -- plmOn - bit
          1 , -- srmOn - bit
          '1' , -- Sort - nvarchar(5)
          'GerberAdmin' , -- CUser - nvarchar(200)
          '2012-02-02 16:06:20' , -- CDate - datetime
          'GerberAdmin' , -- MUser - nvarchar(200)
          '2012-02-02 16:06:20',  -- MDate - datetime
          1
        )
        
INSERT INTO dbo.pImageWFValidation
        ( CustomID ,
          WorkflowID ,
          CustomKey ,
          Min ,
          Max ,
          ByColorway ,
          ByArtwork ,
          plmOn ,
          srmOn ,
          Sort ,
          CUser ,
          CDate ,
          MUser ,
          MDate,
          IsFrontBackWF
        )
VALUES  ( NEWID() , -- CustomID - uniqueidentifier
          '70000000-0000-0000-0000-000000000999' , -- WorkflowID - uniqueidentifier
          'Design Image' , -- CustomKey - nvarchar(200)
          '1' , -- Min - nvarchar(5)
          '2' , -- Max - nvarchar(5)
          0 , -- ByColorway - bit
          1 , -- ByArtwork - bit
          0 , -- plmOn - bit
          0 , -- srmOn - bit
          '1' , -- Sort - nvarchar(5)
          'GerberAdmin' , -- CUser - nvarchar(200)
          '2012-02-02 16:06:20' , -- CDate - datetime
          'GerberAdmin' , -- MUser - nvarchar(200)
          '2012-02-02 16:06:20',  -- MDate - datetime
          0
        )  
        
        
         
INSERT INTO dbo.pImageWFValidation
        ( CustomID ,
          WorkflowID ,
          CustomKey ,
          Min ,
          Max ,
          ByColorway ,
          ByArtwork ,
          plmOn ,
          srmOn ,
          Sort ,
          CUser ,
          CDate ,
          MUser ,
          MDate,
          IsFrontBackWF
        )
VALUES  ( NEWID() , -- CustomID - uniqueidentifier
          '60000000-0000-0000-0000-000000000666' , -- WorkflowID - uniqueidentifier
          'Artwork Image' , -- CustomKey - nvarchar(200)
          '1' , -- Min - nvarchar(5)
          '5' , -- Max - nvarchar(5)
          0 , -- ByColorway - bit
          1 , -- ByArtwork - bit
          0 , -- plmOn - bit
          0 , -- srmOn - bit
          '1' , -- Sort - nvarchar(5)
          'GerberAdmin' , -- CUser - nvarchar(200)
          '2012-02-02 16:06:20' , -- CDate - datetime
          'GerberAdmin' , -- MUser - nvarchar(200)
          '2012-02-02 16:06:20',  -- MDate - datetime
          0
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
VALUES  ( '70000000-0000-0000-0000-000000000999' , -- WorkflowID - uniqueidentifier
          'Design Image' , -- Workflow - nvarchar(100)
          5 , -- WorkDays - int
          10 , -- WorkAlert - int
          6 , -- WorkflowSort - int
          NULL , -- CUser - nvarchar(100)
          '2012-02-01 20:45:07' , -- CDate - datetime
          NULL , -- MUser - nvarchar(100)
          '2012-02-01 20:45:07' , -- MDate - datetime
          'True' , -- Active - bit
          0 , -- Body - int
          'D'  -- WorkflowTypeID - varchar(1)
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
VALUES  ( '60000000-0000-0000-0000-000000000666' , -- WorkflowID - uniqueidentifier
          'Artwork Image' , -- Workflow - nvarchar(100)
          5 , -- WorkDays - int
          10 , -- WorkAlert - int
          6 , -- WorkflowSort - int
          NULL , -- CUser - nvarchar(100)
          '2012-02-01 20:45:07' , -- CDate - datetime
          NULL , -- MUser - nvarchar(100)
          '2012-02-01 20:45:07' , -- MDate - datetime
          'True' , -- Active - bit
          0 , -- Body - int
          'D'  -- WorkflowTypeID - varchar(1)
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
VALUES  ( '40000000-0000-0000-0000-000000000999' , -- WorkflowID - uniqueidentifier
          'Rough' , -- Workflow - nvarchar(100)
          5 , -- WorkDays - int
          10 , -- WorkAlert - int
          6 , -- WorkflowSort - int
          NULL , -- CUser - nvarchar(100)
          '2012-02-01 20:45:07' , -- CDate - datetime
          NULL , -- MUser - nvarchar(100)
          '2012-02-01 20:45:07' , -- MDate - datetime
          'True' , -- Active - bit
          0 , -- Body - int
          'D'  -- WorkflowTypeID - varchar(1)
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
VALUES  ( '70000000-0000-0000-0000-000000000001' , -- WorkflowID - uniqueidentifier
          'Style Header' , -- Workflow - nvarchar(100)
          0 , -- WorkDays - int
          0 , -- WorkAlert - int
          999 , -- WorkflowSort - int
          NULL , -- CUser - nvarchar(100)
          NULL , -- CDate - datetime
          NULL , -- MUser - nvarchar(100)
          NULL , -- MDate - datetime
          0 , -- Active - bit
          0 , -- Body - int
          'D'  -- WorkflowTypeID - varchar(1)
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
VALUES  ( '40000000-0000-0000-0000-000000000888' , -- WorkflowID - uniqueidentifier
          'Colorway Images' , -- Workflow - nvarchar(100)
          2 , -- WorkDays - int
          10 , -- WorkAlert - int
          4 , -- WorkflowSort - int
          NULL , -- CUser - nvarchar(100)
          NULL , -- CDate - datetime
          NULL , -- MUser - nvarchar(100)
          NULL , -- MDate - datetime
          'True' , -- Active - bit
          0 , -- Body - int
          'D'  -- WorkflowTypeID - varchar(1)
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
VALUES  ( '40000000-0000-0000-0000-000000000777' , -- WorkflowID - uniqueidentifier
          'Back' , -- Workflow - nvarchar(100)
          5 , -- WorkDays - int
          10 , -- WorkAlert - int
          6 , -- WorkflowSort - int
          NULL , -- CUser - nvarchar(100)
          '2012-02-01 20:45:07' , -- CDate - datetime
          NULL , -- MUser - nvarchar(100)
          '2012-02-01 20:45:07' , -- MDate - datetime
          'True' , -- Active - bit
          0 , -- Body - int
          'D'  -- WorkflowTypeID - varchar(1)
        )      
        
        
  INSERT INTO dbo.pWorkflowItemType
        ( WorkflowItemTypeId ,
          MapId ,
          SchemaFileName ,
          ItemTypeLabel ,
          SchemaFileEditName
        )
VALUES  ( '90000000-0000-0000-0000-000000000999' , -- WorkflowItemTypeId - uniqueidentifier
          '70000000-0000-0000-0000-000000000999' , -- MapId - uniqueidentifier
          NULL , -- SchemaFileName - nvarchar(200)
          'Design Image' , -- ItemTypeLabel - nvarchar(200)
          NULL  -- SchemaFileEditName - nvarchar(200)
        )
        
        

        
        
        
INSERT INTO dbo.pWorkflowItemType
        ( WorkflowItemTypeId ,
          MapId ,
          SchemaFileName ,
          ItemTypeLabel ,
          SchemaFileEditName
        )
VALUES  ( '70000000-0000-0000-0000-000000000444' , -- WorkflowItemTypeId - uniqueidentifier
          '60000000-0000-0000-0000-000000000666' , -- MapId - uniqueidentifier
          NULL , -- SchemaFileName - nvarchar(200)
          'Artwork Image' , -- ItemTypeLabel - nvarchar(200)
          NULL  -- SchemaFileEditName - nvarchar(200)
        )
        

        
        
                
INSERT INTO dbo.pWorkflowItemType
        ( WorkflowItemTypeId ,
          MapId ,
          SchemaFileName ,
          ItemTypeLabel ,
          SchemaFileEditName
        )
VALUES  ( '80000000-0000-0000-0000-000000000888' , -- WorkflowItemTypeId - uniqueidentifier
          '40000000-0000-0000-0000-000000000888' , -- MapId - uniqueidentifier
          NULL , -- SchemaFileName - nvarchar(200)
          'Colorway Image' , -- ItemTypeLabel - nvarchar(200)
          NULL  -- SchemaFileEditName - nvarchar(200)
        )
        
        
INSERT INTO dbo.pWorkflowItemType
        ( WorkflowItemTypeId ,
          MapId ,
          SchemaFileName ,
          ItemTypeLabel ,
          SchemaFileEditName
        )
VALUES  ( 'eb0ad425-a11d-497d-b03d-8dc1250adeb9' , -- WorkflowItemTypeId - uniqueidentifier
          '40000000-0000-0000-0000-000000000999' , -- MapId - uniqueidentifier
          NULL , -- SchemaFileName - nvarchar(200)
          'Rough' , -- ItemTypeLabel - nvarchar(200)
          NULL  -- SchemaFileEditName - nvarchar(200)
        )
        
        
INSERT INTO dbo.pWorkflowItemType
        ( WorkflowItemTypeId ,
          MapId ,
          SchemaFileName ,
          ItemTypeLabel ,
          SchemaFileEditName
        )
VALUES  ( NEWID() , -- WorkflowItemTypeId - uniqueidentifier
          '40000000-0000-0000-0000-000000000777' , -- MapId - uniqueidentifier
          NULL , -- SchemaFileName - nvarchar(200)
          'Back' , -- ItemTypeLabel - nvarchar(200)
          NULL  -- SchemaFileEditName - nvarchar(200)
        )
               
                
                
INSERT INTO dbo.pWorkflowStatus
        ( WorkflowStatusID ,
          WorkflowStatus ,
          WorkflowStatusImage ,
          Active ,
          WorkflowStatusRepId
        )
VALUES  ( 199 , -- WorkflowStatusID - int
          'Image(s) missing' , -- WorkflowStatus - nvarchar(100)
          'icon_ball_red.gif' , -- WorkflowStatusImage - nvarchar(100)
          'TRUE' , -- Active - bit
          NEWID()  -- WorkflowStatusRepId - uniqueidentifier
        )
        
        
INSERT INTO dbo.pWorkflowStatus
        ( WorkflowStatusID ,
          WorkflowStatus ,
          WorkflowStatusImage ,
          Active ,
          WorkflowStatusRepId
        )
VALUES  ( 299 , -- WorkflowStatusID - int
          'Extra Images' , -- WorkflowStatus - nvarchar(100)
          'icon_ball_red.gif' , -- WorkflowStatusImage - nvarchar(100)
          'TRUE' , -- Active - bit
          NEWID()  -- WorkflowStatusRepId - uniqueidentifier
        )
        
        
                
INSERT INTO dbo.pWorkflowStatus
        ( WorkflowStatusID ,
          WorkflowStatus ,
          WorkflowStatusImage ,
          Active ,
          WorkflowStatusRepId
        )
VALUES  ( 399 , -- WorkflowStatusID - int
          'Number of Images OK' , -- WorkflowStatus - nvarchar(100)
          'icon_fileok.gif' , -- WorkflowStatusImage - nvarchar(100)
          'TRUE' , -- Active - bit
          NEWID()  -- WorkflowStatusRepId - uniqueidentifier
        )     
        
UPDATE dbo.pStyleHeader SET DesignSketchBackID = '00000000-0000-0000-0000-000000000000' WHERE DesignSketchBackID IS NULL
UPDATE dbo.pStyleHeader SET DesignSketchBackVersion = 0 WHERE DesignSketchBackVersion IS NULL   


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03177', GetDate())

GO
      