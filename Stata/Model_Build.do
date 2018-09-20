////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//Half-yearly model


////////////////////////////////////////////////
// Import and Prep
insheet using ~/Documents/College/Comps/Data/H-FINALDATA_1.csv
gen halfyear = halfyearly(halfyear2, "YH")
tsset halfyear, h
gen lnsempr = ln(sempr)
gen lnunemp = ln(unemp)

// (Run this once, then comment it out)
set more off, permanent


////////////////////////////////////////////////
//Exploratory Graphs
twoway (line unemp halfyear)
twoway (line sempr halfyear)


////////////////////////////////////////////////
///DICKEY-FULLER TESTS

//UNEMP
twoway (line unemp halfyear) (lfit unemp halfyear)
dfuller unemp, lag(1) trend regress //0.1347
dfuller unemp, lag(2) trend //0.0010
dfuller unemp, lag(3) trend //0.1997
dfuller unemp, lag(4) trend  //0.0137

// This is the one
dfuller unemp, lag(3) trend //0.0721


//SEMPR
dfuller sempr, lag(1) trend //0.3872
dfuller sempr, lag(2) trend //0.1362
dfuller sempr, lag(4) trend //0.1372

// This is the one
dfuller sempr, lag(4) trend regress //0.7162


//YES, there is a unit root, so...

//CHECK FOR COINTEGRATION
regress unemp sempr
predict e, resid
twoway (line e halfyear) (lfit e halfyear)


///
//SIGNIFICANT
dfuller e, lags(4) trend //0.0049
//NOT SIGNIFICANT
dfuller sempr, lag(4) trend //0.1372
dfuller unemp, lag(4) trend //0.0137
///


dfuller e, lags(14)  trend regress
dfuller e, lags(10)  trend regress
dfuller e, lags(8)  trend regress
dfuller e, lags(6)  trend regress
dfuller e, lags(4)  trend regress
dfuller e, lags(2)  trend regress
//YES coint (with -3.5 cutoff)
//
//( Note: if yes sig, then yes coint)


//////////////////////////////////
//YES COINTEGRATION, so run it in levels
//////////////////////////////////


var lnunemp lnsempr, lags(1/28)


//IRF Creation
irf create test, order(lnsempr lnunemp) step(60) set(blah, replace)


//IRF Graph US
irf graph oirf, impulse(lnunemp) response(lnsempr)
irf ctable (test lnunemp lnsempr oirf), stderror


//IRF Graph SU
irf graph oirf, impulse(lnsempr) response(lnunemp)
irf ctable (test lnsempr lnunemp oirf), stderror

// Note: IRFs are robust to different ordering of variables


//Granger
vargranger


//Stability Test

//Find size of IRF impulses
irf ctable (test lnsempr lnsempr oirf), stderror //.014453
irf ctable (test lnunemp lnunemp oirf), stderror //.046791 


//Find Covariance
predict Ures, res equation(lnunemp)
predict Sres, res equation(lnsempr)
correlate Ures Sres, covariance //0.000039
//OR
matlist e(Sigma) //0.0000389

//////////////////////////////////
//Extra stuff
/////////////

corrgram lnunemp, lags(30) //11 (first non-autocorrelated)
corrgram lnsempr, lags(40) //34

ac lnunemp, lags(30) //
ac lnsempr, lags(40) //

pac lnunemp, lags(30) //
pac lnsempr, lags(40) //





////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

//Yearly model

//Run in levels bc of halfyearly coint

// Clear everything, start over for 2nd model
clear all
//
//
//

////////////////////////////////////////////////////////////////
//Import data, prep
//Annual data for this one
insheet using ~/Documents/College/Comps/Data/Q-FINALDATA_1.csv
gen qdate2 = quarterly(qdate, "YQ")
tsset qdate2, q
gen year2 = yofd(dofq(qdate2)) 
collapse (mean) unemp (mean) semp (mean) employment (mean) sempr, by(year2) 
tsset year2, y
gen lnsempr = ln(sempr)
gen lnunemp = ln(unemp)


//14 years
var lnunemp lnsempr, lags(1/14)
varstable
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(sig)
vargranger
//both(sig)



////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
//Quarterly Model

//
clear all
//
//


////////////////////////////////////////////////////////////////
// Data import, prep
insheet using ~/Documents/College/Comps/Data/Q-FINALDATA_1.csv
gen qdate2 = quarterly(qdate, "YQ")
tsset qdate2, q
gen lnsempr = ln(sempr)
gen lnunemp = ln(unemp)

//14 years
var lnunemp lnsempr, lags(1/56)
varstable
irf create test, order(lnsempr lnunemp) step(80) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(sig)
vargranger
//both(sig)// 
