****WWS594p Political Comm Paper*******
* Spring 2019			      *
* Author: William Willoughby          *
* Email: william.willoughby@gmail.com *
***************************************

clear all
cd E:\
set more off
ssc install ciplot 

*open dataset
use "political.dta", clear
set scheme sj 
*clean data
tab pct_change_followers
/*gen pct_change=real(pct_change_followers) */
tab pct_change

/*gen interaction=.
replace interaction=(day_from_event*video)*/

ciplot pct_change, by( day_from_event)
ciplot pct_change video , by( day_from_event) 



*Important
reg pct_change day_from_event video interaction followers_today, r
reg pct_change day_from_event video interaction, r

reg pct_change_followers day_from_event##watch followers_today, r


sort day_from_event
scatter pct_change day_from_event


twoway scatter pct_change day_from_event ///
  || lfitci pct_change day_from_event if day_from_event<0 & video==0 , color(gray%40) ///
  ||  lfitci pct_change day_from_event if day_from_event<0 & video==1 , color(gray%40) ///
  ||  lfitci pct_change day_from_event if day_from_event>=0 & video==0, color(gray%40) ///
  || lfitci pct_change day_from_event if day_from_event>=0 & video==1, color(gray%40)
  
twoway scatter pct_change day_from_event ///
  || lfitci pct_change day_from_event if day_from_event<0 , color(gray%40) ///
  ||  lfitci pct_change day_from_event if day_from_event>=0, color(gray%40)

  
  
 /*gen watch_r=watch/followers*/
 
twoway scatter pct_change watch_r if day_==1  
  
twoway scatter pct_change watch_r if day_==1 || lfitci pct_change watch_r if day_==1

gen follower_increase=real(follower_inc )

*Import
ssc instal sepscatter
sepscatter follower_increase day_from_event, separate(video)



twoway scatter watch follower_increase if day_==1 || lfit watch follower_increase if day_==1

twoway scatter follower_increase day_from_event, mcolor("120") if video==0 ///
  || lfit follower_increase day_from_event if day_from_event<0 & video==0 ///
  ||  lfit follower_increase day_from_event if day_from_event<0 & video==1 ///
  ||  lfit follower_increase day_from_event if day_from_event>=0 & video==0 ///
  || lfit follower_increase day_from_event if day_from_event>=0 & video==1
