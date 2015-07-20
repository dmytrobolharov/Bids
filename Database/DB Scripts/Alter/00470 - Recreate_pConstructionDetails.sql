begin
	IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS  
				WHERE TABLE_NAME = 'pConPageDetail'  
			   AND  COLUMN_NAME = 'PageId')
	begin

		DROP TABLE [dbo].[pConPageDetail]


		CREATE TABLE [dbo].[pConPageDetail](
			[ConstructionDetailID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pConPageDetail_ConstructionDetailID]  DEFAULT (newid()),
			[StyleID] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_StyleID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
			[WorkflowID] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_WorkflowID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
			[Sort] [nvarchar](5) NULL,
			[StyleSet] [int] NULL,
			[Detail] [text] NULL,
			[OrigOperationSN] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_OrigOperationSN]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
			[Level1Desc] [nvarchar](100) NULL,
			[Level2Desc] [nvarchar](100) NULL,
			[Level3Desc] [nvarchar](100) NULL,
			[ImageID] [uniqueidentifier] NULL,
			[AuxField1] [nvarchar](100) NULL,
			[AuxField2] [nvarchar](100) NULL,
			[AuxField3] [nvarchar](100) NULL,
			[AuxField4] [nvarchar](100) NULL,
			[AuxField5] [nvarchar](100) NULL,
			[Linked] [int] NULL,
			[Level1ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_Level1ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
			[Level2ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_Level2ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
			[Level3ID] [uniqueidentifier] NULL CONSTRAINT [DF_pConPageDetail_Level3ID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
			[CUser] [nvarchar](200) NULL,
			[CDate] [datetime] NULL,
			[MUser] [nvarchar](200) NULL,
			[MDate] [datetime] NULL,
 		CONSTRAINT [PK_pConPageDetail_1] PRIMARY KEY CLUSTERED 
		(
			[ConstructionDetailID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


	end

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '470', GetDate())

end
