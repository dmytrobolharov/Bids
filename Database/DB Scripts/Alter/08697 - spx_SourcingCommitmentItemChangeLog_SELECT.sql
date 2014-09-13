/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentItemChangeLog_SELECT]    Script Date: 08/09/2014 16:00:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitmentItemChangeLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitmentItemChangeLog_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCommitmentItemChangeLog_SELECT]    Script Date: 08/09/2014 16:00:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_SourcingCommitmentItemChangeLog_SELECT]
	@SourcingCommitmentItemID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT sqic.SourcingCommitmentItemChangeID, sqic.SourcingCommitmentItemChangeNo, sqic.SourcingCommitmentItemChangeType, 
		'*By ' + sqic.SourcingCommitmentItemChangeBy + ' @ ' 
		+ CONVERT(NVARCHAR(100), sqic.SourcingCommitmentItemChangeDate , 101 ) + '<br />' 
		+ ISNULL(sqic.SourcingCommitmentItemChangeDescription,'') AS SourcingCommitmentItemChangeDescription,
		CASE WHEN sqic.Active = 1  
			THEN '<img src="../System/Icons/icon_ball_green_flash.gif" alt="" />'
			ELSE '<img src="../System/Icons/icon_ball_gray.gif" alt="" />'
		END AS Icon, 
		sqic.SourcingCommitmentItemChangeNotifyTo, sqic.SourcingCommitmentItemChangeBy, sqic.SourcingCommitmentItemChangeDate
	FROM pSourcingCommitmentItemChange sqic WITH(NOLOCK)
	WHERE sqic.SourcingCommitmentItemID = @SourcingCommitmentItemID
	ORDER BY sqic.SourcingCommitmentItemChangeNo DESC
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08697', GetDate())
GO
