

//Testing lag order and granularity, with ln


////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
//Monthly
insheet using ~/Documents/College/Comps/Data/M-FINALDATA_1.csv
gen month2 = monthly(date, "YM")
tsset month2, m
drop year period date month
rename employmentlevel_lnu02000000 emp
rename unemploymentrate_lnu04000000 unemp
rename selfemployment_lnu02027714 semp
gen sempr2 = semp/emp
gen lnsempr = ln(sempr)
gen lnunemp = ln(unemp)

//1 year
var lnunemp lnsempr, lags(1/12)
irf create test, order(lnsempr lnunemp) step(160) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) but no decrease
vargranger
//US(sig) SU(sig)

//2 years
var lnunemp lnsempr, lags(1/24)
varstable
irf create test, order(lnsempr lnunemp) step(160) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase & decrease
vargranger
//US(sig@0.05) SU(sig)

//4 years
var lnunemp lnsempr, lags(1/48)
irf create test, order(lnsempr lnunemp) step(160) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase & decrease(notsig)
vargranger
//US(sig@0.1) SU(sig)

//6 years
var lnunemp lnsempr, lags(1/72)
irf create test, order(lnsempr lnunemp) step(160) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(notsig) and decrease(sig)
vargranger
//US(sig@0.1) SU(sig@0.005)

//
//
//
clear all
//
//
//



////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
//Quarterly
insheet using ~/Documents/College/Comps/Data/Q-FINALDATA_1.csv
gen qdate2 = quarterly(qdate, "YQ")
tsset qdate2, q
gen lnsempr = ln(sempr)
gen lnunemp = ln(unemp)

//1 year
var lnunemp lnsempr, lags(1/4)
irf create test, order(lnsempr lnunemp) step(64) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) but no decrease
vargranger
//both(sig)

//2 years
var lnunemp lnsempr, lags(1/8)
irf create test, order(lnsempr lnunemp) step(64) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) & decrease(sig)
vargranger
//US(sig@0.1) SU(sig@0.005)

//4 years
var lnunemp lnsempr, lags(1/16)
irf create test, order(lnsempr lnunemp) step(64) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) & decrease(NOTsig)
vargranger
//US(sig@0.1) SU(sig@0.005)

//6 years
var lnunemp lnsempr, lags(1/24)
irf create test, order(lnsempr lnunemp) step(64) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(notsig) and decrease(notsig)
vargranger
//US(sig@0.005) SU(sig@0.05)

//8 years
var lnunemp lnsempr, lags(1/32)
varstable
irf create test, order(lnsempr lnunemp) step(64) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(notsig) and decrease(notsig)
vargranger
//both(sig@0.1)

//10 years
var lnunemp lnsempr, lags(1/40)
varstable
irf create test, order(lnsempr lnunemp) step(64) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(notsig) and decrease(notsig)
vargranger
//both(sig)

//12 years
var lnunemp lnsempr, lags(1/48)
varstable
irf create test, order(lnsempr lnunemp) step(64) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Nothing
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(sig)
vargranger
//both(sig)

//14 years
var lnunemp lnsempr, lags(1/56)
varstable
irf create test, order(lnsempr lnunemp) step(64) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase BUT MUCH LATER???
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(sig)
vargranger
//both(sig)



//
//
//
clear all
//
//
//



////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
//Biannually
insheet using ~/Documents/College/Comps/Data/Q-FINALDATA_1.csv
gen qdate2 = quarterly(qdate, "YQ")
tsset qdate2, q
gen halfyear2 = hofd(dofq(qdate2)) 
collapse (mean) emp (mean) unemp (mean) semp (mean) sempr, by(halfyear) 
tsset halfyear2, h
gen lnsempr = ln(sempr)
gen lnunemp = ln(unemp)

//1 year
var lnunemp lnsempr, lags(1/2)
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(notsig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) & decrease(notsig)
vargranger
//Neither sig

//2 years
var lnunemp lnsempr, lags(1/4)
irf create test, order(lnsempr lnunemp) step(60) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) & decrease(sig)
vargranger
//US(notsig) SU(sig@0.05)

//4 years
var lnunemp lnsempr, lags(1/8)
irf create test, order(lnsempr lnunemp) step(60) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase
irf graph oirf, impulse(lnsempr) response(lnunemp)
irf ctable (test lnsempr lnunemp oirf), stderror
//Increase(sig) & decrease(notsig)
vargranger
//US(notsig) SU(sig@0.05)

//6 years
var lnunemp lnsempr, lags(1/12)
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(notsig)
vargranger
//NEITHER!

//8 years
var lnunemp lnsempr, lags(1/16)
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(notsig)
vargranger
//NEITHER!

//10 years
var lnunemp lnsempr, lags(1/20)
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(notsig) and decrease(sig)
vargranger
//Both(sig@0.005)

//12 years
var lnunemp lnsempr, lags(1/24)
varstable
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(notsig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(notsig)
vargranger
//both(sig)

//13 years
var lnunemp lnsempr, lags(1/26)
varstable
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(notsig) 
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(sig)
vargranger
//both(sig)

//Stable: 28
//Unstable: 30 34 36

//14 years
var lnunemp lnsempr, lags(1/28)
varstable
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig) **AFTER A LONG TIME***
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(sig)
vargranger
//both(sig)





//
//
//
clear all
//
//
//



////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
//Annually
insheet using ~/Documents/College/Comps/Data/Q-FINALDATA_1.csv
gen qdate2 = quarterly(qdate, "YQ")
tsset qdate2, q
gen year2 = yofd(dofq(qdate2)) 
collapse (mean) emp (mean) unemp (mean) semp (mean) sempr, by(year2) 
tsset year2, h
gen lnsempr = ln(sempr)
gen lnunemp = ln(unemp)

//1 year
var lnunemp lnsempr, lags(1)
irf create test, order(lnsempr lnunemp) step(20) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(notsig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) & decrease(notsig)
vargranger
//NEITHER

//2 years
var lnunemp lnsempr, lags(1/2)
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//NOTHING
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) & decrease(sig)
vargranger
//US(sig at 0.05); SU(notsig)

//4 years
var lnunemp lnsempr, lags(1/4)
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//NOTHING
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) & decrease(sig)
vargranger
//US(sig at 0.05); SU(notsig)

//6 years
var lnunemp lnsempr, lags(1/6)
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//decrease(notsig)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(notsig)
vargranger
//NEITHER!

//8 years
var lnunemp lnsempr, lags(1/8)
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//increase(NOTSIG&tiny) and decrease(NOTSIG&tiny)
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(notsig)
vargranger
//NEITHER!

//10 years
var lnunemp lnsempr, lags(1/10)
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//NA
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(notsig)
vargranger
//NEITHER!

//12 years
var lnunemp lnsempr, lags(1/12)
varstable
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//NOTHING
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(notsig)
vargranger
//both(sig@0.005)

//14 years
var lnunemp lnsempr, lags(1/14)
varstable
irf create test, order(lnsempr lnunemp) step(40) set(borkerino, replace)
irf graph oirf, impulse(lnunemp) response(lnsempr)
//Increase(sig) **AFTER 10 YEARS**
irf graph oirf, impulse(lnsempr) response(lnunemp)
//Increase(sig) and decrease(sig)
vargranger
//both(sig)


//Can't go above 14yrs or it becomes unstable
