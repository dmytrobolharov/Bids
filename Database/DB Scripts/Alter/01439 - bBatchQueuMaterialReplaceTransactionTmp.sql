

CREATE TABLE dbo.bBatchQueuMaterialReplaceTransactionTmp(
	BachQTransactionID UNIQUEIDENTIFIER,
	BatchQueueMaterialReplaceID UNIQUEIDENTIFIER,
	CDate DATETIME,
	CUser NVARCHAR(200), 
	TeamID UNIQUEIDENTIFIER
)

GO

ALTER TABLE [dbo].[bBatchQueuMaterialReplaceTransactionTmp] 
ADD CONSTRAINT [DF_bBatchQueuMaterialReplaceTransactionTmp_BachQTransactionID]  
DEFAULT (newsequentialid()) FOR [BachQTransactionID]

GO


CREATE TABLE bBatchQueuMaterialColorReplaceTmp(
	BatchQMaterialColorReplaceTmpID UNIQUEIDENTIFIER,
	BachQTransactionID UNIQUEIDENTIFIER,
	MaterialColorFindID UNIQUEIDENTIFIER, 
	MaterialColorReplaceID UNIQUEIDENTIFIER
)

GO

ALTER TABLE dbo.bBatchQueuMaterialColorReplaceTmp 
ADD CONSTRAINT [DF_bBatchQueuMaterialColorReplaceTmp_BatchQMaterialColorReplaceTmpID]  
DEFAULT (newsequentialid()) FOR BatchQMaterialColorReplaceTmpID

GO


CREATE TABLE bBatchQueuMaterialSizeReplaceTmp(
	BatchQMaterialSizeReplaceTmpID UNIQUEIDENTIFIER,
	BachQTransactionID UNIQUEIDENTIFIER,
	MaterialSizeFindID UNIQUEIDENTIFIER, 
	MaterialSizeReplaceID UNIQUEIDENTIFIER
)
GO


ALTER TABLE dbo.bBatchQueuMaterialSizeReplaceTmp 
ADD CONSTRAINT [DF_bBatchQueuMaterialSizeReplaceTmp_BatchQMaterialSizeReplaceTmpID]  
DEFAULT (newsequentialid()) FOR BatchQMaterialSizeReplaceTmpID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01439', GetDate())
GO




