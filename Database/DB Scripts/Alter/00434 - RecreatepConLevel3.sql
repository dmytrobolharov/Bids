begin
	IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS  
				WHERE TABLE_NAME = 'pConLevel3'  
			   AND  COLUMN_NAME = 'IsActive')
	begin

		DROP TABLE [dbo].[pConLevel3]


		CREATE TABLE [dbo].[pConLevel3](
			[Level3ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pConLevel3_Level3ID]  DEFAULT (newid()),
			[Level3Desc] [nvarchar](100) NULL,
			[Detail] [text] NULL,
			[ImageID] [uniqueidentifier] NULL CONSTRAINT [DF_pConLevel3_ImageID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
			[ImageVersion] [int] NULL CONSTRAINT [DF_pConLevel3_ImageVersion]  DEFAULT ((0)),
			[AuxField1] [nvarchar](100) NULL,
			[AuxField2] [nvarchar](100) NULL,
			[AuxField3] [nvarchar](100) NULL,
			[AuxField4] [nvarchar](100) NULL,
			[AuxField5] [nvarchar](100) NULL,
			[Active] [int] NOT NULL CONSTRAINT [DF_pConLevel3_Active]  DEFAULT ((1)),
			[MDate] [datetime] NULL,
			[MUser] [nvarchar](200) NULL,
			[CUser] [nvarchar](200) NULL,
			[CDate] [datetime] NULL,
		 CONSTRAINT [PK_pConLevel3] PRIMARY KEY CLUSTERED 
		(
			[Level3ID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


	end
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '434', GetDate())
end