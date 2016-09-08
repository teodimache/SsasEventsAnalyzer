﻿/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF( '$(flg_xevent_decode_load)' = 1 )
BEGIN;
	EXEC stg.LoadxEventDecode @filepath_TraceDefinitinion = '$(xevent_decode_source_filepath)';
END
;
IF( '$(flg_create_sql_agent_jobs)' = 1 )
BEGIN;
	:r .\SQLAgentJobs\Start-xEventQueryTrace.sql
	:r .\SQLAgentJobs\Stop-xEventQueryTrace.sql
	:r .\SQLAgentJobs\Start-xEventProcessTrace.sql
	:r .\SQLAgentJobs\Stop-xEventProcessTrace.sql
END
;