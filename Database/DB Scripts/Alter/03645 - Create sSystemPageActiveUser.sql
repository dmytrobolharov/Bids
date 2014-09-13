/****** Object:  Table [dbo].[sSystemPageActiveUser]    Script Date: 06/13/2012 17:36:27 ******/

IF EXISTS (select 1 
             from INFORMATION_SCHEMA.TABLES 
            where TABLE_TYPE='BASE TABLE' 
              and TABLE_NAME='sSystemPageActiveUser') 
 drop table sSystemPageActiveUser
 go
 
 
 CREATE TABLE [dbo].[sSystemPageActiveUser](
	[SystemPageActiveUserID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[PagePathAccessed] VARCHAR(MAX) NULL,
	[ActiveUserLastUpdate] [datetime] NULL,
	[ActiveUserTimeAccessed] [datetime] NULL,
 CONSTRAINT [PK_SystemPageActiveUser] PRIMARY KEY CLUSTERED 
(
	[SystemPageActiveUserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

go
 



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03645', GetDate())
	

GO

