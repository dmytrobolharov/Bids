BEGIN TRANSACTION

/****************/
/*Temp table.	*/
/****************/
CREATE TABLE [dbo].[Temp_pStyleCosting](
	[StyleCostingID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_Temp_pStyleCosting_StyleCostingID]  DEFAULT (newid()),
	[StyleID] [uniqueidentifier] NULL,
	[StyleCostingTypeID] [int] NULL,
	[StyleCostingFreightTypeID] [int] NULL,
	[StyleQuotaDutyID] [uniqueidentifier] NULL,
	[StyleCostingDate] [datetime] NULL,
	[StyleCostingStatus] [nvarchar](200) NULL,
	[StyleCostingCustomField1] [money] NULL,
	[StyleCostingCustomField2] [money] NULL,
	[StyleCostingCustomField3] [decimal](18, 4) NULL,
	[StyleCostingCustomField4] [int] NULL,
	[StyleCostingCustomField5] [int] NULL,
	[StyleCostingCustomField6] [decimal](18, 3) NULL,
	[StyleCostingCustomField7] [decimal](18, 3) NULL,
	[StyleCostingCustomField8] [decimal](18, 3) NULL,
	[StyleCostingCustomField9] [decimal](18, 3) NULL,
	[StyleCostingCustomField10] [decimal](18, 3) NULL,
	[StyleCostingCustomField11] [decimal](18, 3) NULL,
	[StyleCostingCustomField12] [decimal](18, 3) NULL,
	[StyleCostingCustomField13] [decimal](18, 3) NULL,
	[StyleCostingCustomField14] [decimal](18, 3) NULL,
	[StyleCostingCustomField15] [decimal](18, 3) NULL,
	[StyleCostingCustomField16] [varchar](50) NULL,
	[StyleCostingCustomField17] [datetime] NULL,
	[StyleCostingCustomField18] [decimal](18, 3) NULL,
	[StyleCostingCustomField19] [decimal](18, 3) NULL,
	[StyleCostingCustomField20] [decimal](18, 3) NULL,
	[StyleCostingCustomField21] [decimal](18, 3) NULL,
	[StyleCostingCustomField22] [decimal](18, 3) NULL,
	[StyleCostingCustomField23] [decimal](18, 3) NULL,
	[StyleCostingCustomField24] [decimal](18, 3) NULL,
	[StyleCostingCustomField25] [varchar](50) NULL,
	[StyleCostingCustomField26] [varchar](50) NULL,
	[StyleCostingCustomField27] [varchar](50) NULL,
	[StyleCostingCustomField28] [varchar](50) NULL,
	[StyleCostingCustomField29] [varchar](50) NULL,
	[StyleCostingCustomField30] [varchar](50) NULL,
	[StyleCostingCustomField31] [varchar](50) NULL,
	[StyleCostingCustomField32] [varchar](50) NULL,
	[StyleCostingCustomField33] [varchar](50) NULL,
	[StyleCostingCustomField34] [varchar](50) NULL,
	[StyleCostingCustomField35] [varchar](50) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [bit] NULL CONSTRAINT [DF_Temp_pStyleCosting_Active]  DEFAULT ((0)),
	[StyleSeasonYearID] [uniqueidentifier] NULL,
	[StyleColorwayID] [uniqueidentifier] NULL CONSTRAINT [DF_Temp_pStyleCosting_StyleColorwayID]  DEFAULT ('00000000-0000-0000-0000-000000000000'),
 CONSTRAINT [PK_Temp_pStyleCosting] PRIMARY KEY CLUSTERED 
(
	[StyleCostingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/************************/
/*Get original data.	*/
/************************/
INSERT INTO [dbo].[Temp_pStyleCosting]
           ([StyleCostingID]
           ,[StyleID]
           ,[StyleCostingTypeID]
           ,[StyleCostingFreightTypeID]
           ,[StyleQuotaDutyID]
           ,[StyleCostingDate]
           ,[StyleCostingStatus]
           ,[StyleCostingCustomField1]
           ,[StyleCostingCustomField2]
           ,[StyleCostingCustomField3]
           ,[StyleCostingCustomField4]
           ,[StyleCostingCustomField5]
           ,[StyleCostingCustomField6]
           ,[StyleCostingCustomField7]
           ,[StyleCostingCustomField8]
           ,[StyleCostingCustomField9]
           ,[StyleCostingCustomField10]
           ,[StyleCostingCustomField11]
           ,[StyleCostingCustomField12]
           ,[StyleCostingCustomField13]
           ,[StyleCostingCustomField14]
           ,[StyleCostingCustomField15]
           ,[StyleCostingCustomField16]
           ,[StyleCostingCustomField17]
           ,[StyleCostingCustomField18]
           ,[StyleCostingCustomField19]
           ,[StyleCostingCustomField20]
           ,[StyleCostingCustomField21]
           ,[StyleCostingCustomField22]
           ,[StyleCostingCustomField23]
           ,[StyleCostingCustomField24]
           ,[StyleCostingCustomField25]
           ,[StyleCostingCustomField26]
           ,[StyleCostingCustomField27]
           ,[StyleCostingCustomField28]
           ,[StyleCostingCustomField29]
           ,[StyleCostingCustomField30]
           ,[StyleCostingCustomField31]
           ,[StyleCostingCustomField32]
           ,[StyleCostingCustomField33]
           ,[StyleCostingCustomField34]
           ,[StyleCostingCustomField35]
           ,[CUser]
           ,[CDate]
           ,[MUser]
           ,[MDate]
           ,[Active]
           ,[StyleSeasonYearID]
           ,[StyleColorwayID])
SELECT [StyleCostingID]
      ,[StyleID]
      ,[StyleCostingTypeID]
      ,[StyleCostingFreightTypeID]
      ,[StyleQuotaDutyID]
      ,[StyleCostingDate]
      ,[StyleCostingStatus]
      ,[StyleCostingCustomField1]
      ,[StyleCostingCustomField2]
      ,[StyleCostingCustomField3]
      ,[StyleCostingCustomField4]
      ,[StyleCostingCustomField5]
      ,[StyleCostingCustomField6]
      ,[StyleCostingCustomField7]
      ,[StyleCostingCustomField8]
      ,[StyleCostingCustomField9]
      ,[StyleCostingCustomField10]
      ,[StyleCostingCustomField11]
      ,[StyleCostingCustomField12]
      ,[StyleCostingCustomField13]
      ,[StyleCostingCustomField14]
      ,[StyleCostingCustomField15]
      ,[StyleCostingCustomField16]
      ,[StyleCostingCustomField17]
      ,[StyleCostingCustomField18]
      ,[StyleCostingCustomField19]
      ,	CASE
			WHEN ISNUMERIC([StyleCostingCustomField20]) = 1	THEN CAST([StyleCostingCustomField20] AS DECIMAL(18,3))
			ELSE 0
		END
      ,[StyleCostingCustomField21]
      ,[StyleCostingCustomField22]
      ,[StyleCostingCustomField23]
      ,[StyleCostingCustomField24]
      ,[StyleCostingCustomField25]
      ,[StyleCostingCustomField26]
      ,[StyleCostingCustomField27]
      ,[StyleCostingCustomField28]
      ,[StyleCostingCustomField29]
      ,[StyleCostingCustomField30]
      ,[StyleCostingCustomField31]
      ,[StyleCostingCustomField32]
      ,[StyleCostingCustomField33]
      ,[StyleCostingCustomField34]
      ,[StyleCostingCustomField35]
      ,[CUser]
      ,[CDate]
      ,[MUser]
      ,[MDate]
      ,[Active]
      ,[StyleSeasonYearID]
      ,[StyleColorwayID]
  FROM [dbo].[pStyleCosting]


/************************/
/*Rename the tables.	*/
/************************/
BEGIN
	/*Change original to backup table.*/
	EXECUTE sp_rename N'pStyleCosting', N'pStyleCosting_backup', 'OBJECT'

	/*Change temp to real table name.*/
	EXECUTE sp_rename N'Temp_pStyleCosting', N'pStyleCosting', 'OBJECT'
END


/********************************************************************/
/*If records successfully populated, drop original backup table.	*/
/********************************************************************/
BEGIN
	/*Variables.*/
	DECLARE @OriginalCount INT
	DECLARE @NewCount INT

	/*Get counts.*/
	SELECT @OriginalCount = COUNT(*) FROM pStyleCosting_backup
	SELECT @NewCount = COUNT(*) FROM pStyleCosting

	/*Drop original backup table if counts are the same.*/
	IF(@OriginalCount = @NewCount)
		BEGIN
			DROP TABLE pStyleCosting_backup
		END
END


/************************/
/*Rollback, or commit.	*/
/************************/
IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		PRINT 'Transaction not committed.'
	END
ELSE
	BEGIN
		COMMIT TRANSACTION
		PRINT 'Transaction committed.'
	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '091', GetDate())
GO