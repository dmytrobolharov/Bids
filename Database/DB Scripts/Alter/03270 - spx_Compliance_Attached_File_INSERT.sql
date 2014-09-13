IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Compliance_Attached_File_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Compliance_Attached_File_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Compliance_Attached_File_INSERT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Compliance_Attached_File_INSERT]
	-- Add the parameters for the stored procedure here
@ComplianceId UNIQUEIDENTIFIER,
@TradePartnerID AS NVARCHAR(400),
@CDate AS DATETIME
AS
BEGIN
	
	DECLARE @I AS INT
	DECLARE @Row_Count AS INT
	DECLARE @TradePartnerValue AS NVARCHAR(100)
	
	CREATE TABLE #TempTradePartnerList (
		Id int IDENTITY (1, 1) NOT NULL,
		TradePartnerID NVARCHAR(400)
	)
	
	INSERT INTO #TempTradePartnerList(TradePartnerID) SELECT items FROM dbo.Split(@TradePartnerID,',')
	

	SET @Row_Count = (SELECT COUNT(*) FROM #TempTradePartnerList)

	SET @I = 1

	WHILE @I <= @Row_Count
	BEGIN
		SELECT @TradePartnerValue=TradePartnerID FROM #TempTradePartnerList WHERE Id=@I
		
		IF NOT EXISTS(SELECT * FROM pComplianceTradePartnerSharedFiles WHERE TradePartnerID=@TradePartnerValue AND ComplianceID=@ComplianceId)
		BEGIN
			INSERT INTO pComplianceTradePartnerSharedFiles 
			(
				ComplianceId,
				TradePartnerID, 
				CDate
			)
			VALUES
			(
				@ComplianceId,
				@TradePartnerValue, 
				@CDate
			)
		END
		SET @I = @I + 1
	END
	
	DROP TABLE #TempTradePartnerList
	
		
END

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03270'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03270', GetDate())
END	
GO
--spx_Compliance_Attached_File_INSERT '52cb796d-a15a-4eb9-88ba-6bacd89785dc','b8bfffed-0291-4252-b9b2-6bda308d302f',NULL

