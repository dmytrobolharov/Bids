IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DF_pWorkFlowItem_WorkFlowItemID]') AND type = 'D')
   BEGIN
        ALTER TABLE [pWorkFlowItem] DROP CONSTRAINT [DF_pWorkFlowItem_WorkFlowItemID]
   END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DF_pWorkFlowItem_WorkSort]') AND type = 'D')
   BEGIN
         ALTER TABLE [pWorkFlowItem] DROP CONSTRAINT [DF_pWorkFlowItem_WorkSort]
   END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'pWorkFlowItem' )
   BEGIN
        DROP TABLE pWorkFlowItem
   END
GO
 
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE TABLE [pWorkFlowItem](
             [WorkFlowItemID] [uniqueidentifier] NOT NULL,
             [WorkflowID] [uniqueidentifier] NOT NULL,
             [WorkflowItemTypeId] [uniqueidentifier] NOT NULL,
             [StyleID] [uniqueidentifier] NOT NULL,
             [WorkFlowItemName] [nvarchar](100) NULL,
             [Sort] [nvarchar](4) NULL,
             [CUser] [nvarchar](100) NULL,
             [CDate] [datetime] NULL,
             [MUser] [nvarchar](100) NULL,
             [MDate] [datetime] NULL,
              CONSTRAINT [PK_pWorkFlowItem] PRIMARY KEY CLUSTERED 
                         ( [WorkFlowItemID] ASC )
                    WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF,
                          IGNORE_DUP_KEY = OFF, 
                          ALLOW_ROW_LOCKS  = ON, 
                          ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_StyleId] ON [pWorkFlowItem] 
       ( [StyleID] ASC ) 
       WITH (PAD_INDEX  = OFF, 
             STATISTICS_NORECOMPUTE  = OFF,
             SORT_IN_TEMPDB = OFF, 
             IGNORE_DUP_KEY = OFF,
             DROP_EXISTING = OFF,
             ONLINE = OFF,
             ALLOW_ROW_LOCKS  = ON,
             ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_WorkFlowId] ON [pWorkFlowItem] 
       ( [WorkflowID] ASC )
       WITH (PAD_INDEX  = OFF, 
             STATISTICS_NORECOMPUTE  = OFF,
             SORT_IN_TEMPDB = OFF, 
             IGNORE_DUP_KEY = OFF,
             DROP_EXISTING = OFF,
             ONLINE = OFF,
             ALLOW_ROW_LOCKS  = ON,
             ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_WorkflowItemTypeId] ON [pWorkFlowItem] 
       ( [WorkflowItemTypeId] ASC )
       WITH (PAD_INDEX  = OFF, 
             STATISTICS_NORECOMPUTE  = OFF,
             SORT_IN_TEMPDB = OFF, 
             IGNORE_DUP_KEY = OFF,
             DROP_EXISTING = OFF,
             ONLINE = OFF,
             ALLOW_ROW_LOCKS  = ON,
             ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


ALTER TABLE [pWorkFlowItem] ADD  CONSTRAINT [DF_pWorkFlowItem_WorkFlowItemID]  DEFAULT (newid()) FOR [WorkFlowItemID]
GO

ALTER TABLE [pWorkFlowItem] ADD  CONSTRAINT [DF_pWorkFlowItem_WorkSort]  DEFAULT ((0)) FOR [Sort]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '669', GetDate())
GO