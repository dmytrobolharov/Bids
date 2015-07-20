-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 07 March 2013                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_SampleRequestStyleColorwayTemp_INSERT') AND type in (N'P', N'PC'))
	DROP PROCEDURE spx_SampleRequestStyleColorwayTemp_INSERT
GO


CREATE PROCEDURE spx_SampleRequestStyleColorwayTemp_INSERT
(
	@SampleRequestGroupID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleColorID uniqueidentifier,
	@StyleSet nvarchar(10),
	@CreatedBy nvarchar(200),
	@CreatedDate nvarchar(100)
)
AS

DELETE FROM pSampleRequestStyleColorwayTemp WHERE StyleColorID = @StyleColorID AND SampleRequestGroupID = @SampleRequestGroupID AND StyleSet = @StyleSet AND StyleID = @StyleID

IF (SELECT COUNT(*) FROM pSampleRequestStyleColorwayTemp WITH (NOLOCK) WHERE StyleColorID = @StyleColorID AND SampleRequestGroupID = @SampleRequestGroupID AND StyleSet = @StyleSet AND StyleID = @StyleID)  = 0
BEGIN
	INSERT INTO pSampleRequestStyleColorwayTemp (SampleRequestGroupID, StyleColorID, StyleID, StyleSet, CUser, CDate, MUser, MDate, Submit)
	VALUES (@SampleRequestGroupID, @StyleColorID, @StyleID, @StyleSet, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, 1)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '0.5.0000', '05268', GetDate())
GO
