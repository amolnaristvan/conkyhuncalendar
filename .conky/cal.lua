#!/usr/bin/env lua

conky_color = "${color1}%2d${color}"

t = os.date('*t', os.time())
year, month, currentday = t.year, t.month, t.day

daystart = os.date("*t",os.time{year=year,month=month,day=7}).wday

month_name = os.date("%B")

if     month_name == "January"   then month_hu = "Január"
elseif month_name == "February"  then month_hu = "Február"
elseif month_name == "March"     then month_hu = "Március"
elseif month_name == "April"     then month_hu = "Április"
elseif month_name == "May"       then month_hu = "Május"
elseif month_name == "June"      then month_hu = "Június"
elseif month_name == "July"      then month_hu = "Július"
elseif month_name == "August"    then month_hu = "Augusztus"
elseif month_name == "September" then month_hu = "Szeptember"
elseif month_name == "October"   then month_hu = "Október"
elseif month_name == "November"  then month_hu = "November"
elseif month_name == "December"  then month_hu = "December"
end



days_in_month = {
    31, 28, 31, 30, 31, 30, 
    31, 31, 30, 31, 30, 31
}

-- check for leap year
-- Any year that is evenly divisible by 4 is a leap year
-- Any year that is evenly divisible by 100 is a leap year if
-- it is also evenly divisible by 400.
LeapYear = function (year)
    return year % 4 == 0 and (year % 100 ~= 0 or year % 400 == 0)
end

if LeapYear(year) then
    days_in_month[2] = 29
end

title_start = (20 - (string.len(month_hu) + 5)) / 2

title = string.rep(" ", math.floor(title_start+0.5)) .. -- add padding to center the title
        (" %s %s\n  H  K Sz Cs P  Sz  V\n"):format(year, month_hu)

io.write(title)

function seq(a,b)
    if a > b then
        return
    else
        return a, seq(a+1,b)
    end 
end

days = days_in_month[month]

io.write(
    string.format(
        string.rep("   ", daystart-1) ..
        string.rep(" %2d", days), seq(1,days)
    ):gsub(string.rep(".",21),"%0\n")
     :gsub(("%2d"):format(currentday),
           (conky_color):format(currentday),
           1
     ) .. "\n"
)
