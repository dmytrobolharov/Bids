



SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Creating [dbo].[uTradePartnerShipInfo]'
GO
CREATE TABLE [dbo].[uTradePartnerShipInfo]
(
[TradePartnerShipInfoID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_uTradePartnerShipInfo_TradePartnerShipInfoID] DEFAULT (newid()),
[TradePartnerID] [uniqueidentifier] NULL,
[ShipTypeID] [uniqueidentifier] NULL,
[ShipModeID] [uniqueidentifier] NULL,
[TradePointID] [uniqueidentifier] NULL,
[Sort] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [int] NULL,
[CUser] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerShipInfo] on [dbo].[uTradePartnerShipInfo]'
GO
ALTER TABLE [dbo].[uTradePartnerShipInfo] ADD CONSTRAINT [PK_uTradePartnerShipInfo] PRIMARY KEY CLUSTERED  ([TradePartnerShipInfoID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[pSourceShipMode]'
GO
CREATE TABLE [dbo].[pSourceShipMode]
(
[CustomID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_pSourceShipMode_CustomID] DEFAULT (newsequentialid()),
[CustomKey] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomSort] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [int] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_pSourceShipMode] on [dbo].[pSourceShipMode]'
GO
ALTER TABLE [dbo].[pSourceShipMode] ADD CONSTRAINT [PK_pSourceShipMode] PRIMARY KEY CLUSTERED  ([CustomID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[uTradePartnerRelationship]'
GO
CREATE TABLE [dbo].[uTradePartnerRelationship]
(
[TradePartnerRelationshipID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_uTradePartnerRelationship_TradePartnerRelationshipID] DEFAULT (newid()),
[TradePartnerMasterID] [uniqueidentifier] NOT NULL,
[TradePartnerID] [uniqueidentifier] NOT NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerRelationship] on [dbo].[uTradePartnerRelationship]'
GO
ALTER TABLE [dbo].[uTradePartnerRelationship] ADD CONSTRAINT [PK_uTradePartnerRelationship] PRIMARY KEY CLUSTERED  ([TradePartnerRelationshipID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[pSourceShipType]'
GO
CREATE TABLE [dbo].[pSourceShipType]
(
[CustomID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_pSourceShipType_CustomID] DEFAULT (newsequentialid()),
[CustomKey] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomSort] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [int] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_pSourceShipType] on [dbo].[pSourceShipType]'
GO
ALTER TABLE [dbo].[pSourceShipType] ADD CONSTRAINT [PK_pSourceShipType] PRIMARY KEY CLUSTERED  ([CustomID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[pSourceTradePoint]'
GO
CREATE TABLE [dbo].[pSourceTradePoint]
(
[CustomID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_pSourceTradePoint_CustomID] DEFAULT (newsequentialid()),
[CustomKey] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Custom] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomSort] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [int] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_pSourceTradePoint] on [dbo].[pSourceTradePoint]'
GO
ALTER TABLE [dbo].[pSourceTradePoint] ADD CONSTRAINT [PK_pSourceTradePoint] PRIMARY KEY CLUSTERED  ([CustomID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[uTradePartnerAddress]'
GO
CREATE TABLE [dbo].[uTradePartnerAddress]
(
[TradePartnerAddressID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_uTradePartnerAddress_TradePartnerAddressID] DEFAULT (newid()),
[TradePartnerAddressTypeID] [uniqueidentifier] NULL,
[TradePartnerID] [uniqueidentifier] NULL,
[TradePartnerContactID] [uniqueidentifier] NULL,
[Address1] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Postal] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [uniqueidentifier] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerAddress] on [dbo].[uTradePartnerAddress]'
GO
ALTER TABLE [dbo].[uTradePartnerAddress] ADD CONSTRAINT [PK_uTradePartnerAddress] PRIMARY KEY CLUSTERED  ([TradePartnerAddressID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[uTradePartnerAddressType]'
GO
CREATE TABLE [dbo].[uTradePartnerAddressType]
(
[TradePartnerAddressTypeID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_uTradePartnerAddressType_TradePartnerAddressTypeID] DEFAULT (newsequentialid()),
[TradePartnerAddressName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TradePartnerAddressDesc] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerAddressType] on [dbo].[uTradePartnerAddressType]'
GO
ALTER TABLE [dbo].[uTradePartnerAddressType] ADD CONSTRAINT [PK_uTradePartnerAddressType] PRIMARY KEY CLUSTERED  ([TradePartnerAddressTypeID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[uTradePartnerPages]'
GO
CREATE TABLE [dbo].[uTradePartnerPages]
(
[TradePartnerPageID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_uTradePartnerPages_TradePartnerPageID] DEFAULT (newid()),
[TradePartnerID] [uniqueidentifier] NULL,
[TradePartnerTemplateID] [uniqueidentifier] NULL,
[TradePartnerTemplateItemID] [uniqueidentifier] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerPages] on [dbo].[uTradePartnerPages]'
GO
ALTER TABLE [dbo].[uTradePartnerPages] ADD CONSTRAINT [PK_uTradePartnerPages] PRIMARY KEY CLUSTERED  ([TradePartnerPageID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[uTradePartnerRelationshipType]'
GO
CREATE TABLE [dbo].[uTradePartnerRelationshipType]
(
[TradePartnerRelationshipTypeID] [uniqueidentifier] NOT NULL,
[TradePartnerRelationshipTypeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TradePartnerRelationshipTypeDesc] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TradePartnerAllowRelationship] [int] NULL,
[Active] [int] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerRelationshipType] on [dbo].[uTradePartnerRelationshipType]'
GO
ALTER TABLE [dbo].[uTradePartnerRelationshipType] ADD CONSTRAINT [PK_uTradePartnerRelationshipType] PRIMARY KEY CLUSTERED  ([TradePartnerRelationshipTypeID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[uTradePartner]'
GO
ALTER TABLE [dbo].[uTradePartner] ADD
[TradePartnerRelationshipType] [uniqueidentifier] NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[uTradePartner] ALTER COLUMN [TradePartnerCode] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[uTradePartnerCapacity]'
GO
CREATE TABLE [dbo].[uTradePartnerCapacity]
(
[TradePartnerCapacityID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_uTradePartnerCapacity_TradePartnerCapacityID] DEFAULT (newsequentialid()),
[TradePartnerID] [uniqueidentifier] NULL,
[SeasonYearID] [uniqueidentifier] NULL,
[SeasonCalendarID] [uniqueidentifier] NULL,
[TradePartnerCapacityName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TradePartnerCapacityDesc] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [int] NOT NULL CONSTRAINT [DF_uTradePartnerCapacity_Active] DEFAULT ((1)),
[Sort] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerCapacity] on [dbo].[uTradePartnerCapacity]'
GO
ALTER TABLE [dbo].[uTradePartnerCapacity] ADD CONSTRAINT [PK_uTradePartnerCapacity] PRIMARY KEY CLUSTERED  ([TradePartnerCapacityID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[uTradePartnerCapacityItem]'
GO
CREATE TABLE [dbo].[uTradePartnerCapacityItem]
(
[TradePartnerCapacityItemID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_uTradePartnerCapacityItem_TradePartnerCapacityItemID] DEFAULT (newsequentialid()),
[TradePartnerCapacityID] [uniqueidentifier] NULL,
[StyleCategoryID] [uniqueidentifier] NULL,
[TradePartnerCap1] [int] NULL,
[TradePartnerCap2] [int] NULL,
[TradePartnerCap3] [int] NULL,
[TradePartnerCap4] [int] NULL,
[TradePartnerCap5] [int] NULL,
[TradePartnerCap6] [int] NULL,
[TradePartnerCap7] [int] NULL,
[TradePartnerCap8] [int] NULL,
[TradePartnerCap9] [int] NULL,
[TradePartnerCap10] [int] NULL,
[TradePartnerCap11] [int] NULL,
[TradePartnerCap12] [int] NULL,
[Active] [int] NOT NULL CONSTRAINT [DF_uTradePartnerCapacityItem_Active] DEFAULT ((1)),
[Sort] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerCapacityItem] on [dbo].[uTradePartnerCapacityItem]'
GO
ALTER TABLE [dbo].[uTradePartnerCapacityItem] ADD CONSTRAINT [PK_uTradePartnerCapacityItem] PRIMARY KEY CLUSTERED  ([TradePartnerCapacityItemID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[uTradePartnerTemplate]'
GO
CREATE TABLE [dbo].[uTradePartnerTemplate]
(
[TradePartnerTemplateID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_uTradePartnerTemplate_TradePartnerTemplateID] DEFAULT (newid()),
[TradePartnerTemplateName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TradePartnerTemplateDesc] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [int] NULL CONSTRAINT [DF_uTradePartnerTemplate_Active] DEFAULT ((1)),
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerTemplate] on [dbo].[uTradePartnerTemplate]'
GO
ALTER TABLE [dbo].[uTradePartnerTemplate] ADD CONSTRAINT [PK_uTradePartnerTemplate] PRIMARY KEY CLUSTERED  ([TradePartnerTemplateID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[uTradePartnerTemplatePage]'
GO
CREATE TABLE [dbo].[uTradePartnerTemplatePage]
(
[TradePartnerTemplatePageID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_uTradePartnerTemplatePage_TradePartnerTemplatePageID] DEFAULT (newid()),
[TradePartnerTemplatePageName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TradePartnerTemplatePageDesc] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TradePartnerTemplatePageViewXML] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TradePartnerTemplatePageEditXML] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[Active] [int] NULL CONSTRAINT [DF_uTradePartnerTemplatePage_Active] DEFAULT ((1))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerTemplatePage] on [dbo].[uTradePartnerTemplatePage]'
GO
ALTER TABLE [dbo].[uTradePartnerTemplatePage] ADD CONSTRAINT [PK_uTradePartnerTemplatePage] PRIMARY KEY CLUSTERED  ([TradePartnerTemplatePageID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[uTradePartnerTemplateItem]'
GO
CREATE TABLE [dbo].[uTradePartnerTemplateItem]
(
[TradePartnerTemplateItemID] [uniqueidentifier] NOT NULL ROWGUIDCOL CONSTRAINT [DF_uTradePartnerTemplateItem_TradePartnerTemplateItemID] DEFAULT (newid()),
[TradePartnerTemplateID] [uniqueidentifier] NULL,
[TradePartnerTemplatePageID] [uniqueidentifier] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[Active] [int] NULL CONSTRAINT [DF_uTradePartnerTemplateItem_Active] DEFAULT ((1))
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_uTradePartnerTemplateItem] on [dbo].[uTradePartnerTemplateItem]'
GO
ALTER TABLE [dbo].[uTradePartnerTemplateItem] ADD CONSTRAINT [PK_uTradePartnerTemplateItem] PRIMARY KEY CLUSTERED  ([TradePartnerTemplateItemID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[uTradePartnerShipInfo]'
GO
ALTER TABLE [dbo].[uTradePartnerShipInfo] ADD CONSTRAINT [FK_uTradePartnerShipInfo_pSourceShipMode] FOREIGN KEY ([ShipModeID]) REFERENCES [dbo].[pSourceShipMode] ([CustomID])
ALTER TABLE [dbo].[uTradePartnerShipInfo] ADD CONSTRAINT [FK_uTradePartnerShipInfo_pSourceShipType] FOREIGN KEY ([ShipTypeID]) REFERENCES [dbo].[pSourceShipType] ([CustomID])
ALTER TABLE [dbo].[uTradePartnerShipInfo] ADD CONSTRAINT [FK_uTradePartnerShipInfo_pSourceTradePoint] FOREIGN KEY ([TradePointID]) REFERENCES [dbo].[pSourceTradePoint] ([CustomID])
ALTER TABLE [dbo].[uTradePartnerShipInfo] ADD CONSTRAINT [FK_uTradePartnerShipInfo_uTradePartner] FOREIGN KEY ([TradePartnerID]) REFERENCES [dbo].[uTradePartner] ([TradePartnerID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[uTradePartner]'
GO
ALTER TABLE [dbo].[uTradePartner] ADD CONSTRAINT [FK_uTradePartner_uTradePartnerRelationshipType] FOREIGN KEY ([TradePartnerRelationshipType]) REFERENCES [dbo].[uTradePartnerRelationshipType] ([TradePartnerRelationshipTypeID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[uTradePartnerAddress]'
GO
ALTER TABLE [dbo].[uTradePartnerAddress] ADD CONSTRAINT [FK_uTradePartnerAddress_uTradePartnerAddressType] FOREIGN KEY ([TradePartnerAddressTypeID]) REFERENCES [dbo].[uTradePartnerAddressType] ([TradePartnerAddressTypeID])
ALTER TABLE [dbo].[uTradePartnerAddress] ADD CONSTRAINT [FK_uTradePartnerAddress_uTradePartner] FOREIGN KEY ([TradePartnerID]) REFERENCES [dbo].[uTradePartner] ([TradePartnerID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[uTradePartnerCapacityItem]'
GO
ALTER TABLE [dbo].[uTradePartnerCapacityItem] ADD CONSTRAINT [FK_uTradePartnerCapacityItem_uTradePartnerCapacity] FOREIGN KEY ([TradePartnerCapacityID]) REFERENCES [dbo].[uTradePartnerCapacity] ([TradePartnerCapacityID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[uTradePartnerCapacity]'
GO
ALTER TABLE [dbo].[uTradePartnerCapacity] ADD CONSTRAINT [FK_uTradePartnerCapacity_uTradePartner] FOREIGN KEY ([TradePartnerID]) REFERENCES [dbo].[uTradePartner] ([TradePartnerID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[uTradePartnerPages]'
GO
ALTER TABLE [dbo].[uTradePartnerPages] ADD CONSTRAINT [FK_uTradePartnerPages_uTradePartner] FOREIGN KEY ([TradePartnerID]) REFERENCES [dbo].[uTradePartner] ([TradePartnerID])
ALTER TABLE [dbo].[uTradePartnerPages] ADD CONSTRAINT [FK_uTradePartnerPages_uTradePartnerTemplate] FOREIGN KEY ([TradePartnerTemplateID]) REFERENCES [dbo].[uTradePartnerTemplate] ([TradePartnerTemplateID])
ALTER TABLE [dbo].[uTradePartnerPages] ADD CONSTRAINT [FK_uTradePartnerPages_uTradePartnerTemplateItem] FOREIGN KEY ([TradePartnerTemplateItemID]) REFERENCES [dbo].[uTradePartnerTemplateItem] ([TradePartnerTemplateItemID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[uTradePartnerRelationship]'
GO
ALTER TABLE [dbo].[uTradePartnerRelationship] ADD CONSTRAINT [FK_uTradePartnerRelationship_uTradePartner] FOREIGN KEY ([TradePartnerMasterID]) REFERENCES [dbo].[uTradePartner] ([TradePartnerID])
ALTER TABLE [dbo].[uTradePartnerRelationship] ADD CONSTRAINT [FK_uTradePartnerRelationship_uTradePartner1] FOREIGN KEY ([TradePartnerID]) REFERENCES [dbo].[uTradePartner] ([TradePartnerID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[uTradePartnerTemplateItem]'
GO
ALTER TABLE [dbo].[uTradePartnerTemplateItem] ADD CONSTRAINT [FK_uTradePartnerTemplateItem_uTradePartnerTemplate] FOREIGN KEY ([TradePartnerTemplateID]) REFERENCES [dbo].[uTradePartnerTemplate] ([TradePartnerTemplateID])
ALTER TABLE [dbo].[uTradePartnerTemplateItem] ADD CONSTRAINT [FK_uTradePartnerTemplateItem_uTradePartnerTemplatePage] FOREIGN KEY ([TradePartnerTemplatePageID]) REFERENCES [dbo].[uTradePartnerTemplatePage] ([TradePartnerTemplatePageID])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSeasonCalendar_SeasonCalendarID]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[pSeasonCalendar] DROP CONSTRAINT [DF_pSeasonCalendar_SeasonCalendarID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSeasonCalendar_Active]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[pSeasonCalendar] DROP CONSTRAINT [DF_pSeasonCalendar_Active]
END

GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_uTradePartnerCapacity_pSeasonCalendar]') AND parent_object_id = OBJECT_ID(N'[dbo].[uTradePartnerCapacity]'))
	ALTER TABLE [dbo].[uTradePartnerCapacity] DROP CONSTRAINT [FK_uTradePartnerCapacity_pSeasonCalendar]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSeasonCalendar]') AND type in (N'U'))
DROP TABLE [dbo].[pSeasonCalendar]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pSeasonCalendar](
	[SeasonCalendarID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SeasonID] [uniqueidentifier] NULL,
	[SeasonCalendarName] [nvarchar](200) NULL,
	[SeasonCalendarDesc] [nvarchar](400) NULL,
	[SeasonMonth1] [int] NULL,
	[SeasonMonth2] [int] NULL,
	[SeasonMonth3] [int] NULL,
	[SeasonMonth4] [int] NULL,
	[SeasonMonth5] [int] NULL,
	[SeasonMonth6] [int] NULL,
	[SeasonMonth7] [int] NULL,
	[SeasonMonth8] [int] NULL,
	[SeasonMonth9] [int] NULL,
	[SeasonMonth10] [int] NULL,
	[SeasonMonth11] [int] NULL,
	[SeasonMonth12] [int] NULL,
	[Active] [int] NOT NULL,
	[Sort] [varchar](5) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pSeasonCalendar] PRIMARY KEY CLUSTERED 
(
	[SeasonCalendarID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pSeasonCalendar] ADD  CONSTRAINT [DF_pSeasonCalendar_SeasonCalendarID]  DEFAULT (newsequentialid()) FOR [SeasonCalendarID]
GO

ALTER TABLE [dbo].[pSeasonCalendar] ADD  CONSTRAINT [DF_pSeasonCalendar_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[uTradePartnerCapacity] ADD CONSTRAINT [FK_uTradePartnerCapacity_pSeasonCalendar] FOREIGN KEY ([SeasonCalendarID]) REFERENCES [dbo].[pSeasonCalendar] ([SeasonCalendarID])
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03246'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03246', GetDate())

END

GO