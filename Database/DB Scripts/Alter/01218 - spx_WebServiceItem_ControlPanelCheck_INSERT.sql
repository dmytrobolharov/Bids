-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 1 March 2011                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_WebServiceItem_ControlPanelCheck_INSERT') 
DROP PROCEDURE spx_WebServiceItem_ControlPanelCheck_INSERT
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE spx_WebServiceItem_ControlPanelCheck_INSERT
(
@CreatedBy nvarchar(200) = NULL,
@CreatedDate datetime = NULL
)
AS
BEGIN
	DECLARE @I as int
	DECLARE @Row_Count int

	DECLARE @WebServiceID uniqueidentifier

	DECLARE @ControlPanelID int
	DECLARE @ControlPanelName nvarchar(50)
	DECLARE @ControlPanelTypeID uniqueidentifier
	DECLARE @WebServiceItemID uniqueidentifier


	---------------------------------------------------
	-- Get the ID for the Control Panel web service. --
	---------------------------------------------------
	SET @WebServiceID = NULL

	SELECT @WebServiceID = WebServiceID 
	FROM sWebService
	WHERE WebServiceName = 'Control Panel'

	IF @WebServiceID IS NOT NULL
	BEGIN
		--------------------------------------------------------------------
		-- Start adding any Control Panel items that don't exist already. --
		--------------------------------------------------------------------
		CREATE TABLE #TempWebServiceItem (
			Id int IDENTITY (1, 1) NOT NULL , 
			ControlPanelID int NOT NULL,
			ControlPanelName nvarchar(200) NULL,
			ControlPanelTypeID uniqueidentifier NULL,
			WebServiceItemID uniqueidentifier NULL
		) 

		BEGIN
			INSERT INTO #TempWebServiceItem (ControlPanelID, ControlPanelName, ControlPanelTypeID, WebServiceItemID)
			SELECT cp.ControlPanelID, cp.ControlPanelName, cp.ControlPanelTypeID, wsi.WebServiceItemID
			FROM pControlPanel cp LEFT OUTER JOIN sWebServiceItem wsi ON cp.ControlPanelName = wsi.WebServiceItemName
		END


		SET @I = 1
		SET @Row_Count = (SELECT COUNT(*) FROM #TempWebServiceItem)

		WHILE @I <= @Row_Count 
		BEGIN
			SELECT @ControlPanelID = ControlPanelID, 
				   @ControlPanelName = CAST(ControlPanelName AS nvarchar(200)), 
				   @ControlPanelTypeID = ControlPanelTypeID, 
				   @WebServiceItemID = WebServiceItemID 
			  FROM #TempWebServiceItem WHERE ID = @I

			IF @WebServiceItemID IS NULL
			BEGIN
				INSERT INTO sWebServiceItem(WebServiceID, WebServiceItemName, Active, CUser, CDate)
				VALUES (@WebServiceID, @ControlPanelName, 1, @CreatedBy, @CreatedDate)
			END

			SET @I = @I + 1
		END



		--------------------------------------------------------------
		-- Now delete items that are no longer Control Panel items. --
		--------------------------------------------------------------
		CREATE TABLE #TempControlPanel (
			Id int IDENTITY (1, 1) NOT NULL, 
			WebServiceID uniqueidentifier NOT NULL,
			WebServiceItemID uniqueidentifier NOT NULL,
			ControlPanelID int NULL
		) 

		BEGIN
			INSERT INTO #TempControlPanel(WebServiceID, WebServiceItemID, ControlPanelID)
			SELECT wsi.WebServiceID, wsi.WebServiceItemID, cp.ControlPanelID
			FROM sWebServiceItem wsi LEFT OUTER JOIN pControlPanel cp ON wsi.WebServiceItemName = cp.ControlPanelName
			WHERE wsi.WebServiceID = @WebServiceID
			AND cp.ControlPanelID IS NULL
		END


		SET @I = 1
		SET @Row_Count = (SELECT COUNT(*) FROM #TempControlPanel)

		WHILE @I <= @Row_Count 
		BEGIN
			SELECT @WebServiceItemID = WebServiceItemID 
			  FROM #TempControlPanel WHERE ID = @I

			IF @WebServiceItemID IS NOT NULL
			BEGIN
				DELETE FROM sWebServiceItem
				WHERE WebServiceItemID = @WebServiceItemID
				
				DELETE FROM sAccessWebServiceItem
				WHERE WebServiceItemID = @WebServiceItemID
			END

			SET @I = @I + 1
		END
	END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01218', GetDate())
GO
