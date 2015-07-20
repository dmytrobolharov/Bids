--** TABLE name goes in here
DECLARE @TableName NVARCHAR(200) = 'pBatchQTechPackImagePerPage'

DECLARE @TableCreated BIT = 0
IF OBJECT_ID(@TableName, 'U') IS NULL
BEGIN
	--** CREATE TABLE goes in here
	CREATE TABLE [dbo].[pBatchQTechPackImagePerPage](
		[BatchQueueJobID] [uniqueidentifier] NOT NULL,
		[NumberOfImages] [int] NOT NULL,
	 CONSTRAINT [PK_pBatchQTechPackImagePerPage] PRIMARY KEY CLUSTERED 
	(
		[BatchQueueJobID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	--** do not change anything here
	SET @TableCreated = 1
END

IF @TableCreated = 1
BEGIN
	PRINT 'Table ' + @TableName + ' is created successfully'
	
	--** ALTER statements go in here
	ALTER TABLE [dbo].[pBatchQTechPackImagePerPage] ADD  CONSTRAINT [DF_pBatchQTechPackImagePerPage_NumberOfImages]  DEFAULT ((1)) FOR [NumberOfImages]
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06914', GetDate())
GO
