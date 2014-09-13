IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanShowroom_Item_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialCore_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_LinePlanShowroom_Item_UPDATE](
	@SQLCmd NVARCHAR(1000),
	@ShowroomID UNIQUEIDENTIFIER,
	@StyleColorID UNIQUEIDENTIFIER,
	@LinePlanRangeID  UNIQUEIDENTIFIER,
	@ChangeTransID UNIQUEIDENTIFIER,
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME	
)
AS

DECLARE @SQL NVARCHAR(2000)
DECLARE @LinePlanShowroomStyleColorID  UNIQUEIDENTIFIER


--** before values
DECLARE 
	@b_TradePartnerVendorID UNIQUEIDENTIFIER,
	@b_Price MONEY,
	@b_Qty INT,
	@b_Vendor NVARCHAR(200)

--** after values
DECLARE 
	@a_TradePartnerVendorID UNIQUEIDENTIFIER,
	@a_Price MONEY,
	@a_Qty INT,
	@a_Vendor NVARCHAR(200)



SELECT TOP 1 
	@LinePlanShowroomStyleColorID = a.LinePlanShowroomStyleColorID,
	@b_TradePartnerVendorID = a.TradePartnerVendorID,
	@b_Price = a.Price,
	@b_Qty = a.Qty,
	@b_Vendor = b.VendorName
FROM dbo.pLinePlanShowroomStyleColor a WITH(NOLOCK)
	LEFT OUTER JOIN dbo.uTradePartnerVendor b WITH(NOLOCK) ON a.TradePartnerVendorID = b.TradePartnerVendorID
WHERE a.ShowroomID = @ShowroomID 
AND  a.StyleColorID = @StyleColorID 
AND a.LinePlanRangeID = @LinePlanRangeID 

SET @SQL = @SQLCmd + ' WHERE LinePlanShowroomStyleColorID = ''' + CAST(@LinePlanShowroomStyleColorID AS NVARCHAR(40)) + ''' '
EXECUTE sp_executesql @SQL


IF @ChangeTransID IS NOT NULL AND CAST(@ChangeTransID AS NVARCHAR(40)) <> '00000000-0000-0000-0000-00000000'
BEGIN 

	SELECT 
		@a_TradePartnerVendorID = a.TradePartnerVendorID,
		@a_Price = a.Price,
		@a_Qty = a.Qty,
		@a_Vendor = b.VendorName
	FROM dbo.pLinePlanShowroomStyleColor a WITH(NOLOCK)
		LEFT OUTER JOIN dbo.uTradePartnerVendor b WITH(NOLOCK) ON a.TradePartnerVendorID = b.TradePartnerVendorID
	WHERE a.LinePlanShowroomStyleColorID = @LinePlanShowroomStyleColorID


	--** Log 
	DECLARE @ChangeLogID  UNIQUEIDENTIFIER

	EXECUTE spx_ChangeLog_INSERTID
		@changeTableId = '00000008-C1CC-DF11-AF06-005056C00008',
		@changeTransId = @ChangeTransID,
		@changeTablePKId = @LinePlanShowroomStyleColorID,
		@changeUserId = @ChangeTransUserID,
		@ChangeUserName = @MUser,
		@changeDate = @MDate,
		@changeSort  = '0000',
		@ShowResult = 0, 
		@ChangeLogID = @ChangeLogID OUTPUT


	IF @b_TradePartnerVendorID <> @a_TradePartnerVendorID 
	BEGIN
		EXECUTE spx_ChangeLogItem_INSERT
			@ChangeLogID = @ChangeLogID ,
			@ChangeTransID = @ChangeTransID,
			@ChangeFieldName =  'TradePartnerVendorID',
			@ChangeFieldAlias = 'Vendor',
			@ChangeBeforeValue  =  @b_TradePartnerVendorID,
			@ChangeAfterValue = @a_TradePartnerVendorID,
			@ChangeBeforeText = @b_Vendor,
			@ChangeAfterText  = @a_Vendor,
			@ChangeSort = '0000'
	END 

	IF @b_Price <> @a_Price 
	BEGIN 
		EXECUTE spx_ChangeLogItem_INSERT
			@ChangeLogID = @ChangeLogID ,
			@ChangeTransID = @ChangeTransID,
			@ChangeFieldName =  'Price',
			@ChangeFieldAlias = 'Cost',
			@ChangeBeforeValue  =  @b_Price,
			@ChangeAfterValue = @a_Price,
			@ChangeBeforeText = @b_Price,
			@ChangeAfterText  = @a_Price,
			@ChangeSort = '0000'
	END

	IF @b_Qty <> @a_Qty 
	BEGIN
		EXECUTE spx_ChangeLogItem_INSERT
			@ChangeLogID = @ChangeLogID ,
			@ChangeTransID = @ChangeTransID,
			@ChangeFieldName =  'Qty',
			@ChangeFieldAlias = 'Qty',
			@ChangeBeforeValue  =  @b_Qty,
			@ChangeAfterValue = @a_Qty,
			@ChangeBeforeText = @b_Qty,
			@ChangeAfterText  = @a_Qty,
			@ChangeSort = '0000'
	END

	IF NOT EXISTS (SELECT * FROM dbo.pChangeLogItem WHERE ChangeLogID = @ChangeLogID)
		EXECUTE spx_ChangeLog_DELETE @ChangeLogID


END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '725', GetDate())
GO
