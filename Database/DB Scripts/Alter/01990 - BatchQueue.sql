IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueue]') AND type = N'U')
	DROP TABLE dbo.pBatchQueue
GO


CREATE TABLE [dbo].[pBatchQueue](
	[BatchQueueID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueTypeID] [uniqueidentifier] NULL,
	[BatchQueueName] [nvarchar](200) NULL,
	[BatchQueueDesc] [varchar](4000) NULL,
	[BatchQueueUrl] [varchar](200) NULL,
	[BatchQueueIcon] [varchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[BatchQueuePageHistoryUrl] [nvarchar](400) NULL,
 CONSTRAINT [PK_pBatchQueue] PRIMARY KEY CLUSTERED 
(
	[BatchQueueID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueForm]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueForm
GO

CREATE TABLE [dbo].[pBatchQueueForm](
	[BatchQueueFormID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueuePageID] [uniqueidentifier] NULL,
	[BatchQueueFormName] [nvarchar](200) NULL,
	[BatchQueueFormSeq] [int] NULL,
	[BatchQueueFormPkName] [varchar](100) NULL,
	[BatchQueueFormSql] [varchar](max) NULL,
	[BatchQueueFormSPX] [varchar](400) NULL,
	[BatchQueueFormXml] [varchar](200) NULL,
 CONSTRAINT [PK_pBatchQueueForm] PRIMARY KEY CLUSTERED 
(
	[BatchQueueFormID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobItem]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueJobItem
GO

CREATE TABLE [dbo].[pBatchQueueJobItem](
	[BatchQueueJobItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueJobID] [uniqueidentifier] NULL,
	[BatchQueuePageID] [uniqueidentifier] NULL,
	[BatchQueueJobStatusID] [int] NULL,
	[BatchQueueJobCount] [int] NULL,
	[BatchQueueJobSeq] [varchar](5) NULL,
	[BatchQueueJobTable] [varchar](200) NULL,
 CONSTRAINT [PK__pBatchQu__81E1BEFF2B3C7405] PRIMARY KEY CLUSTERED 
(
	[BatchQueueJobItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueJob]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueJob
GO

CREATE TABLE [dbo].[pBatchQueueJob](
	[BatchQueueJobID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueID] [uniqueidentifier] NULL,
	[BatchQueueJobDate] [datetime] NULL,
	[BatchQueueJobTeamID] [uniqueidentifier] NULL,
	[BatchQueueJobStatusID] [uniqueidentifier] NOT NULL,
	[BatchQueueJobCompleted] [int] NULL,
	[Description] [nvarchar](400) NULL,
 CONSTRAINT [PK_pBatchQueueJob] PRIMARY KEY CLUSTERED 
(
	[BatchQueueJobID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueJobStatus]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueJobStatus
GO

CREATE TABLE [dbo].[pBatchQueueJobStatus](
	[BatchQueueJobStatusID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[STATUS] [nvarchar](200) NULL,
	[BatchQueueJobStatus] [nvarchar](200) NULL,
	[BatchQueueJobStatusIcon] [nvarchar](50) NULL,
 CONSTRAINT [PK_pBatchQueueJobStatus] PRIMARY KEY CLUSTERED 
(
	[BatchQueueJobStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueuePage]') AND type = N'U')
	DROP TABLE dbo.pBatchQueuePage
GO


CREATE TABLE [dbo].[pBatchQueuePage](
	[BatchQueuePageID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueuePageTypeID] [uniqueidentifier] NOT NULL,
	[BatchQueueID] [uniqueidentifier] NOT NULL,
	[BatchQueuePageOrder] [varchar](4) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pBatchQueuePage] PRIMARY KEY CLUSTERED 
(
	[BatchQueuePageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueuePageDep]') AND type = N'U')
	DROP TABLE dbo.pBatchQueuePageDep
GO

CREATE TABLE [dbo].[pBatchQueuePageDep](
	[BatchQueuePageDepID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueuePageID] [uniqueidentifier] NULL,
	[BatchQueuePageRelationID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBatchQueuePageDep] PRIMARY KEY CLUSTERED 
(
	[BatchQueuePageDepID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueuePageType]') AND type = N'U')
	DROP TABLE dbo.pBatchQueuePageType
GO

CREATE TABLE [dbo].[pBatchQueuePageType](
	[BatchQueuePageTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueuePageTypeName] [nvarchar](200) NULL,
	[BatchQueuePageTypeDesc] [nvarchar](4000) NULL,
	[BatchQueuePagePkID] [varchar](100) NULL,
	[BatchQueuePageXmlSearch] [varchar](200) NULL,
	[BatchQueuePageXmlForm] [varchar](200) NULL,
	[BatchQueuePageXmlGrid] [varchar](200) NULL,
	[BatchQueuePageXmlSelected] [varchar](200) NULL,
	[BatchQueuePageUrl] [varchar](400) NULL,
	[BatchQueuePageRecType] [varchar](10) NULL,
	[BatchQueuePageRecMax] [int] NULL,
	[BatchQueuePageSPX] [varchar](400) NULL,
	[BatchQueueExecuteSPX] [nvarchar](400) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[BatchQueueLogicInsertSPX] [nvarchar](200) NULL,
	[BatchQueuepageXMLGridAlternating] [nvarchar](200) NULL,
	[BatchQueueGridAlternatingName] [nvarchar](200) NULL,
	[BatchQueueGridXMLThumbnail] [nvarchar](200) NULL,
	[BatchQueuePageXmlColorGrid] [nvarchar](200) NULL,
 CONSTRAINT [PK_pBatchQueuePageType] PRIMARY KEY CLUSTERED 
(
	[BatchQueuePageTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleMaterialColorTmp]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueStyleMaterialColorTmp
GO


CREATE TABLE [dbo].[pBatchQueueStyleMaterialColorTmp](
	[StyleMaterialColorID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueJobID] [uniqueidentifier] NULL,
	[ColorCode] [nvarchar](200) NULL,
	[ColorName] [nvarchar](200) NULL,
	[MaterialColorID] [uniqueidentifier] NULL,
	[StyleMaterialID] [uniqueidentifier] NULL,
	[ColorPaletteID] [uniqueidentifier] NULL,
	[Reviewed] [int] NULL,
	[StyleColorItemID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBatchQueueStyleMaterialColorTmp] PRIMARY KEY CLUSTERED 
(
	[StyleMaterialColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleMaterialCoreColorTmp]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueStyleMaterialCoreColorTmp
GO


CREATE TABLE [dbo].[pBatchQueueStyleMaterialCoreColorTmp](
	[StyleMaterialCoreColorID] [uniqueidentifier] NOT NULL,
	[BatchQueueJobID] [uniqueidentifier] NULL,
	[ColorCode] [nvarchar](200) NULL,
	[ColorName] [nvarchar](200) NULL,
	[MaterialCoreColorID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBatchQueueStyleMaterialCoreColorTmp] PRIMARY KEY CLUSTERED 
(
	[StyleMaterialCoreColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleMaterialCoreItemTmp]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueStyleMaterialCoreItemTmp
GO

CREATE TABLE [dbo].[pBatchQueueStyleMaterialCoreItemTmp](
	[BatchQueueStyleMaterialCoreItemTmpID] [uniqueidentifier] NOT NULL,
	[BatchQueueJobID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[MaterialCoreItemID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBatchQueueStyleMaterialCoreItemTmp] PRIMARY KEY CLUSTERED 
(
	[BatchQueueStyleMaterialCoreItemTmpID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleMaterialSizeTmp]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueStyleMaterialSizeTmp
GO


CREATE TABLE [dbo].[pBatchQueueStyleMaterialSizeTmp](
	[StyleMaterialSizeID] [uniqueidentifier] NOT NULL,
	[BatchQueueJobID] [uniqueidentifier] NULL,
	[MaterialSizeOldID] [uniqueidentifier] NULL,
	[MaterialSizeNewID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBatchQueueStyleMaterialSizeTmp] PRIMARY KEY CLUSTERED 
(
	[StyleMaterialSizeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleMaterialTmp]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueStyleMaterialTmp
GO


CREATE TABLE [dbo].[pBatchQueueStyleMaterialTmp](
	[StyleMaterialID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueJobID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[MaterialID] [uniqueidentifier] NULL,
	[BBUsage] [nvarchar](200) NULL,
	[Qty] [decimal](18, 2) NULL,
	[MaterialSizeID] [uniqueidentifier] NULL,
	[Artwork] [int] NULL,
	[Colorway] [int] NULL,
	[Placement] [nvarchar](4000) NULL,
 CONSTRAINT [PK_pBatchQueueStyleMaterialTmp] PRIMARY KEY CLUSTERED 
(
	[StyleMaterialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueStyleWorkflow]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueStyleWorkflow
GO


CREATE TABLE [dbo].[pBatchQueueStyleWorkflow](
	[BatchQueueStyleWorkflowID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueID] [uniqueidentifier] NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[Workflow] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[BatchQueueStyleWorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBatchQueueType]') AND type = N'U')
	DROP TABLE dbo.pBatchQueueType
GO


CREATE TABLE [dbo].[pBatchQueueType](
	[BatchQueueTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BatchQueueTypeName] [nvarchar](100) NULL,
	[BatchQueueTypeDesc] [nvarchar](4000) NULL,
	[BatchQueueTypeURL] [varchar](200) NULL,
	[BatchQueueTypeIcon] [varchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pBatchQueueType] PRIMARY KEY CLUSTERED 
(
	[BatchQueueTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[pBatchQueue] ADD  DEFAULT (newsequentialid()) FOR [BatchQueueID]
GO

ALTER TABLE [dbo].[pBatchQueueForm] ADD  DEFAULT (newsequentialid()) FOR [BatchQueueFormID]
GO

ALTER TABLE [dbo].[pBatchQueueJob] ADD  DEFAULT (newsequentialid()) FOR [BatchQueueJobID]
GO

ALTER TABLE [dbo].[pBatchQueueJob] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [BatchQueueJobStatusID]
GO

ALTER TABLE [dbo].[pBatchQueueJob] ADD  DEFAULT ((0)) FOR [BatchQueueJobCompleted]
GO

ALTER TABLE [dbo].[pBatchQueueJobItem]  WITH CHECK ADD  CONSTRAINT [FK__pBatchQue__Batch__2D24BC77] FOREIGN KEY([BatchQueueJobID])
REFERENCES [dbo].[pBatchQueueJob] ([BatchQueueJobID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pBatchQueueJobItem] CHECK CONSTRAINT [FK__pBatchQue__Batch__2D24BC77]
GO

ALTER TABLE [dbo].[pBatchQueueJobItem] ADD  DEFAULT (newsequentialid()) FOR [BatchQueueJobItemID]
GO

ALTER TABLE [dbo].[pBatchQueueJobItem] ADD  DEFAULT ((0)) FOR [BatchQueueJobStatusID]
GO

ALTER TABLE [dbo].[pBatchQueueJobStatus] ADD  DEFAULT (newid()) FOR [BatchQueueJobStatusID]
GO

ALTER TABLE [dbo].[pBatchQueuePage] ADD  DEFAULT (newsequentialid()) FOR [BatchQueuePageID]
GO

ALTER TABLE [dbo].[pBatchQueuePageDep] ADD  DEFAULT (newsequentialid()) FOR [BatchQueuePageDepID]
GO

ALTER TABLE [dbo].[pBatchQueuePageType] ADD  DEFAULT (newsequentialid()) FOR [BatchQueuePageTypeID]
GO

ALTER TABLE [dbo].[pBatchQueueStyleMaterialColorTmp] ADD  DEFAULT (newid()) FOR [StyleMaterialColorID]
GO

ALTER TABLE [dbo].[pBatchQueueStyleMaterialTmp] ADD  DEFAULT (newid()) FOR [StyleMaterialID]
GO

ALTER TABLE [dbo].[pBatchQueueStyleWorkflow] ADD  DEFAULT (newsequentialid()) FOR [BatchQueueStyleWorkflowID]
GO

ALTER TABLE [dbo].[pBatchQueueType] ADD  DEFAULT (newsequentialid()) FOR [BatchQueueTypeID]
GO

ALTER TABLE [dbo].[pBatchQueueType] ADD  DEFAULT ((1)) FOR [Active]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01990'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01990', GetDate())     

END	  
GO