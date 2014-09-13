/****** Object:  StoredProcedure [dbo].[spx_SourcingHistory_INSERT]    Script Date: 04/15/2013 11:17:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingHistory_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingHistory_INSERT]    Script Date: 04/15/2013 11:17:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


Create PROCEDURE [dbo].[spx_SourcingHistory_INSERT]
(@SourcingHeaderId uniqueidentifier,
@TeamId uniqueidentifier,
@CreatedDate datetime)
AS 


IF (SELECT COUNT(*) FROM pSourcingHistory WITH (NOLOCK) WHERE TeamID = @TeamID AND SourcingHeaderId = @SourcingHeaderId) = 0
	BEGIN
		INSERT INTO pSourcingHistory  (SourcingHeaderId, TeamID, CDate) VALUES ( @SourcingHeaderId, @TeamID, @CreatedDate)
	END
Else
	BEGIN
		UPDATE pSourcingHistory SET  CDate = @CreatedDate WHERE SourcingHeaderId = @SourcingHeaderId AND TeamID = @TeamID
	END

BEGIN
	DELETE FROM pSourcingHistory WHERE TeamID = @TeamID AND  SourcingHeaderId NOT IN (SELECT TOP 9 SourcingHeaderId From pSourcingHistory WITH (NOLOCK) WHERE TeamID = @TeamID ORDER BY CDate DESC)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05562', GetDate())
GO