-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 28 April 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS


update sSystemCulture
set DateShortFormat='d',
DateLongFormat='D',
TimeShortFormat='t',
TimeLongFormat='T',
DateTimeShortFormat='g',
DateTimeLongFormat='G',
PercentFormat='{0:p}',
PercentValidationRegEx='[0-9]+[.]?[0-9]*',
DecimalFormat='0.000'

where CultureCountry='United States'
GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01414', GetDate())
GO