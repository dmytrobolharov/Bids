CREATE TABLE sOverrideVWX(
	[OriginalVWX] [nvarchar](256) NOT NULL,
	[FormName] [nvarchar](256) NOT NULL,
	[Override] [nvarchar](256) NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE sOverrideSPX(
	[OriginalSPX] [nvarchar](256) NOT NULL,
	[FormName] [nvarchar](256) NOT NULL,
	[Override] [nvarchar](256) NOT NULL
) ON [PRIMARY]
GO

INSERT INTO sVersion (AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '011', GetDate())

GO