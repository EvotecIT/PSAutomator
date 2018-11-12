Add-Type -TypeDefinition @"
    using System;

    namespace PSAutomator
    {
        [Flags]
        public enum TriggerUserAzureAD {
            All,

            ByFields,
            //ByCountry,
            //ByCity,
            //ByDepartment,
            //ByState,
            //ByTitle,
            //ByUsageLocation,

            Deleted,
            Domain,

            //HasErrors,

            Unlicensed,
            UserPrincipalName,

            Search,
            Synchronized
        }
    }
"@