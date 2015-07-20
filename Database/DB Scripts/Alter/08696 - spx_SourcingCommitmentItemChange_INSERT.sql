/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentItemChange_INSERT]    Script Date: 08/09/2014 15:25:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitmentItemChange_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitmentItemChange_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentItemChange_INSERT]    Script Date: 08/09/2014 15:25:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_SourcingCommitmentItemChange_INSERT](
	  @ActiveID UNIQUEIDENTIFIER
	, @ChangeID UNIQUEIDENTIFIER
	, @SourcingCommitmentItemID UNIQUEIDENTIFIER
	, @SourcingCommitmentItemStatus BIT
	, @SourcingCommitmentItemChangeNotifyTo NVARCHAR(4000)
	, @SourcingCommitmentItemChangeType NVARCHAR(100)
	, @SourcingCommitmentItemChangeDescription NVARCHAR(4000)
	, @ChangeBy NVARCHAR(200)
	, @ChangeDate DATETIME)
AS 

	DECLARE @NoOfChange INT

	SELECT @NoOfChange = COUNT(*)
	FROM pColorFolderChange WITH (NOLOCK)
	WHERE ColorFolderChangeID = @ChangeID

	IF @NoOfChange = 0
		INSERT INTO pSourcingCommitmentItemChange (
			  ActiveID
			, SourcingCommitmentItemChangeID
			, SourcingCommitmentItemID
			, SourcingCommitmentItemChangeNotifyTo
			, SourcingCommitmentItemChangeType
			, SourcingCommitmentItemChangeDescription
			, SourcingCommitmentItemChangeBy
			, SourcingCommitmentItemChangeDate
			, SourcingCommitmentItemStatus)
		VALUES (
			  @ActiveID
			, @ChangeID
			, @SourcingCommitmentItemID
			, @SourcingCommitmentItemChangeNotifyTo
			, @SourcingCommitmentItemChangeType
			, @SourcingCommitmentItemChangeDescription
			, @ChangeBy
			, @ChangeDate
			, @SourcingCommitmentItemStatus)		
	ELSE
		UPDATE pSourcingCommitmentItemChange
		SET ActiveID = @ActiveID
			, SourcingCommitmentItemStatus = @SourcingCommitmentItemStatus
			, SourcingCommitmentItemChangeNotifyTo = @SourcingCommitmentItemChangeNotifyTo
			, SourcingCommitmentItemChangeType = @SourcingCommitmentItemChangeType
			, SourcingCommitmentItemChangeDescription = @SourcingCommitmentItemChangeDescription
			, SourcingCommitmentItemChangeBy = @ChangeBy
			, SourcingCommitmentItemChangeDate = @ChangeDate
		WHERE SourcingCommitmentItemChangeID = @ChangeID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08696', GetDate())
GO
