
CREATE TABLE sVersion(
	[AppName] [nvarchar](32) NULL,
	[Version] [nvarchar](32) NULL,
	[LastScriptRun] [nvarchar](32) NULL,
	[TimeStamp] [nvarchar](32) NULL
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '000', GetDate())
GO
