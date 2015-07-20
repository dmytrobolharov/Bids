
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleDetailForm_DELETE]
(@StyleDetailFormID uniqueidentifier)
AS 

DECLARE @StyleDetailFormMasterID uniqueidentifier
SELECT @StyleDetailFormMasterID = StyleDetailFormMasterID FROM pStyleDetailForm WITH (NOLOCK) WHERE StyleDetailFormID  = @StyleDetailFormID 

DELETE FROM pStyleDetailForm WHERE (StyleDetailFormMasterID = @StyleDetailFormMasterID)