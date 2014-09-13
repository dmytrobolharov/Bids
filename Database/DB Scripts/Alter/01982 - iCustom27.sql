IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[iCustom27]') AND type in (N'U'))
	BEGIN

		CREATE TABLE [dbo].[iCustom27](
			[Custom] [nvarchar](200) NOT NULL,
			[CustomKey] [char](2) NULL,
			[Relation1] [nvarchar](100) NULL,
			[Relation2] [nvarchar](100) NULL,
			[Active] [bit] NULL,
			[CUser] [nvarchar](50) NULL,
			[CDate] [datetime] NULL,
			[MUser] [nvarchar](50) NULL,
			[MDate] [datetime] NULL,
			[CustomSort] [nvarchar](5) NULL,
			[CustomID] [uniqueidentifier] NOT NULL,
		PRIMARY KEY CLUSTERED 
		(
			[CustomID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]



		SET ANSI_PADDING OFF

		ALTER TABLE [dbo].[iCustom27] ADD  DEFAULT (newid()) FOR [CustomID]
		
		INSERT INTO iCustom27(Custom,CustomKey) VALUES ('Units','U')
		
		INSERT INTO iCustom27(Custom,CustomKey) VALUES ('Yards','Y')

	END

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01982'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01982', GetDate())

END

GO


