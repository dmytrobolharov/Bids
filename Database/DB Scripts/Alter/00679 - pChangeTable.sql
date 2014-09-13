IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pChangeLog_pChangeTable]') AND parent_object_id = OBJECT_ID(N'[dbo].[pChangeLog]'))
ALTER TABLE [dbo].[pChangeLog] DROP CONSTRAINT [FK_pChangeLog_pChangeTable]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pChangeLog_pChangeTransaction]') AND parent_object_id = OBJECT_ID(N'[dbo].[pChangeLog]'))
ALTER TABLE [dbo].[pChangeLog] DROP CONSTRAINT [FK_pChangeLog_pChangeTransaction]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pChangeLogItem_pChangeLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[pChangeLogItem]'))
ALTER TABLE [dbo].[pChangeLogItem] DROP CONSTRAINT [FK_pChangeLogItem_pChangeLog]
GO


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'pChangeTable')
   DROP TABLE pChangeTable
GO


CREATE TABLE [dbo].[pChangeTable]
(
[ChangeTableID] [uniqueidentifier] NOT NULL ROWGUIDCOL DEFAULT (newsequentialid()),
[ChangeTableName] nvarchar(200)  NULL,
[ChangeTableFieldName] nvarchar(200)  NULL,
[ChangeTablePKName] nvarchar(200)  NULL,
[ChangeTableXML] nvarchar(200)  NULL,
CONSTRAINT [PK_pChangeTable] PRIMARY KEY CLUSTERED 
(
	[ChangeTableID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)

BEGIN TRANSACTION

-- Add 12 rows to [dbo].[pChangeTable]
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('3219fd45-becc-df11-af06-005056c00008', 'pMaterial', 'MaterialID', 'MaterialID', 'ChangeLogItem_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('00000001-c1cc-df11-af06-005056c00008', 'pStyleColorwayItem', 'StyleColorItemID', 'StyleColorItemID', 'ChangeLogItem_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('00000002-c1cc-df11-af06-005056c00008', 'pStyleColorwaySeasonyear', 'StyleColorwaySeasonYearID', 'StyleColorwaySeasonYearID', 'ChangeLogItem_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('00000003-c1cc-df11-af06-005056c00008', 'pStyleColorway', 'StyleColorID', 'StyleColorID', 'ChangeLogItem_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('00000004-c1cc-df11-af06-005056c00008', 'pStyleSourcingItem', 'StyleSourcingItemID', 'StyleSourcingItemID', 'ChangeLogItem_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('00000005-c1cc-df11-af06-005056c00008', 'pStyleQuoteItem', 'StyleQuoteItemID', 'StyleQuoteItemID', 'ChangeLogItem_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('00000006-c1cc-df11-af06-005056c00008', 'pStyleCostingHeader', 'StyleCostingHeaderID', 'StyleCostingHeaderID', 'ChangeLogItem_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('00000007-c1cc-df11-af06-005056c00008', 'pLinePlanRange', 'LinePlanRangeID', 'LinePlanRangeID', 'ChangeLogItem_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('00000008-c1cc-df11-af06-005056c00008', 'pLinePlanShowroomStyleColor', 'LinePlanShowroomStyleColorID', 'LinePlanShowroomStyleColorID', 'ChangeLogItem_ShowroomStyleColor_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('00000009-c1cc-df11-af06-005056c00008', 'pStyleQuoteItem', 'StyleQuoteItemID', 'StyleQuoteItemID', 'ChangeLogItem_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('036f8b4c-c1cc-df11-af06-005056c00008', 'pStyleMaterials', 'StyleMaterialID', 'StyleMaterialID', 'ChangeLog_StyleMaterial_Default.xml')
INSERT INTO [dbo].[pChangeTable] ([ChangeTableID], [ChangeTableName], [ChangeTableFieldName], [ChangeTablePKName], [ChangeTableXML]) VALUES ('d612faae-7acd-df11-af06-005056c00008', 'pStyleHeader', 'StyleID', 'StyleID', 'ChangeLogItem_Default.xml')

COMMIT TRANSACTION
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '679', GetDate())
GO
