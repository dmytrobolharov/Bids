/****** Object:  StoredProcedure [dbo].[spx_CommitmentHistory_INSERT]    Script Date: 01/31/2013 15:52:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CommitmentHistory_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CommitmentHistory_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_CommitmentHistory_INSERT]    Script Date: 01/31/2013 15:52:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_CommitmentHistory_INSERT]
(@CommitmentItemId uniqueidentifier,
@StyleID uniqueidentifier,
@TeamId uniqueidentifier,
@CreatedDate datetime)
AS 


IF (SELECT COUNT(*) FROM hCommitmentHistory WITH (NOLOCK) WHERE TeamID = @TeamID AND StyleId = @StyleId AND CommitmentItemId = @CommitmentItemId) = 0
	BEGIN
		INSERT INTO hCommitmentHistory  (CommitmentItemId, styleid, TeamID, CDate) VALUES (@CommitmentItemId, @StyleID, @TeamId, @CreatedDate)
	END
Else
	BEGIN
		UPDATE hCommitmentHistory SET  CDate = @CreatedDate WHERE StyleID = @StyleID AND TeamID = @TeamID AND CommitmentItemId = @CommitmentItemId
	END

BEGIN
	DELETE FROM hCommitmentHistory WHERE TeamID = @TeamID AND  CommitmentItemId NOT IN (SELECT TOP 20 CommitmentItemId From hCommitmentHistory WITH (NOLOCK) WHERE TeamID = @TeamID ORDER BY CDate DESC)
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04948', GetDate())
GO