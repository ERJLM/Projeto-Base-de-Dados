

table COMPANY
(
_CompanyId_, 
Name, 
IndustryId
)

table COMPANY_INDUSTRY
(
_CompanyId_ --> COMPANY.CompanyId, 
_IndustryId_ --> INDUSTRY.IndustryId
)

table BRANCH
(
_BranchId_,
Headquarter
CompanyId --> COMPANY.CompanyId, 
LocationId --> LOCATION.LocationId
)

table LAYOFF
(
_LayoffId_,
Name, 
BranchId --> BRANCH.BranchId, 
FundsRaised,
WorkersLaid, 
Percentage, 
Date
)

table COUNTRY
(
_CountryId_, 
Name
)

table LOCATION
(
_LocationId_, 
Name,
CountryId --> COUNTRY.CountryId
)

table INDUSTRY
(
_IndustryId_, 
Name
)
