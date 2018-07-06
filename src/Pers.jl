module Pers

export Per,+,-

struct Per

    id::String
    year::Int64
    month::Int64
    last_day::Date

end

function Per(s::String)

    @assert length(s)==7 "Date String Wrong size, correct format -> yyyy-mm"
    @assert s[5]=='-' "Date String incorrect format, correct format -> yyyy-mm"
    @assert parse(Int64,s[6:7])<=12 "Date String incorrect format, month > 12, correct format -> yyyy-mm"

    year=parse(Int64,s[1:4])
    month=parse(Int64,s[6:7])

    return Per(s,year,month,Dates.lastdayofmonth(Date(year,month,1)))

end

Per(d::Date)=Per(string(Dates.year(d))*"-"*(("0"*string(Dates.month(d)))[end-1:end]),Dates.year(d),Dates.month(d),Dates.lastdayofmonth(d))

import Base.+
import Base.-
Base.:+(p1::Per, i::Int)=Per(p1.last_day+Base.Dates.Month(i))
Base.:+(i::Int,p1::Per)=Per(p1.last_day+Base.Dates.Month(i))

Base.:-(p1::Per, i::Int)=Per(p1.last_day-Base.Dates.Month(i))
Base.:-(p1::Per, p2::Per)=(p1.year-p2.year)*12+(p1.month-p2.month)



end # module
