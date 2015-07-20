IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialChange_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialChange_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialChange_INSERT](
	  @ActiveID UNIQUEIDENTIFIER
	, @ChangeID UNIQUEIDENTIFIER
	, @WorkflowID UNIQUEIDENTIFIER
	, @MaterialID UNIQUEIDENTIFIER
	, @MaterialStatus BIT
	, @MaterialChangeNotifyTo NVARCHAR(4000)
	, @MaterialChangeType NVARCHAR(100)
	, @MaterialChangeDescription NVARCHAR(4000)
	, @ChangeBy NVARCHAR(200)
	, @ChangeDate DATETIME)
AS 

	DECLARE @NoOfChange INT

	SELECT @NoOfChange = COUNT(*)
	FROM pMaterialChange WITH (NOLOCK)
	WHERE MaterialChangeID = @ChangeID

	IF @NoOfChange = 0
		INSERT INTO pMaterialChange (
			  ActiveID
			, MaterialChangeID
			, MaterialWorkflowPageID
			, MaterialID
			, MaterialChangeNotifyTo
			, MaterialChangeType
			, MaterialChangeDescription
			, MaterialChangeBy
			, MaterialChangeDate
			, MaterialStatus)
		VALUES (
			  @ActiveID
			, @ChangeID
			, @WorkflowID
			, @MaterialID
			, @MaterialChangeNotifyTo
			, @MaterialChangeType
			, @MaterialChangeDescription
			, @ChangeBy
			, @ChangeDate
			, @MaterialStatus)		
	ELSE
		UPDATE pMaterialChange
		SET ActiveID = @ActiveID
			, MaterialStatus = @MaterialStatus
			, MaterialChangeNotifyTo = @MaterialChangeNotifyTo
			, MaterialChangeType = @MaterialChangeType
			, MaterialChangeDescription = @MaterialChangeDescription
			, MaterialChangeBy = @ChangeBy
			, MaterialChangeDate = @ChangeDate
		WHERE MaterialChangeID = @ChangeID

	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08424', GetDate())
GO
