IF NOT EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pBOLApprove')
CREATE TABLE [dbo].[pBOLApprove](
[CustomKey] [nvarchar](10) NOT NULL,
[Custom] [nvarchar](200) NOT NULL,
[CustomBoolean] [int] NULL,
[CustomId] [uniqueidentifier] NOT NULL,
[CUser] [nvarchar](50) NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar](50) NULL,
[MDate] [datetime] NULL,
[Active] [bit] NULL,
CONSTRAINT [PK_pBOLApprove] PRIMARY KEY CLUSTERED 
(
[CustomKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLApprove] ADD CONSTRAINT [DF_pBOLApprove_CustomId] DEFAULT (newid()) FOR [CustomId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01749'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01749', GetDate())
END	

GO
