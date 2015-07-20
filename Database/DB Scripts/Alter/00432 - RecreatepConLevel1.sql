begin
	IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS  
				WHERE TABLE_NAME = 'pConLevel1'  
			   AND  COLUMN_NAME = 'IsActive')
	begin

		DROP TABLE [dbo].[pConLevel1]

		CREATE TABLE [dbo].[pConLevel1](
			[Level1ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pConLevel1_Level1ID]  DEFAULT (newid()),
			[Level1Desc] [nvarchar](100) NULL,
			[Active] [int] NOT NULL CONSTRAINT [DF_pConLevel1_Active]  DEFAULT ((1)),
		 CONSTRAINT [PK_pConLevel1] PRIMARY KEY CLUSTERED 
		(
			[Level1ID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]


	end

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '432', GetDate())

end