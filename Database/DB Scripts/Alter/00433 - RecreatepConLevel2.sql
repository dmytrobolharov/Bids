begin
	IF EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS  
				WHERE TABLE_NAME = 'pConLevel2'  
			   AND  COLUMN_NAME = 'IsActive')
	begin

		DROP TABLE [dbo].[pConLevel2]

		CREATE TABLE [dbo].[pConLevel2](
			[Level2ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pConLevel2_Level2ID]  DEFAULT (newid()),
			[Level2Desc] [nvarchar](100) NULL,
			[Active] [int] NOT NULL CONSTRAINT [DF_pConLevel2_Active]  DEFAULT ((1)),
		 CONSTRAINT [PK_pConLevel2] PRIMARY KEY CLUSTERED 
		(
			[Level2ID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]


	end

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '433', GetDate())
end