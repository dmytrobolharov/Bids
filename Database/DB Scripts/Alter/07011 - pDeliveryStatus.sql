IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pDeliveryStatus_DeliveryStatusID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pDeliveryStatus] DROP CONSTRAINT [DF_pDeliveryStatus_DeliveryStatusID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pDeliveryStatus]') AND type in (N'U'))
DROP TABLE [dbo].[pDeliveryStatus]
GO

CREATE TABLE [dbo].[pDeliveryStatus](
	[StatusID] [int] NOT NULL,
	[Status] [nvarchar](200) NULL,
	[Active] [bit] NULL,
	[DeliveryStatusID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pDeliveryStatus] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pDeliveryStatus] ADD  CONSTRAINT [DF_pDeliveryStatus_DeliveryStatusID]  DEFAULT (newid()) FOR [DeliveryStatusID]
GO


INSERT pDeliveryStatus (StatusID, Status, Active, DeliveryStatusID) VALUES (100, N'In Progress', 1, N'c2df6dfe-6bd0-43aa-b93d-669766912ee9')
INSERT pDeliveryStatus (StatusID, Status, Active, DeliveryStatusID) VALUES (200, N'Approved', 1, N'fe57dc35-6409-4081-9652-6a4f3fc28d77')
INSERT pDeliveryStatus (StatusID, Status, Active, DeliveryStatusID) VALUES (500, N'On Hold', 1, N'a5682d76-90f6-4f6a-b371-7989d900904d')
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07011', GetDate())
GO
